# Datasets used: employee_details.csv and Department_Details.csv
# Use subqueries to answer every question
CREATE SCHEMA IF NOT EXISTS SQL2Takehome1;
USE SQL2Takehome1;
# import csv files in Employee database.

SELECT * FROM DEPARTMENT_DETAILS;
SELECT * FROM EMPLOYEE_DETAILS;

#Q1. Retrive employee_id , first_name , last_name and salary details of those employees 
#whose salary is greater than the average salary of all the employees.(11 Rows)
SELECT employee_id,first_name,last_name,salary FROM employee_details WHERE salary>ANY(SELECT AVG(salary) FROM employee_details);
#Q2. Display first_name , last_name and department_id of those employee where the
# location_id of their department is 1700(3 Rows)
SELECT first_name , last_name , e.department_id FROM employee_details e JOIN department_details d ON e.department_id=d.department_id WHERE d.location_id=1700;
#Q3. From the table employees_details, extract the employee_id, first_name, last_name,
# job_id and department_id who work in  any of the departments of Shipping,
# Executive and Finance.(9 Rows)
SELECT  employee_id, first_name, last_name,job_id,e.department_id FROM employee_details e JOIN department_details d ON e.department_id=d.department_id WHERE d.department_name IN ('shipping','executive','finance');
#Q4. Extract employee_id, first_name, last_name,salary, phone_number and email of the 
#CLERKS who earn more than the salary of any IT_PROGRAMMER.(3 Rows)0
SELECT employee_id, first_name, last_name,salary, phone_number,email FROM employee_details WHERE job_id='ST_CLERK' AND Salary>ANY (SELECT salary from employee_details WHERE job_id='IT_PROG' );

#Q5. Extract employee_id, first_name, last_name,salary, phone_number, 
#email of the AC_ACCOUNTANTs who earn a salary more than all the AD_VPs.(2 Rows)
SELECT employee_id, first_name, last_name,salary, phone_number,email FROM employee_details WHERE JOB_ID='AC_ACCOUNTANT' AND SALARY >ALL (SELECT salary from employee_details WHERE job_id='AD_VP' );
#Q6. Write a Query to display the employee_id, first_name, last_name,
# department_id of the employees who have been recruited in the recent half 
#timeline since the recruiting began. (10 Rows)
SELECT employee_id, first_name, last_name,department_id FROM employee_details WHERE hire_date>(SELECT AVG(hire_date) FROM employee_details);

#Q7. Extract employee_id, first_name, last_name, phone_number, salary and job_id 
#of the employees belonging to the 'Contracting' department (3 Rows)
SELECT employee_id, first_name, last_name, phone_number, salary,job_id FROM employee_details WHERE department_id=ANY(SELECT department_id FROM department_details WHERE department_name='contracting');

#Q8. Extract employee_id, first_name, last_name, phone_number, salary and job_id of the
# employees who does not belong to 'Contracting' department(18 Rows)
SELECT employee_id, first_name, last_name, phone_number, salary,job_id FROM employee_details WHERE department_id=ANY(SELECT department_id FROM department_details WHERE department_name<>'contracting');
#Q9. Display the employee_id, first_name, last_name, job_id and department_id of the 
#employees who were recruited first in the department(7 Rows)
SELECT employee_id, first_name, last_name, job_id, department_id
FROM employee_details e
WHERE hire_date = (
    SELECT MIN(hire_date)
    FROM employee_details
    WHERE department_id = e.department_id
);
#Q10. Display the employee_id, first_name, last_name, salary and job_id of the 
#employees who earn maximum salary for every job.( 7Rows)
SELECT employee_id, first_name, last_name, salary, job_id FROM employee_details e WHERE salary=(SELECT MAX(Salary) FROM employee_details WHERE job_id=e.job_id);

