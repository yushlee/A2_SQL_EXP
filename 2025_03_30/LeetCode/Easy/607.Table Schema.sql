DROP TABLE SALESPERSON;
DROP TABLE COMPANY;
DROP TABLE ORDERS;

CREATE TABLE SALESPERSON(
  SALES_ID INT,
  NAME VARCHAR(20),
  SALARY INT,
  COMMISSION_RATE INT,
  HIRE_DATE DATE
);
 
CREATE TABLE COMPANY(
  COM_ID INT,
  NAME VARCHAR(10),
  CITY VARCHAR(10)
);

CREATE TABLE ORDERS
(
  ORDER_ID INT,
  ORDER_DATE DATE,
  COM_ID INT,
  SALES_ID INT,
  AMOUNT INT
);
 

INSERT INTO SALESPERSON VALUES (1, 'John', 100000, 6, '2006-04-01');
INSERT INTO SALESPERSON VALUES (2, 'Amy',  120000, 5, '2010-05-01');
INSERT INTO SALESPERSON VALUES (3, 'Mark', 65000, 12, '2008-12-25');
INSERT INTO SALESPERSON VALUES (4, 'Pam',  25000, 25, '2005-01-01');
INSERT INTO SALESPERSON VALUES (5, 'Alex', 50000, 10, '2007-02-03');

INSERT INTO COMPANY VALUES (1, 'RED', 'Boston');
INSERT INTO COMPANY VALUES (2, 'ORANGE', 'New York');
INSERT INTO COMPANY VALUES (3, 'YELLOW', 'Boston');
INSERT INTO COMPANY VALUES (4, 'GREEN', 'Austin');

INSERT INTO ORDERS VALUES (1, '2014-01-01', 3, 4, 100000);
INSERT INTO ORDERS VALUES (2, '2014-02-01', 4, 5, 5000);
INSERT INTO ORDERS VALUES (3, '2014-03-01', 1, 1, 50000);
INSERT INTO ORDERS VALUES (4, '2014-04-01', 1, 4, 25000);
COMMIT;