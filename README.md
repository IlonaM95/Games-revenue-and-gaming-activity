# Games revenue and gaming activity
***Analysis of the company's financial flows and players' activity (PostgreSQL, Google Sheets, Tableau Public)***
<br>
<br>

# GAMES – Revenue metrics

### Overview
The primary objective of this project was to create a dashboard for analyzing financial flows. This dashboard enables product managers to track the dynamics of financial flows and analyze the factors driving these changes.

[Link to dashboard in Tableau Public](https://public.tableau.com/views/Games-PerformanceIndicatorsv_2/Dashboard1?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)

![GAMES_Revenue_Metrics_Tableau](https://github.com/user-attachments/assets/3d5733a0-e1a1-4e09-9c5b-3279d59ff50f)


### Steps:
### 1. Initial Analysis in Google Sheets:
- Conducted a preliminary analysis of two CSV files in Google Sheets.
- Calculated metrics for individual games.

[Link to Google Sheets](https://docs.google.com/spreadsheets/d/1Zk0CgAU98rIYNjq0du6A82I8CI9DSfojWtZvPZnYCTw/edit?usp=sharing)

![GAMES_Revenue_Metrics_Google](https://github.com/user-attachments/assets/8e9dfdad-47ff-44c3-8a9d-3d63f0f875d4)


### 2. Data Preparation in PostgreSQL:
- Prepared the table from the two CSV files in PostgreSQL (DBeaver) - SQL queries are included in the repository.
- Exported the table to Tableau and calculated all necessary metrics.
- Adjusted and integrated these metrics into calculated fields in Tableau.

![GAMES_Revenue_Metrics_SQL_1](https://github.com/user-attachments/assets/f8e6c68e-7f42-4a51-bc52-aad1b3b93c92)

![GAMES_Revenue_Metrics_SQL_2](https://github.com/user-attachments/assets/1f188a47-338d-4ffb-9cc4-a6fc25ffc371)
![GAMES_Revenue_Metrics_SQL_3](https://github.com/user-attachments/assets/44439576-7ea7-4c41-8bf6-43a964132a1b)


### 3. Dashboard Creation in Tableau:
After preparing the necessary calculations and visualizations in Worksheets, created the dashboard.
**Dashboard features:**
The dashboard includes the following metrics:
- Monthly Recurring Revenue (MRR)
- Paid Users
- Average Revenue Per Paid User (ARPPU)
- New MRR
- New Paid Users
- Churned Users, Churn Rate
- Churned Revenue, Revenue Churn Rate
- Reactivated Users, Reactivation Rate
- Reactivated Revenue, Revenue Reactivation Rate
- Expansion MRR, Contraction MRR
- Customer Lifetime (LT), Customer Lifetime Value (LTV)

Graphs related to MRR and Paid Users show what affects revenue and paying users' changes from month to month.
The dashboard also includes date, language, and user age filters, as well as the ability to select metrics (by month and age group) displayed as a heat map.

<br>

---

<br>

# Monthly gaming activity

For an analogous dataset that also includes user activity time on specific days (data for different users but from the same gaming company), a cohort analysis was conducted, and DAU (Daily Active Users) and WAU (Weekly Active Users) were calculated.
### 1. Forecasted DAU and WAU for the next 20 weeks using linear regression in Google Sheets.
### 2. Created the dashboard in Tableau for this dataset as well.

<br>

[Link to dashboard in Tableau Public](https://public.tableau.com/views/Gamingactivity2/Dashboard?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)

![Gaming_activity_Tableau](https://github.com/user-attachments/assets/54fce2e2-bc4b-4d7d-b99a-9b84fd5390c8)


[Link to Google Sheets](https://docs.google.com/spreadsheets/d/1Eg7VvbyZn5sdQeGKsvbYFfAGQAcXW1lIZgRt75e4bNY/edit?usp=sharing)

![Gaming_activity_2](https://github.com/user-attachments/assets/b590b0e2-6ade-49d6-8ef8-088aa2596e86)

![Gaming_activity_1](https://github.com/user-attachments/assets/ffb2e501-c5ef-4e71-a7c0-86cb3719a5f8)

![Gaming_activity_3](https://github.com/user-attachments/assets/1857066e-1b7f-476a-ad3a-4f11ceac6395)

![Gaming_activity_4](https://github.com/user-attachments/assets/36ad53c5-7f2d-4450-80ec-352270d8b1fa)

