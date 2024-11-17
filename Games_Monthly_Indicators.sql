---------------------------------- MATERIALIZED VIEW ----------------------------------
-------------------------- exported to Tableau as a CSV file --------------------------

CREATE MATERIALIZED VIEW games_payments_users AS
WITH first_last_payment AS (
SELECT
	user_id,
	DATE(date_trunc('month', payment_date)) AS payment_month,
	revenue_amount_usd,
	MIN(payment_date) OVER (PARTITION BY user_id ORDER BY payment_date) AS first_payment,
	MAX(payment_date) OVER (PARTITION BY user_id ORDER BY payment_date DESC) AS last_payment
FROM
	games_payments gp
),
month_revenue AS (
SELECT
	user_id,
	payment_month,
	MAX(CASE
			WHEN payment_month = DATE(date_trunc('month', first_payment)) THEN 1
			ELSE 0
		END) AS first_month,
	MAX(CASE
			WHEN payment_month = DATE(date_trunc('month', last_payment)) THEN 1
			ELSE 0
		END) AS last_month,
	CASE
		WHEN DATE_PART('month', age(
					LEAD(payment_month) OVER (PARTITION BY user_id ORDER BY payment_month),
					payment_month) 
			) > 1 THEN 1
		ELSE 0
	END AS month_off,
	SUM(revenue_amount_usd) AS month_revenue
FROM
	first_last_payment
GROUP BY
	user_id,
	payment_month
ORDER BY 
	user_id,
	payment_month
),
joined_data AS (
SELECT
	mr.user_id,
	payment_month,
	first_month,
	month_off,
	CASE
		WHEN (LAG(month_off) OVER (PARTITION BY mr.user_id ORDER BY payment_month)) = 1 THEN 1
		ELSE 0
	END AS return_month,
	last_month,
	month_revenue,
	CASE
		WHEN (LAG(month_off) OVER (PARTITION BY mr.user_id ORDER BY payment_month)) = 1 THEN 0
		ELSE COALESCE(month_revenue - LAG(month_revenue) OVER (PARTITION BY mr.user_id ORDER BY payment_month), 0)
	END AS revenue_change_mom,
	game_name,
	"language",
	has_older_device_model,
	age	
FROM
	month_revenue mr
LEFT JOIN
	games_paid_users gpu
ON 
	mr.user_id = gpu.user_id
ORDER BY 
	user_id,
	payment_month
)
SELECT
	*
FROM
	joined_data;



-------------------------------- METRICS CALCULATIONS ---------------------------------
---------------- transferred & adapted to Calculated Fields in Tableau ----------------

WITH metrics_calculations AS(
SELECT 
	payment_month,
	SUM(month_revenue) AS mrr,
	COUNT(DISTINCT(user_id)) AS paid_users,
	SUM(first_month) AS new_paid_users,
	SUM(CASE WHEN first_month = 1 THEN month_revenue ELSE 0 END) AS new_mrr,
	LAG(SUM(last_month)) OVER (ORDER BY payment_month) + LAG(SUM(month_off)) OVER (ORDER BY payment_month) AS churned_users,
	LAG(COUNT(DISTINCT(user_id))) OVER (ORDER BY payment_month) AS prev_month_paid_users,
	LAG(SUM(CASE WHEN last_month = 1 OR month_off = 1 THEN month_revenue
			ELSE 0 END)) OVER (ORDER BY payment_month) AS churned_revenue,
	SUM(return_month) AS reactivated_users,
	SUM(CASE WHEN return_month = 1 THEN month_revenue ELSE 0 END) AS reactivated_revenue,
	SUM(CASE WHEN revenue_change_mom > 0 THEN revenue_change_mom ELSE 0 END) AS expansion_mrr,
	SUM(CASE WHEN revenue_change_mom < 0 THEN revenue_change_mom ELSE 0 END) AS contraction_mrr
FROM
	games_payments_users gpu
GROUP BY
	payment_month
ORDER BY
	payment_month
)
SELECT
	payment_month,
	mrr,
	paid_users,
	mrr / paid_users AS arppu,
	new_paid_users,
	new_mrr,
	churned_users,
	churned_users / prev_month_paid_users::float AS churn_rate,
	churned_revenue,
	churned_revenue / (LAG(mrr) OVER (ORDER BY payment_month)) AS revenue_churn_rate,
	reactivated_users,
	reactivated_users / churned_users::float AS reactivation_rate,
	reactivated_revenue,
	reactivated_revenue / mrr AS revenue_reactivation_rate,
	expansion_mrr,
	ABS(contraction_mrr) AS contraction_mrr,
	1 / (churned_users / prev_month_paid_users::float) AS lt,
	(mrr / paid_users) * (1 / (churned_users / prev_month_paid_users::float)) AS ltv
FROM 
	metrics_calculations;