-- 1. How many unique post types are found in the 'fact_content' table? 
SELECT 
    COUNT(DISTINCT post_type) AS unique_post_types
FROM fact_content;

-- 2. What are the highest and lowest recorded impressions for each post type? 
SELECT 
    post_type,
    MAX(impressions) AS highest_impressions,
    MIN(impressions) AS lowest_impressions
FROM fact_content
GROUP BY post_type;

-- 3. Filter all the posts that were published on a weekend in the month of March and April and export them to a separate csv file. 
SELECT f.*
FROM fact_content f
JOIN dim_dates d ON f.date = d.date
WHERE d.weekday_or_weekend = 'Weekend'
  AND d.month_name IN ('March', 'April');

-- 4. Create a report to get the statistics for the account. The final output includes the following fields: 
-- • month_name 
-- • total_profile_visits 
-- • total_new_followers 
SELECT 
    d.month_name,
    SUM(a.profile_visits) AS total_profile_visits,
    SUM(a.new_followers) AS total_new_followers
FROM fact_account a
JOIN dim_dates d ON a.date = d.date
GROUP BY d.month_name
ORDER BY FIELD(d.month_name, 'January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December');

-- 5. Write a CTE that calculates the total number of 'likes’ for each 'post_category' during the month of 'July' and subsequently, arrange the 'post_category' values in descending order according to their total likes. 
WITH likes_cte AS (
    SELECT 
        post_category,
        SUM(likes) AS total_likes
    FROM fact_content f
    JOIN dim_dates d ON f.date = d.date
    WHERE d.month_name = 'July'
    GROUP BY post_category
)
SELECT *
FROM likes_cte
ORDER BY total_likes DESC;

-- 6. Create a report that displays the unique post_category names alongside their respective counts for each month. The output should have three columns:  
-- • month_name 
-- • post_category_names  
-- • post_category_count 
-- Example:  
-- • 'April', 'Earphone,Laptop,Mobile,Other Gadgets,Smartwatch', '5' 
-- • 'February', 'Earphone,Laptop,Mobile,Smartwatch', '4' codebasics.io 
SELECT 
    d.month_name,
    GROUP_CONCAT(DISTINCT f.post_category ORDER BY f.post_category) AS post_category_names,
    COUNT(DISTINCT f.post_category) AS post_category_count
FROM fact_content f
JOIN dim_dates d ON f.date = d.date
GROUP BY d.month_name
ORDER BY FIELD(d.month_name, 'January', 'February', 'December');

-- 7. What is the percentage breakdown of total reach by post type?  The final output includes the following fields: 
-- • post_type 
-- • total_reach 
-- • reach_percentage 

WITH total_reach_cte AS (
    SELECT SUM(reach) AS overall_reach
    FROM fact_content
)
SELECT 
    post_type,
    SUM(reach) AS total_reach,
    ROUND((SUM(reach) / (SELECT overall_reach FROM total_reach_cte)) * 100, 2) AS reach_percentage
FROM fact_content
GROUP BY post_type;

-- 8. Create a report that includes the quarter, total comments, and total saves recorded for each post category. Assign the following quarter groupings: 
-- (January, February, March) → “Q1” 
-- (April, May, June) → “Q2” 
-- (July, August, September) → “Q3” 
-- The final output columns should consist of: 
-- • post_category 
-- • quarter 
-- • total_comments 
-- • total_saves 

SELECT 
    f.post_category AS post_category,
    CASE 
        WHEN d.month_name IN ('January', 'February', 'March') THEN 'Q1'
        WHEN d.month_name IN ('April', 'May', 'June') THEN 'Q2'
        WHEN d.month_name IN ('July', 'August', 'September') THEN 'Q3'
        WHEN d.month_name IN ('October', 'November', 'December') THEN 'Q4'
    END AS quarter,
    SUM(f.comments) AS total_comments,
    SUM(f.saves) AS total_saves
FROM fact_content f
JOIN dim_dates d ON f.date = d.date
GROUP BY post_category, quarter
ORDER BY quarter, post_category;

-- 9. List the top three dates in each month with the highest number of new followers. The final output should include the following columns: 
-- • month 
-- • date 
-- • new_followers

WITH ranked_followers AS (
    SELECT 
        d.month_name AS month,
        a.date,
        a.new_followers,
        ROW_NUMBER() OVER (PARTITION BY d.month_name ORDER BY a.new_followers DESC) AS Rankk
    FROM fact_account a
    JOIN dim_dates d ON a.date = d.date
)
SELECT 
    month,
    date,
    new_followers
FROM ranked_followers
WHERE rankk <= 3
ORDER BY FIELD(month, 'January', 'February','December'), new_followers DESC;
 
-- 10.  Create a stored procedure that takes the 'Week_no' as input and generates a report displaying the total shares for each 'Post_type'. The output of the procedure should consist of two columns: 
-- • post_type 
-- • total_shares

DELIMITER $$

CREATE PROCEDURE GetSharesByWeek(IN weekno INT)
BEGIN
    SELECT 
        f.post_type,
        SUM(f.shares) AS total_shares
    FROM fact_content f
    JOIN dim_dates d ON f.date = d.date
    WHERE d.week_no = weekno
    GROUP BY f.post_type;
END $$

DELIMITER ;
