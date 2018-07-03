
--1. What are the #prods whose name begins with a 'p' and are less than $300.00?
SELECT prod_id FROM product WHERE prod_id LIKE 'p%' AND price < 300;

-- 2. Names of the Products stocked in ”d2”.
--(a) without in/not in
SELECT pname FROM product P, stock S WHERE P.prod_id = S.prod_id AND dep_id = 'd2';

--(b) with in/not in
SELECT pname FROM product WHERE prod_id IN (SELECT prod_id FROM stock WHERE dep_id = 'd2');

--3. #prod and names of the products that are out of stock.
--(a) without in/not in
SELECT P.prod_id, pname FROM product P, stock S WHERE P.prod_id = S.prod_id AND quantity <= 0;

--(b) with in/not in
SELECT prod_id, pname FROM product WHERE prod_id IN (SELECT prod_id FROM stock WHERE quantity <=0);

--4. Addresses of the depots where the product ”p1” is stocked.
--(a) without exists/not exists and without in/not in 
SELECT DISTINCT addr FROM depot D, stock S WHERE S.prod_id = 'p1' AND D.dep_id = s.dep_id;
--(b) with in/not in
SELECT DISTINCT addr FROM depot WHERE dep_id IN (SELECT dep_id FROM stock WHERE prod_id = 'p1'); 
--(c) with exists/not exists
SELECT DISTINCT addr FROM depot WHERE EXISTS (SELECT * FROM stock WHERE prod_id = 'p1');

-- 5. #prods whose price is between $250.00 and $400.00.
--(a) using intersect.
SELECT prod_id FROM product WHERE price > 250 INTERSECT SELECT prod_id FROM product WHERE price < 400; 
--(b) without intersect.
SELECT prod_id FROM product WHERE price > 250 AND price < 400;

-- 6. How many products are out of stock?
SELECT COUNT(quantity) As NumOutOfStock FROM stock WHERE quantity < 0; 

-- 7. Average of the prices of the products stocked in the ”d2” depot.
SELECT AVG(price) AS AveP FROM product P, stock S WHERE P.prod_id = S.prod_id AND dep_id = 'd2';

-- 8. #deps of the depot(s) with the largest capacity (volume).
SELECT dep_id FROM depot WHERE volume IN (SELECT MAX(volume) FROM depot);

-- 9. Sum of the stocked quantity of each product.
SELECT prod_id, SUM(quantity) FROM stock GROUP BY prod_id;

-- 10. Products names stocked in at least 3 depots.
--(a) using count
SELECT pname FROM product WHERE prod_id IN (SELECT prod_id FROM stock GROUP BY prod_id HAVING COUNT(dep_id) >= 3);
--(b) without using count
SELECT pname 
FROM product 
WHERE prod_id IN (
SELECT S1.prod_id 
	FROM stock S1, stock S2, stock S3 
	WHERE S1.dep_id <> S2.dep_id 
	AND S2.dep_id <> S3.dep_id 
	AND S3.dep_id <> S1.dep_id 
	);

