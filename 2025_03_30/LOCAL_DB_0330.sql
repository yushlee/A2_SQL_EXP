
SELECT STORE_NAME, SUBSTR(STORE_NAME, 3), 
	SUBSTR(STORE_NAME, 3, 3), 
    SUBSTR(STORE_NAME, 1, 3) 
FROM store_information;


SELECT STORE_NAME, LTRIM(STORE_NAME), RTRIM(STORE_NAME), TRIM(STORE_NAME) 
FROM store_information;


--   SQL UNION 聯集(不包含重覆值)
-- 1.資料會去重覆
-- 2.查詢語句之間「欄位個數」必須相同
-- 3.查詢語句之間「欄位型態」必須相同
SELECT STORE_NAME FROM store_information
UNION
SELECT REGION_NAME  FROM geography
UNION
SELECT FIRST_NAME FROM  employees;


-- MySQL不支援FULL JOIN
-- 使用 UNION 聯集 LEFT JOIN + RIGHT JOIN
SELECT S.*, G.*
FROM store_information S LEFT JOIN geography G
ON S.GEOGRAPHY_ID = G.GEOGRAPHY_ID
UNION
SELECT S.*, G.*
FROM store_information S RIGHT JOIN geography G
ON S.GEOGRAPHY_ID = G.GEOGRAPHY_ID;

--   SQL UNION ALL 聯集(包含重覆值)
SELECT 'STORE' DATA_TYPE, STORE_NAME FROM store_information
UNION ALL
SELECT 'GEOG' DATA_TYPE, REGION_NAME  FROM geography;


--   SQL INTERSECT 交集
-- MySQL不支援 INTERSECT
-- 1,2,NULL
-- SELECT GEOGRAPHY_ID FROM STORE_INFORMATION
-- INTERSECT
-- 1,2,3
-- SELECT GEOGRAPHY_ID FROM GEOGRAPHY;


-- INNER JOIN + DISTINCT = INTERSECT 查詢交集結果
SELECT DISTINCT S.GEOGRAPHY_ID 
FROM STORE_INFORMATION S JOIN GEOGRAPHY G
ON S.GEOGRAPHY_ID = G.GEOGRAPHY_ID;

--   SQL MINUS 排除(不包含重覆值) 

-- MS SQL(EXCEPT)
-- 1,2,3
-- SELECT GEOGRAPHY_ID FROM GEOGRAPHY
-- EXCEPT
-- 1,2,NULL
-- SELECT GEOGRAPHY_ID FROM STORE_INFORMATION;

-- Oracle(MINUS)
-- 1,2,3
-- SELECT GEOGRAPHY_ID FROM GEOGRAPHY
-- MINUS
-- 1,2,NULL
-- SELECT GEOGRAPHY_ID FROM STORE_INFORMATION;

-- LEFT JOIN + table2.id IS NULL = MINUS
SELECT G.GEOGRAPHY_ID
FROM GEOGRAPHY G LEFT JOIN STORE_INFORMATION S
ON G.GEOGRAPHY_ID = S.GEOGRAPHY_ID
WHERE S.GEOGRAPHY_ID IS NULL;


--  SQL SubQuery 子查詢
-- 「最高營業額」的「商店資料」
SELECT * 
FROM STORE_INFORMATION
WHERE SALES = (
	SELECT MAX(SALES) FROM STORE_INFORMATION
);


-- 簡單子查詢
-- 外查詢
SELECT * 
FROM STORE_INFORMATION
WHERE GEOGRAPHY_ID IN (
	-- 內查詢
	-- 1,2,3
	SELECT GEOGRAPHY_ID FROM  GEOGRAPHY
);

-- 相關子查詢
-- 外查詢
SELECT * 
FROM STORE_INFORMATION S
WHERE GEOGRAPHY_ID IN (
	-- 內查詢
	-- 1,2
	SELECT GEOGRAPHY_ID FROM GEOGRAPHY G
    WHERE S.GEOGRAPHY_ID = G.GEOGRAPHY_ID
);


SELECT  G.*, S.*  
FROM (
   SELECT GEOGRAPHY_ID, REGION_NAME FROM GEOGRAPHY
) G , 
(
   SELECT GEOGRAPHY_ID, STORE_NAME 
   FROM STORE_INFORMATION
) S
WHERE G.GEOGRAPHY_ID = S.GEOGRAPHY_ID;


SELECT  G.*, S.*  
FROM (
   SELECT GEOGRAPHY_ID, REGION_NAME FROM GEOGRAPHY
) G LEFT JOIN 
(
   SELECT GEOGRAPHY_ID, STORE_NAME 
   FROM STORE_INFORMATION
) S
ON G.GEOGRAPHY_ID = S.GEOGRAPHY_ID;

-- 查詢與查詢之間彼此獨立不能互相使用對方的欄位
SELECT  G.*, S.*  
FROM (
   SELECT GEOGRAPHY_ID, REGION_NAME FROM GEOGRAPHY
) G LEFT JOIN 
(
   SELECT GEOGRAPHY_ID, STORE_NAME 
   FROM STORE_INFORMATION STORE JOIN G
   ON STORE.GEOGRAPHY_ID = G.GEOGRAPHY_ID
) S
ON G.GEOGRAPHY_ID = S.GEOGRAPHY_ID;


-- WITH (Common Table Expressions)
WITH G AS (
	SELECT GEOGRAPHY_ID, REGION_NAME FROM GEOGRAPHY
),
S AS (
	SELECT GEOGRAPHY_ID, STORE_NAME FROM STORE_INFORMATION
)
SELECT G.*, S.* 
FROM G LEFT JOIN  S
ON G.GEOGRAPHY_ID = S.GEOGRAPHY_ID;


-- WITH (Common Table Expressions)
WITH G AS (
	SELECT GEOGRAPHY_ID, REGION_NAME FROM GEOGRAPHY
),
S AS (
	SELECT GEOGRAPHY_ID, STORE_NAME FROM STORE_INFORMATION
)
SELECT G.* FROM G;


WITH G AS (
	SELECT GEOGRAPHY_ID, REGION_NAME FROM GEOGRAPHY
),
S AS (
	SELECT G.GEOGRAPHY_ID, G.REGION_NAME,  STORE.STORE_NAME 
    FROM STORE_INFORMATION STORE, G
    WHERE STORE.GEOGRAPHY_ID = G.GEOGRAPHY_ID
)
SELECT S.* FROM S;


--   SQL EXISTS 存在式關聯查詢

-- EXISTS 是用來測試「內查詢」有沒有產生任何結果。
-- 如果有的話，系統就會執行「外查詢」中的 SQL。
-- 若是沒有的話，那整個 SQL 語句就不會產生任何結果。

-- 外查詢
SELECT * FROM store_information 
WHERE EXISTS  (
     -- 內查詢
	SELECT * FROM geography WHERE GEOGRAPHY_ID = 1
);

-- 外查詢
SELECT * FROM store_information 
WHERE NOT EXISTS  (
     -- 內查詢
	SELECT * FROM geography WHERE GEOGRAPHY_ID = 1
);

-- 外查詢
SELECT * FROM store_information S
WHERE EXISTS  (
     -- 內查詢
	SELECT * FROM geography G 
    WHERE G.GEOGRAPHY_ID = S.GEOGRAPHY_ID
    AND G.GEOGRAPHY_ID = 1
);

 --  SQL IF、CASE WHEN 條件式查詢
SELECT STORE_ID, STORE_NAME, SALES, OPEN_STATUS,
	IF(OPEN_STATUS = 1, 'OPEN', 'CLOSE') OPEN_STATUS
 FROM store_information;

-- CASE WHEN 後面只接條件
SELECT STORE_ID, STORE_NAME, SALES,
	CASE 
		WHEN SALES BETWEEN 0 AND 500 THEN '0-500'
		WHEN SALES BETWEEN 501 AND 1000 THEN '501-1000'
        WHEN SALES BETWEEN 1001 AND 1500 THEN '1001-1500'
        WHEN SALES BETWEEN 1501 AND 2000 THEN '1501-2000'
        -- WHEN SALES > 2000 THEN '>2000'
        ELSE '> 2000'
     END 'RANGE_SALES'
 FROM store_information
 ORDER BY SALES;
 
 -- CASE WHEN 後面接"欄位"與"條件"
SELECT STORE_ID, STORE_NAME, SALES,
	CASE STORE_NAME
		WHEN 'San Diego' THEN SALES * 1.5
        WHEN 'Los Angeles' THEN SALES * 2
		ELSE SALES
    END 'NEW_SALES'
FROM store_information
ORDER BY SALES;
 
 
--  Rank (排名函數) 
SELECT STORE_ID, STORE_NAME, SALES,
	RANK() OVER(ORDER BY SALES DESC) 'STORE_RANK'
FROM store_information;


SELECT STORE_ID, STORE_NAME, SALES, GEOGRAPHY_ID,
	RANK() OVER(PARTITION BY GEOGRAPHY_ID  ORDER BY SALES DESC) 'GEOGRAPHY_RANK'
FROM store_information;


SELECT STORE_ID, STORE_NAME, SALES, STORE_DATE,
	RANK() OVER (ORDER BY SALES DESC) 'STORE_RANK',
    DENSE_RANK() OVER (ORDER BY SALES DESC) 'DENSE_STORE_RANK',
    PERCENT_RANK() OVER (ORDER BY SALES DESC) 'PERCENT_STORE_RANK',
    ROW_NUMBER() OVER (ORDER BY SALES DESC, STORE_DATE DESC) 'ROW_NUMBER_SALES'
FROM store_information;


--  Aggregate Functions with OVER clause
SELECT STORE_ID, STORE_NAME, SALES, GEOGRAPHY_ID,
    -- 依「區域劃分」取營業額"最小值"
    MIN(SALES) OVER (PARTITION BY GEOGRAPHY_ID) MIN_SALES,
    -- 依「區域劃分」取營業額"最大值"
    MAX(SALES) OVER (PARTITION BY GEOGRAPHY_ID) MAX_SALES,
    -- 依「區域劃分」取商店"數量"
    COUNT(STORE_ID) OVER (PARTITION BY GEOGRAPHY_ID) COUNT_STORE_ID,
    -- 依「區域劃分」取營業額"總和"
    SUM(SALES) OVER (PARTITION BY GEOGRAPHY_ID) SUM_SALES,
    -- 依「區域劃分」取營業額"平均"
    AVG(SALES) OVER (PARTITION BY GEOGRAPHY_ID) AVG_SALES
FROM STORE_INFORMATION
ORDER BY GEOGRAPHY_ID, SALES;


--  Analytic Functions with OVER clause
SELECT STORE_ID, STORE_NAME,
    ROW_NUMBER( ) OVER (ORDER BY SALES) ROWNO_STORE,
    SALES,
    -- 依「營業額」排序取"上一個"營業額
    LAG(SALES) OVER (ORDER BY SALES) PREV_SALES,
    -- 依「營業額」排序取"下一個"營業額
    LEAD(SALES) OVER (ORDER BY SALES) NEXT_SALES
FROM STORE_INFORMATION
ORDER BY SALES;


