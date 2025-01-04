CREATE database wm_db;
USE wm_db;
show tables;
SELECT count(*) FROM walmart;
SELECT * FROM walmart LIMIT 10;
SELECT COUNT(*) FROM walmart;
SELECT DISTINCT payment_method FROM walmart;
SELECT payment_method, 
COUNT(*)
FROM walmart
GROUP BY payment_method;
SELECT COUNT(DISTINCT Branch)
FROM walmart;
SELECT Branch, 
COUNT(*)
FROM walmart
GROUP BY Branch;
SELECT MAX(quantity) FROM walmart;
SELECT MIN(quantity) FROM walmart;

/*BUSINESS PROBLEMS*/
/* 1. Find different paymnet method and number of transaction,number of qty sold*/
SELECT payment_method,
COUNT(*) as no_payments,
SUM(quantity) as no_qty_sold
FROM walmart
GROUP BY payment_method;
/* 2. Identify the highest category in each branch, displaying the branch,category AVG RATING*/
SELECT DISTINCT
    Branch,
    category,
    AVG_Rating
FROM (
    SELECT
        Branch,
        category,
        AVG(rating) AS AVG_Rating,
        RANK() OVER (PARTITION BY Branch ORDER BY AVG(rating) DESC) AS rank_by_rating
    FROM walmart
    GROUP BY Branch, category
) AS ranked_categories
WHERE rank_by_rating = 1;
/* 3. IDENTIFY the busiest day for each branch based on the number of transacrions*/
SELECT date FROM walmart;
SELECT *
FROM (
    SELECT
        branch,
        DATE_FORMAT(date, '%W') AS day_name,
        COUNT(*) AS no_transactions,
        AVG(rating) AS avg_rating,
        RANK() OVER (PARTITION BY branch ORDER BY AVG(rating) DESC) AS rank_by_rating
    FROM walmart
    GROUP BY branch, day_name
) AS ranked_transactions
WHERE rank_by_rating = 1;
/* 4. Calculate the total quantity of items sold per payment method.List payment_method and total_quantity. */
SELECT payment_method,
COUNT(*) as no_payments
FROM walmart
GROUP BY payment_method;
/*5. Determine the average ,minimum,maximum rating of the products for each city list the city,average_rating,min_rating,and max_rating*/
SELECT city,
category,
MIN(rating) as min_rating,
MAX(rating) as max_rating,
AVG(rating) as avg_rating
FROM walmart 
GROUP BY city,category;
/*6. Calculate th eprofit for each category by considering total_profit as (unit_price * quantity*profit_margin).list category and total_profit.ordered from highest to lowest profit*/
SELECT
category,
SUM(total*profit_margin) as profit
FROM walamrt
GROUP BY category;
/*7 Determine the most common paymnet method for each branch.Display the branch and the prefer_paymnet_method */
SELECT 
    branch,
    payment_method,
    COUNT(*) AS total_trans
FROM walmart
GROUP BY branch, payment_method
ORDER BY branch, total_trans DESC;





