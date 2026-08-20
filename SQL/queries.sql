-- ============================================================
-- EMPLOYEE DATA ANALYSIS
-- SQL ANALYSIS QUERIES
-- Database: employee_analysis
-- Table: employees
-- ============================================================

USE employee_analysis;

-- ============================================================
-- 1. BASIC DATA EXPLORATION
-- ============================================================

-- 1. Total number of employees
SELECT COUNT(*) AS total_employees
FROM employees;

-- 2. View sample employee records
SELECT *
FROM employees
LIMIT 10;

-- 3. View employee names and departments
SELECT Employee_ID, Name, Department
FROM employees;

-- 4. Find employees older than 40
SELECT Employee_ID, Name, Age, Department
FROM employees
WHERE Age > 40;

-- 5. Find employees with more than 5 years of experience
SELECT Employee_ID, Name, Experience, Department
FROM employees
WHERE Experience > 5;

-- ============================================================
-- 2. SORTING AND FILTERING
-- ============================================================

-- 6. Highest-paid employees
SELECT Employee_ID, Name, Department, Salary
FROM employees
ORDER BY Salary DESC
LIMIT 10;

-- 7. Lowest-paid employees
SELECT Employee_ID, Name, Department, Salary
FROM employees
ORDER BY Salary ASC
LIMIT 10;

-- 8. Employees working in the IT department
SELECT *
FROM employees
WHERE Department = 'IT';

-- 9. Employees with a performance rating of 5
SELECT Employee_ID, Name, Department, Performance_Rating
FROM employees
WHERE Performance_Rating = 5;

-- 10. Employees working overtime
SELECT Employee_ID, Name, Department, Overtime
FROM employees
WHERE Overtime = 'Yes';

-- ============================================================
-- 3. AGGREGATE FUNCTIONS
-- ============================================================

-- 11. Average salary
SELECT ROUND(AVG(Salary), 2) AS average_salary
FROM employees;

-- 12. Maximum salary
SELECT MAX(Salary) AS highest_salary
FROM employees;

-- 13. Minimum salary
SELECT MIN(Salary) AS lowest_salary
FROM employees;

-- 14. Total salary expenditure
SELECT SUM(Salary) AS total_salary
FROM employees;

-- 15. Average employee experience
SELECT ROUND(AVG(Experience), 2) AS average_experience
FROM employees;

-- ============================================================
-- 4. GROUP BY ANALYSIS
-- ============================================================

-- 16. Employee count by department
SELECT
Department,
COUNT(*) AS employee_count
FROM employees
GROUP BY Department
ORDER BY employee_count DESC;

-- 17. Average salary by department
SELECT
Department,
ROUND(AVG(Salary), 2) AS average_salary
FROM employees
GROUP BY Department
ORDER BY average_salary DESC;

-- 18. Average experience by department
SELECT
Department,
ROUND(AVG(Experience), 2) AS average_experience
FROM employees
GROUP BY Department
ORDER BY average_experience DESC;

-- 19. Employee count by gender
SELECT
Gender,
COUNT(*) AS employee_count
FROM employees
GROUP BY Gender;

-- 20. Employee count by location
SELECT
Location,
COUNT(*) AS employee_count
FROM employees
GROUP BY Location
ORDER BY employee_count DESC;

-- ============================================================
-- 5. HAVING
-- ============================================================

-- 21. Departments with more than 1,000 employees
SELECT
Department,
COUNT(*) AS employee_count
FROM employees
GROUP BY Department
HAVING COUNT(*) > 1000
ORDER BY employee_count DESC;

-- 22. Departments with an average salary above 50,000
SELECT
Department,
ROUND(AVG(Salary), 2) AS average_salary
FROM employees
GROUP BY Department
HAVING AVG(Salary) > 50000
ORDER BY average_salary DESC;

-- ============================================================
-- 6. CASE WHEN
-- ============================================================

-- 23. Categorize employees by experience
SELECT
Employee_ID,
Name,
Experience,
CASE
WHEN Experience < 2 THEN 'Fresher'
WHEN Experience BETWEEN 2 AND 5 THEN 'Mid-Level'
ELSE 'Experienced'
END AS experience_level
FROM employees;

-- 24. Categorize employees by salary
SELECT
Employee_ID,
Name,
Salary,
CASE
WHEN Salary < 30000 THEN 'Low'
WHEN Salary BETWEEN 30000 AND 60000 THEN 'Medium'
ELSE 'High'
END AS salary_band
FROM employees;

-- 25. Categorize performance
SELECT
Employee_ID,
Name,
Performance_Rating,
CASE
WHEN Performance_Rating >= 4 THEN 'High Performer'
WHEN Performance_Rating = 3 THEN 'Average Performer'
ELSE 'Low Performer'
END AS performance_category
FROM employees;

-- ============================================================
-- 7. ATTRITION ANALYSIS
-- ============================================================

-- 26. Total employees who left
SELECT COUNT(*) AS attrition_count
FROM employees
WHERE Attrition = 'Yes';

-- 27. Attrition by department
SELECT
Department,
COUNT(*) AS attrition_count
FROM employees
WHERE Attrition = 'Yes'
GROUP BY Department
ORDER BY attrition_count DESC;

-- 28. Attrition rate
SELECT
ROUND(
100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
/ COUNT(*),
2
) AS attrition_rate
FROM employees;

-- 29. Attrition by gender
SELECT
Gender,
COUNT(*) AS attrition_count
FROM employees
WHERE Attrition = 'Yes'
GROUP BY Gender
ORDER BY attrition_count DESC;

-- ============================================================
-- 8. SUBQUERIES
-- ============================================================

-- 30. Employees earning above the overall average salary
SELECT
Employee_ID,
Name,
Department,
Salary
FROM employees
WHERE Salary > (
SELECT AVG(Salary)
FROM employees
)
ORDER BY Salary DESC;

-- 31. Highest-paid employee in each department
SELECT
Employee_ID,
Name,
Department,
Salary
FROM employees e
WHERE Salary = (
SELECT MAX(Salary)
FROM employees
WHERE Department = e.Department
);

-- ============================================================
-- 9. CTEs
-- ============================================================

-- 32. Departments with above-average salaries
WITH department_salary AS (
SELECT
Department,
AVG(Salary) AS avg_salary
FROM employees
GROUP BY Department
)
SELECT
Department,
ROUND(avg_salary, 2) AS average_salary
FROM department_salary
WHERE avg_salary > (
SELECT AVG(Salary)
FROM employees
);

-- 33. Calculate department attrition rates
WITH department_stats AS (
SELECT
Department,
COUNT(*) AS total_employees,
SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS attrition_count
FROM employees
GROUP BY Department
)
SELECT
Department,
total_employees,
attrition_count,
ROUND(
100.0 * attrition_count / total_employees,
2
) AS attrition_rate
FROM department_stats
ORDER BY attrition_rate DESC;

-- ============================================================
-- 10. WINDOW FUNCTIONS
-- ============================================================

-- 34. Rank employees by salary
SELECT
Employee_ID,
Name,
Department,
Salary,
RANK() OVER (ORDER BY Salary DESC) AS salary_rank
FROM employees;

-- 35. Rank employees by salary within each department
SELECT
Employee_ID,
Name,
Department,
Salary,
RANK() OVER (
PARTITION BY Department
ORDER BY Salary DESC
) AS department_salary_rank
FROM employees;

-- 36. Top 3 highest-paid employees in each department
WITH ranked_employees AS (
SELECT
Employee_ID,
Name,
Department,
Salary,
RANK() OVER (
PARTITION BY Department
ORDER BY Salary DESC
) AS salary_rank
FROM employees
)
SELECT *
FROM ranked_employees
WHERE salary_rank <= 3
ORDER BY Department, salary_rank;

-- 37. Compare employee salary with department average
SELECT
Employee_ID,
Name,
Department,
Salary,
ROUND(
AVG(Salary) OVER (PARTITION BY Department),
2
) AS department_avg_salary
FROM employees;

-- 38. Difference between employee salary and department average
SELECT
Employee_ID,
Name,
Department,
Salary,
ROUND(
Salary - AVG(Salary) OVER (PARTITION BY Department),
2
) AS salary_difference
FROM employees;

-- ============================================================
-- 11. ADDITIONAL BUSINESS ANALYSIS
-- ============================================================

-- 39. Employees with high performance and high salary
SELECT
Employee_ID,
Name,
Department,
Salary,
Performance_Rating
FROM employees
WHERE Performance_Rating >= 4
AND Salary > (
SELECT AVG(Salary)
FROM employees
)
ORDER BY Salary DESC;

-- 40. Employees with high experience but below-average salary
SELECT
Employee_ID,
Name,
Department,
Experience,
Salary
FROM employees
WHERE Experience > 5
AND Salary < (
SELECT AVG(Salary)
FROM employees
)
ORDER BY Experience DESC;

-- 41. Attrition among employees working overtime
SELECT
Overtime,
Attrition,
COUNT(*) AS employee_count
FROM employees
GROUP BY Overtime, Attrition
ORDER BY Overtime, Attrition;

-- 42. Average salary by education level
SELECT
Education,
ROUND(AVG(Salary), 2) AS average_salary
FROM employees
GROUP BY Education
ORDER BY average_salary DESC;

-- 43. Average salary by designation
SELECT
Designation,
COUNT(*) AS employee_count,
ROUND(AVG(Salary), 2) AS average_salary
FROM employees
GROUP BY Designation
ORDER BY average_salary DESC;

-- 44. Employees with more than 10 years of experience
SELECT
Employee_ID,
Name,
Department,
Experience,
Salary
FROM employees
WHERE Experience > 10
ORDER BY Experience DESC;

-- 45. Overall HR summary
SELECT
COUNT(*) AS total_employees,
ROUND(AVG(Age), 2) AS average_age,
ROUND(AVG(Salary), 2) AS average_salary,
ROUND(AVG(Experience), 2) AS average_experience,
SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS attrition_count,
ROUND(
100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
/ COUNT(*),
2
) AS attrition_rate
FROM employees;

-- ============================================================
-- END OF SQL ANALYSIS
-- ============================================================
