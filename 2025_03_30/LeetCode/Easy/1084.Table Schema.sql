DROP TABLE PRODUCT;
DROP TABLE SALES;

CREATE TABLE PRODUCT (
 PRODUCT_ID INT,
 PRODUCT_NAME VARCHAR(10),
 UNIT_PRICE INT,
 PRIMARY KEY (PRODUCT_ID)
);

CREATE TABLE SALES (
 SELLER_ID INT,
 PRODUCT_ID INT,
 BUYER_ID INT,
 SALE_DATE DATE,
 QUANTITY INT,
 PRICE INT
);

INSERT INTO PRODUCT VALUES (1, 'S8', 1000);
INSERT INTO PRODUCT VALUES (2, 'G4', 800);
INSERT INTO PRODUCT VALUES (3, 'iPhone', 1400);


INSERT INTO SALES VALUES (1, 1, 1, '2019-01-21', 2, 2000);
INSERT INTO SALES VALUES (1, 2, 2, '2019-02-17', 1, 800);
INSERT INTO SALES VALUES (2, 2, 3, '2019-06-02', 1, 800);
INSERT INTO SALES VALUES (3, 3, 4, '2019-05-13', 2, 2800);
COMMIT;