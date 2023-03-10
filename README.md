# Amazon_Vine_Analysis

## Overview

The client wants to see how paid versus unpaid reviews effect the overall rating of a product. In order to determine if there is bias we will be extracting, transforming, and loading a Amazon Product review dataset to see if there is a bias towards products if the reviewer was paid or not. This will be broken down by extracting the data and transforming part of it in PySpark then further filtering of the data with SQL. We will see how many paid and unpaid reviews there are and the percentage of five-star reviews each group leaves to see if there is a descrepancy leading to a bias review or not. 

## Results 

In Google Collab we download the dataset and used PySpark to filter the data set from null values and duplicates. Then we proceeded to upload the CSV file of the vine_table to PosGreSQL to finish filtering and transforming the data. 

![filtered_data_code](https://github.com/vanessaneang/Amazon_Vine_Analysis/blob/main/Resources/filtered_data_code.png)

Once the CSV file was uploaded into our PostGreSQL we opened a query to find only reviews that had a number of 20 or more total_votes so we can deal with more viewed reviews instead of all of them. After filtering it we then created another table to find reviews that were most helpful by filtering out results were the helpful_votes divided by the total_votes was equal to or greater than 50%. This gives us table that has reviews that are deemed most helpful by other users. See the two tables below for the resulting filtered table and good reviews table generated by the queries.

![filtered_table](https://github.com/vanessaneang/Amazon_Vine_Analysis/blob/main/Resources/filtered_data_table.png)

![good_review_table](https://github.com/vanessaneang/Amazon_Vine_Analysis/blob/main/Resources/good_review_table.png)

From the good_review table we will further break it down to paid and unpaid reviews by querying if the vine columns of the tables equals 'Y' for paid by vine or 'N' for unpaid reviews. 

![unpaid_paid_code](https://github.com/vanessaneang/Amazon_Vine_Analysis/blob/main/Resources/unpaid_paid_code.png)

The resulting tables for the paid vine reviews reults in **22 total paid reviews** while the number of **unpaid reviews is 26,987**. See the following tables below for the paid and unpaid reviews.

![paid_reviews](https://github.com/vanessaneang/Amazon_Vine_Analysis/blob/main/Resources/paid_reviews.png)
![unpaid_reviews](https://github.com/vanessaneang/Amazon_Vine_Analysis/blob/main/Resources/unpaid_reviews.png)


![summary_table_code](https://github.com/vanessaneang/Amazon_Vine_Analysis/blob/main/Resources/summary_table_code.png)

By using PostGreSQL to generate a table that answers the following questions:

**1.) How many Vine reviews and non-Vine reviews were there?**
There are 22 Vine reviews and 26,987 non-Vine reviews.

**2.) How many Vine reviews were 5 stars? How many non-Vine reviews were 5 stars?** 
The amount of 5 star paid reviews are 13, while the number of unpaid reviews is 14,475.

**3.) What percentage of Vine reviews were 5 stars? What percentage of non-Vine reviews were 5 stars?**
Both paid and unpaid reviews has about a 50% percentage of 5 star reviews, paid reviews has a 59% of 5 star reviews and unpaid reviews has 54% of 5 star reviews. It looks like there is a slight bias with the paid reviews by about 5%. 

![summary_table](https://github.com/vanessaneang/Amazon_Vine_Analysis/blob/main/Resources/summary_table.png)

## Summary 

There is a slight positivity bias for reviews in the Vine program, by looking at the summary table, there is about 5% more 5 star reviews for the paid reviews over the unpaid reviews. Since for the specific dataset chosen there is not enough data points for paid reviews since there is only a total of 22 views it would be better to chose a dataset that has more paid reviews to see if there is truly a positivity bias. In order to further see if there is a bias it would be useful to use the dataset with more paid reviews with a similar comparison to find how many 5 star reviews there are. Another analysis that would further the analysis would be finding what types of products have more paid reviews, which may lead to a trend of which industry targets more paid reviews and which has the higher rate of helpful reviews vs total votes (% over 70 could be a good indicator). This would help investors to determine which products are high qualtiy and what industries are more sucessful with their paid reviews.




