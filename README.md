# Tech-Instagram-Influencer-Analysis

This repository contains a detailed analysis of a Tech Instagram Influencer's account, focusing on key performance indicators (KPIs) such as engagement metrics, audience growth, and content performance. The analysis is based on three database tables that capture data on profile visits, followers, and content performance across different post types and categories.

🗂️ Project Overview
The project is structured into three main sections:

Database Tables:

dim_date: Contains date-related metadata (month name, week number, weekday/weekend flag).

fact_account: Stores account-level KPIs like profile visits and new followers.

fact_content: Stores content performance metrics for each post (e.g., impressions, reach, likes, comments, shares).

Key Questions & SQL Analysis:

The project involves answering specific business questions using SQL queries, including identifying top post types, calculating reach percentage, and filtering posts based on time periods.

Reports & Insights:

Extract actionable insights related to content strategy, audience growth, and engagement trends to optimize future content and maximize audience interactions.

⚡ Objectives
Identify high-performing content: Analyzing the effectiveness of different post types (e.g., IG video, carousel, reel) and categories (e.g., mobile, tech tips).

Audience growth analysis: Examining the correlation between post types and new followers.

Content optimization: Understanding engagement drivers (likes, comments, shares, saves) to refine posting strategy.

Performance trends: Identifying peak times for post engagement and follower acquisition (weekdays vs. weekends, month-wise trends).

📋 Project Structure
plaintext
Copy
Edit
├── sql_queries/               # SQL scripts for analysis
│   ├── query_1.sql            # Query to get unique post types
│   ├── query_2.sql            # Query to get highest and lowest impressions
│   └── ...
├── reports/                   # Generated reports (CSV, charts)
├── presentation/              # PowerPoint or Keynote presentation for live session
└── README.md                  # Project overview and instructions
💻 Installation
1. Database Setup
Import the gdb0120.sql file into MySQL Workbench to set up the database schema.

Load the data into your database to start running SQL queries and analyzing the content.

2. Run SQL Queries
Navigate to the sql_queries folder and run the SQL scripts to generate insights.

Each query is designed to answer a specific business question or produce a report.

3. Generate Reports
After running the SQL queries, export the data to CSV files or generate visualizations using tools like Power BI or Tableau.

📝 Key Insights & Metrics
This analysis aims to uncover actionable insights from Instagram activity, including:

Most engaging post types (Reels, Carousels, etc.)

Content categories driving the most likes, shares, and comments.

Audience growth trends based on profile visits and new followers.

Peak times for content engagement (weekends, certain months).
