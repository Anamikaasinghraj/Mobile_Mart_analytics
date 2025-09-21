CREATE TABLE phone_sales (
  id SERIAL PRIMARY KEY,
  brands VARCHAR(255),
  models VARCHAR(255),
  colors VARCHAR(255),
  memory VARCHAR(255),
  storage VARCHAR(255),
  camera VARCHAR(255),
  rating NUMERIC(3,2),
  selling_price INTEGER,
  original_price INTEGER,
  mobile VARCHAR(255),
  discount INTEGER,
  discount_percentage NUMERIC(5,2)
);

--data exploration

--count of rows
select count(*) from phone_sales;

-- viewing 10 rows
SELECT * FROM phone_sales LIMIT 10;

--null values
select * from phone_sales
where brands is null
or
models is null
or
colors is null
or
memory is null
or
storage is null
or
camera is null
or
rating is null
or
original_price is null
or
mobile is null
or
discount is null
or
discount_percentage is null;

--different product categories
select distinct brands
from phone_sales
order by brands;

-- revenue generate
SELECT SUM(selling_price) AS total_revenue FROM phone_sales;

-- units revenue per brands
SELECT brands,
       COUNT(*) AS units_sold,
       SUM(selling_price) AS total_revenue,
       ROUND(AVG(rating), 2) AS avg_rating
FROM phone_sales
GROUP BY brands
ORDER BY total_revenue DESC
LIMIT 10;


--Price range analysis
SELECT
  CASE
    WHEN selling_price < 5000 THEN 'Under 5k'
    WHEN selling_price BETWEEN 5000 AND 10000 THEN '5k-10k'
    WHEN selling_price BETWEEN 10001 AND 20000 THEN '10k-20k'
    ELSE '20k+'
  END AS price_range,
  COUNT(*) AS units,
  ROUND(AVG(rating), 2) AS avg_rating,
  SUM(selling_price) AS total_revenue
FROM phone_sales
GROUP BY price_range
ORDER BY total_revenue DESC;

--Best-selling model per brand 
SELECT DISTINCT ON (brands)
    brands,
    models,
    COUNT(*) AS units_sold
FROM phone_sales
GROUP BY brands, models
ORDER BY brands, units_sold DESC;

--Top 5 phones by rating
SELECT models, brands, rating, selling_price
FROM phone_sales
ORDER BY rating DESC, selling_price DESC
LIMIT 5;

--Average price
SELECT brands, ROUND(AVG(selling_price), 2) AS avg_price
FROM phone_sales
GROUP BY brands
ORDER BY avg_price DESC;

--Rating distribution
SELECT
    ROUND(rating) AS rating_group,
    COUNT(*) AS phones_count
FROM phone_sales
GROUP BY rating_group
ORDER BY rating_group;

--Final check: Show total revenue again
SELECT SUM(selling_price) AS total_revenue FROM phone_sales;