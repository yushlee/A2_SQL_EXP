-- SQL 練習題(四)
-- 查詢每個部門高於平均部門薪資的員工
-- (結果依部門平均薪資降冪排序)

SELECT DEP_AVG.*, E.EMPLOYEE_ID, E.FIRST_NAME,  E.SALARY, E.DEPARTMENT_ID, D.DEPARTMENT_NAME
FROM (
	SELECT DEPARTMENT_ID, FLOOR(AVG(SALARY)) DEP_AVG_SALARY
	FROM employees
	GROUP BY DEPARTMENT_ID
) DEP_AVG, employees E, departments D
WHERE DEP_AVG.DEPARTMENT_ID = E.DEPARTMENT_ID
AND E.DEPARTMENT_ID = D.DEPARTMENT_ID
AND E.SALARY > DEP_AVG.DEP_AVG_SALARY
ORDER BY E.DEPARTMENT_ID, E.SALARY;


SELECT DEP_AVG.*, E.EMPLOYEE_ID, E.FIRST_NAME,  E.SALARY, E.DEPARTMENT_ID, D.DEPARTMENT_NAME
FROM (
	SELECT DEPARTMENT_ID, FLOOR(AVG(SALARY)) DEP_AVG_SALARY
	FROM employees
	GROUP BY DEPARTMENT_ID
) DEP_AVG
JOIN employees E ON  DEP_AVG.DEPARTMENT_ID = E.DEPARTMENT_ID
JOIN departments D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
WHERE E.SALARY > DEP_AVG.DEP_AVG_SALARY
ORDER BY E.DEPARTMENT_ID, E.SALARY;

WITH DEP_AVG AS (
	SELECT DEPARTMENT_ID, FLOOR(AVG(SALARY)) DEP_AVG_SALARY
	FROM employees
	GROUP BY DEPARTMENT_ID
), 
EMP AS (
	-- 38筆
	SELECT DEP_AVG.*, E.EMPLOYEE_ID, E.FIRST_NAME,  E.SALARY
    FROM DEP_AVG, employees E
    WHERE DEP_AVG.DEPARTMENT_ID = E.DEPARTMENT_ID
    AND E.SALARY > DEP_AVG.DEP_AVG_SALARY
)
SELECT EMP.*, D.DEPARTMENT_NAME
FROM EMP, departments D
WHERE EMP.DEPARTMENT_ID = D.DEPARTMENT_ID
ORDER BY EMP.DEPARTMENT_ID, EMP.SALARY;