/*In this project, I created a store that sells shoes. I needed to create a table for all of the items sold by my store, and at least 5 columns of data that I believed is necessary to store.
I had to insert 15 items, and use select statements to order your items by price and show at least one statistic about the items. See my work below. */

CREATE TABLE sneaker_store(id INTEGER PRIMARY KEY, shoe_type TEXT, brand TEXT, size INTEGER, price INTEGER);
/* Create table for sneaker store with columns for id, shoe type, brand, size, and price */

INSERT INTO sneaker_store VALUES (1, "basketball", "nike", 14, 110);
INSERT INTO sneaker_store VALUES (2, "basketball", "adidas", 12, 105);
INSERT INTO sneaker_store VALUES (3, "casual", "nike", 7, 120);
INSERT INTO sneaker_store VALUES (4, "basketball", "puma", 11, 100);
INSERT INTO sneaker_store VALUES (5, "basketball", "nike", 10, 140);
INSERT INTO sneaker_store VALUES (6, "casual", "puma", 15, 85);
INSERT INTO sneaker_store VALUES (7, "casual", "adidas", 11, 95);
INSERT INTO sneaker_store VALUES (8, "basketball", "under armour", 12, 110);
INSERT INTO sneaker_store VALUES (9, "basketball", "under armour", 13, 100);
INSERT INTO sneaker_store VALUES (10, "casual", "adidas", 12, 85);
INSERT INTO sneaker_store VALUES (11, "basketball", "puma", 9, 100);
INSERT INTO sneaker_store VALUES (12, "casual", "nike", 8, 85);
INSERT INTO sneaker_store VALUES (13, "casual", "puma", 10, 70);
INSERT INTO sneaker_store VALUES (14, "basketball", "adidas", 10, 130);
INSERT INTO sneaker_store VALUES (15, "basketball", "under armour", 14, 130);
/* Insert data into the table with values for corresponding columnns */

SELECT * FROM sneaker_store
ORDER BY price DESC;
/* select all columns from the table and order by price (greatest to smallest)


SELECT brand, ROUND(AVG(price),2) AS average_price FROM sneaker_store 
GROUP BY brand 
ORDER BY average_price DESC; 
--select brand and create average price column, group by brand, set prices from greatest to smallest


