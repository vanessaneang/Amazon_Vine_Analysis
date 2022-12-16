
--Create table
CREATE TABLE vine_table (
review_id VARCHAR(60) PRIMARY KEY,
star_rating INTEGER,
helpful_votes INTEGER,
	total_votes INTEGER,
	vine VARCHAR(1),
	verified_purchase VARCHAR(1)
);

SELECT * FROM vine_table

--Filter Data and create new dataframe to retrieve all rows where
--total_votes count is equal or greater than 20-
DROP TABLE filtered_reviews

CREATE TABLE filtered_reviews
AS
SELECT *
FROM vine_table
WHERE total_votes >= 20

SELECT * FROM filtered_reviews

--Filter new dataframe and create new tabe where helpful_votes dived by total_votes
-- =>50%

CREATE TABLE good_reviews
AS
SELECT *
FROM filtered_reviews
WHERE CAST(helpful_votes AS FLOAT)/CAST(total_votes AS FLOAT) >=0.5

SELECT * FROM good_reviews

--find paide vine reviews (vine = 'y')

CREATE TABLE paid_vine_reviews
AS
SELECT *
FROM good_reviews
WHERE vine = 'Y'

SELECT * FROM paid_vine_reviews

--find unpaid reviews (vine = 'n')

CREATE TABLE unpaid_reviews
AS
SELECT *
FROM good_reviews
WHERE vine = 'N'

SELECT * FROM unpaid_reviews

--Find total number of reviews, number of 5 star ratings, percentage of 5 star ratings for paid/unpaid reviews


CREATE TABLE paid_summary
AS
SELECT 
	COUNT(review_id) as total_number_of_reviews,
	COUNT(star_rating = 5) as number_of_5_stars_ratings,
	COUNT(star_rating = 5)/COUNT(star_rating)*100 as percent_of_5_stars
FROM paid_vine_reviews	

SELECT * FROM paid_summary

--Confirm the number of 5 star reviews for paid vine reviews
SELECT COUNT (*) AS "5-star paid reviews"
FROM paid_vine_reviews
WHERE star_rating=5;

--Confirm the number of 5 star reviews for unpaid vine reviews
SELECT COUNT (*) AS "5-star unpaid reviews"
FROM unpaid_reviews
WHERE star_rating=5;

--Convert to percentage
SELECT COUNT (*) AS "5-star Reviews",
CASE 
	WHEN vine='Y' THEN (SELECT COUNT (*) FROM good_reviews WHERE vine='Y')
	WHEN vine='N' THEN (SELECT COUNT (*) FROM good_reviews WHERE vine='N')
END AS "Total Reviews",
CAST(CAST(COUNT(review_id) AS FLOAT)/CAST(CASE 
	WHEN vine='Y' THEN (SELECT COUNT (*) FROM good_reviews WHERE vine='Y')
	WHEN vine='N' THEN (SELECT COUNT (*) FROM good_reviews WHERE vine='N')
END AS FLOAT) AS DEC(2,2)) AS "Percentage"
FROM good_reviews
WHERE star_rating=5
GROUP BY vine
ORDER BY vine DESC;

SELECT * FROM summary_table

ALTER TABLE summary_table
ADD "Review Type" VARCHAR(20) DEFAULT 'Unpaid Review'


UPDATE summary_table
SET "Review Type" = 'Paid Review'
WHERE "5-star Reviews" = 13
