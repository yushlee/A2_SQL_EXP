-- SELECT → FROM → WHERE → GROUP BY → HAVING → ORDER BY 
SELECT STORE_NAME, SUM(SALES)
FROM store_information
WHERE GEOGRAPHY_ID = 2
GROUP BY STORE_NAME
HAVING SUM(SALES) >= 200
ORDER BY SUM(SALES) ASC;

-- 欄位別名 
-- 1.AS 可省略不寫
-- 2.使用"雙引號"
-- 3."雙引號"可省略不寫
-- 4.別名不可以有空白("雙引號"可以有空白)
SELECT STORE_NAME, SUM(SALES) 加總營業額, COUNT(STORE_ID) "商店數量",
	-- GROUP_CONCAT(STORE_ID ORDER BY STORE_ID DESC SEPARATOR '/'),
	GROUP_CONCAT(SALES ORDER BY STORE_ID DESC SEPARATOR '/') AS "GROUP LIST SUM"
FROM store_information
GROUP BY STORE_NAME;

-- Oracle 群組清單函數
-- SELECT STORE_NAME, SUM(SALES), COUNT(STORE_ID),
-- 	LISTAGG(SALES, ',') WITHIN GROUP (ORDER BY SALES)
-- FROM store_information
-- GROUP BY STORE_NAME;

-- 表格別名.表格欄位 AS "欄位別名"
SELECT S.STORE_ID, S.STORE_NAME AS "商店名稱"
FROM STORE_INFORMATION S;


SELECT G.GEOGRAPHY_ID, G.REGION_NAME,
	S.STORE_ID, S.STORE_NAME, S.SALES, S.GEOGRAPHY_ID, S.STORE_DATE
FROM geography G, STORE_INFORMATION S
-- 表格連接JOIN
WHERE G.GEOGRAPHY_ID = S.GEOGRAPHY_ID;


-- INNER JOIN...ON
SELECT G.GEOGRAPHY_ID, G.REGION_NAME,
	S.STORE_ID, S.STORE_NAME, S.SALES, S.GEOGRAPHY_ID, S.STORE_DATE
FROM geography G INNER JOIN STORE_INFORMATION S
ON G.GEOGRAPHY_ID = S.GEOGRAPHY_ID;

-- 左外部連接(LEFT JOIN or LEFT OUTER JOIN)
-- INNER、OUTER 可省略不寫
SELECT G.GEOGRAPHY_ID, G.REGION_NAME,
	S.STORE_ID, S.STORE_NAME, S.SALES, S.GEOGRAPHY_ID, S.STORE_DATE
FROM geography G LEFT JOIN STORE_INFORMATION S
ON G.GEOGRAPHY_ID = S.GEOGRAPHY_ID;


SELECT G.GEOGRAPHY_ID, G.REGION_NAME,
	S.STORE_ID, S.STORE_NAME, S.SALES, S.GEOGRAPHY_ID, S.STORE_DATE
FROM geography G RIGHT JOIN STORE_INFORMATION S
ON G.GEOGRAPHY_ID = S.GEOGRAPHY_ID;

-- PS:MY SQL不支援FULL JOIN
-- SELECT G.GEOGRAPHY_ID, G.REGION_NAME,
-- 	S.STORE_ID, S.STORE_NAME, S.SALES, S.GEOGRAPHY_ID, S.STORE_DATE
-- FROM geography G FULL JOIN STORE_INFORMATION S
-- ON G.GEOGRAPHY_ID = S.GEOGRAPHY_ID;

-- SQL 練習題(二)
-- 計算和統計「個別商店」的以下三項資料：
-- 「總合營業額」、「商店資料個數」、「平均營業額」
-- 搜尋或排除條件如下：
-- 排除「平均營業額」1000(含)以下的商店資料
-- 排除「商店資料個數」1(含)個以下的商店資料
-- 依照「平均營業額」由大至小排序
-- PS:使用別名語法簡化「表格名稱」及查詢結果「欄位名稱」

SELECT STORE_NAME, SUM(SALES), AVG(SALES), COUNT(STORE_ID)
FROM STORE_INFORMATION
GROUP BY STORE_NAME
HAVING AVG(SALES) > 1000 AND COUNT(STORE_ID) > 1
ORDER BY AVG(SALES) DESC;

-- SQL 練習題(三)
-- 查詢各區域的營業額總計
-- 資料結果依營業額總計由大到小排序
-- (不論該區域底下是否有所屬商店)
SELECT G.REGION_NAME, IFNULL(SUM(S.SALES), 0) "SUM_SALES"
FROM geography G LEFT JOIN store_information S
ON G.GEOGRAPHY_ID = S.GEOGRAPHY_ID
GROUP BY G.REGION_NAME;


-- 查詢各區域的商店個數
-- 資料結果依區域的商店個數由大至小排序
-- (依據商店名稱,不包含重覆的商店)
-- (不論該區域底下是否有所屬商店)
SELECT  G.REGION_NAME, 
	COUNT(DISTINCT S.STORE_NAME) "STORE_COUNT"
FROM geography G LEFT JOIN store_information S
ON G.GEOGRAPHY_ID = S.GEOGRAPHY_ID
GROUP BY  G.REGION_NAME
ORDER BY STORE_COUNT DESC;

SELECT STORE_ID, STORE_NAME, SALES, STORE_DATE, GEOGRAPHY_ID FROM store_information;

INSERT INTO store_information (STORE_ID, STORE_NAME, SALES, STORE_DATE, GEOGRAPHY_ID)
VALUES(10, 'Appl Store', 5600,  '2023-10-22 17:18:00', 3);

-- UPDATE "表格名"SET "欄位1" = [新值] WHERE {條件} 
UPDATE store_information
SET SALES = 4300,
	STORE_NAME = 'Apple Inc'
WHERE STORE_ID = 10;

UPDATE store_information
SET STORE_NAME = 'TEST'
WHERE GEOGRAPHY_ID = 2;

-- DELETE FROM "表格名" WHERE {條件} 
DELETE FROM store_information 
WHERE STORE_ID = 10 AND XXXX;
