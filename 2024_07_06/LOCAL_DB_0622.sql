SELECT  STORE_ID, SALES, STORE_NAME, STORE_DATE FROM store_information;

SELECT * FROM store_information;

-- 資料去重覆
-- 1.DISTINCT 只能下一次
-- 2.DISTINCT 位置只能在所有欄位的最前面
SELECT DISTINCT STORE_NAME,  SALES
FROM store_information;

SELECT  STORE_ID, STORE_NAME, SALES 
FROM store_information
WHERE SALES >= 1500;

-- 表格中選出所有 Sales 高於 $1,000 或是 Sales 在 $500 及 $275 之間的資料的話

SELECT  STORE_ID, STORE_NAME, SALES 
FROM store_information
WHERE SALES > 1000
OR (SALES > 275 AND SALES < 500);

-- AND 嚴謹(資料限縮)
-- OR 寬鬆(資料擴展)
SELECT  STORE_ID, STORE_NAME, SALES, GEOGRAPHY_ID
FROM store_information
WHERE GEOGRAPHY_ID = 2
AND SALES > 500;

SELECT  STORE_ID, STORE_NAME, SALES, GEOGRAPHY_ID
FROM store_information
WHERE STORE_ID = 1
OR STORE_ID = 2
OR STORE_ID = 3;

SELECT  STORE_ID, STORE_NAME, SALES, GEOGRAPHY_ID
FROM store_information
WHERE STORE_ID IN (1,2,3,4,5);

SELECT  STORE_ID, STORE_NAME, SALES, GEOGRAPHY_ID
FROM store_information
WHERE STORE_NAME = 'Los Angeles'
OR STORE_NAME = 'Boston'
OR STORE_NAME = 'San Diego';


SELECT  STORE_ID, STORE_NAME, SALES, GEOGRAPHY_ID
FROM store_information
WHERE STORE_NAME IN ('Los Angeles', 'Boston', 'San Diego');


SELECT  STORE_ID, STORE_NAME, SALES
FROM store_information
WHERE SALES >= 300 AND SALES <= 2500;

SELECT  STORE_ID, STORE_NAME, SALES
FROM store_information
WHERE SALES BETWEEN 300 AND 2500;


SELECT  STORE_ID, STORE_NAME, SALES, STORE_DATE
FROM store_information
WHERE STORE_DATE BETWEEN '2018-02-01' AND '2018-05-30';


SELECT  STORE_ID, STORE_NAME, SALES, STORE_DATE
FROM store_information
WHERE STORE_NAME LIKE 'B%';

SELECT  STORE_ID, STORE_NAME, SALES, STORE_DATE
FROM store_information
WHERE STORE_NAME LIKE '%s';

SELECT  STORE_ID, STORE_NAME, SALES, STORE_DATE
FROM store_information
WHERE STORE_NAME LIKE 'L%s';


SELECT  STORE_ID, STORE_NAME, SALES, STORE_DATE
FROM store_information
WHERE STORE_NAME LIKE '%a%';

-- SQL 練習題(一)
-- 1.「且」找出屬於西區的商店
-- 2.「且」營業額大於300(包含300)
-- 3.「且」商店名稱'L'開頭
-- 4.「或」營業日介於2018年3月至4月
SELECT  *
FROM store_information
WHERE GEOGRAPHY_ID = 2
AND SALES >= 300
AND STORE_NAME LIKE 'L%'
OR STORE_DATE BETWEEN '2018-03-01' AND '2018-04-30';

-- 小往大 (ascending:預設) 或是由大往小(descending)
SELECT  STORE_ID, STORE_NAME, SALES, STORE_DATE
FROM store_information
ORDER BY SALES ASC;

SELECT  STORE_ID, STORE_NAME, SALES, STORE_DATE
FROM store_information
ORDER BY SALES DESC;

SELECT  STORE_ID, STORE_NAME, SALES, STORE_DATE
FROM store_information
ORDER BY SALES;

SELECT  STORE_ID, STORE_NAME, SALES, STORE_DATE
FROM store_information
ORDER BY SALES DESC, STORE_DATE DESC;

SELECT SUM(SALES), AVG(SALES), COUNT(STORE_ID),
	MIN(SALES), MAX(SALES)
FROM store_information;

-- COUNT函數經常與IS NULL、IS NOT NULL搭配使用
-- 空值NULL
SELECT COUNT(STORE_ID)
FROM store_information
WHERE GEOGRAPHY_ID IS NULL;

-- 非空值NULL
SELECT COUNT(STORE_ID)
FROM store_information
WHERE GEOGRAPHY_ID IS NOT NULL;

-- 目的是找出表格中有多少筆不同的資料個數
SELECT COUNT(DISTINCT STORE_NAME)
FROM store_information;

-- 個別商店(依商店名稱做資料分群)的加總營業額
SELECT STORE_NAME, SUM(SALES), COUNT(STORE_ID), AVG(SALES),
	MAX(SALES), MIN(SALES)
FROM store_information
GROUP BY STORE_NAME;

-- 資料分劃、資料聚合(合併)
-- 其它非GROUP的欄位必須指定聚合函數
SELECT STORE_NAME, SALES
FROM store_information
GROUP BY STORE_NAME, SALES;

-- 資料群組清單列表
SELECT STORE_NAME, SUM(SALES), COUNT(STORE_ID),
	GROUP_CONCAT(SALES ORDER BY SALES DESC SEPARATOR '/')
FROM store_information
GROUP BY STORE_NAME;

-- HAVING:資料分群後對聚合函數產生的值來設定條件查尋
-- SELECT -> FROM -> WHERE -> GROUP BY -> HAVING -> ORDER BY
SELECT STORE_NAME, SUM(SALES), COUNT(STORE_ID)
FROM store_information
-- WHERE GEOGRAPHY_ID = 2
GROUP BY STORE_NAME
HAVING SUM(SALES) >= 3000
ORDER BY SUM(SALES) ASC;

-- SQL 練習題(二)
-- 計算和統計「個別商店」的以下三項資料：
-- 「總合營業額」、「商店資料個數」、「平均營業額」
-- 搜尋或排除條件如下：
-- 排除「平均營業額」1000(含)以下的商店資料
-- 排除「商店資料個數」1(含)個以下的商店資料
-- 依照「平均營業額」由大至小排序
SELECT STORE_NAME, SUM(SALES), COUNT(SALES), AVG(SALES)
FROM store_information
GROUP BY STORE_NAME
HAVING AVG(SALES) > 1000
AND  COUNT(SALES) > 1
ORDER BY AVG(SALES) DESC;

