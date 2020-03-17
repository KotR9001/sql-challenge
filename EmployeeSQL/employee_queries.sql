--Drop Tables
drop table if exists departments cascade;
drop table if exists dept_emp cascade;
drop table if exists dept_manager cascade;
drop table if exists employees cascade;
drop table if exists salaries cascade;
drop table if exists titles cascade;



-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.

-- Modify this code to update the DB schema diagram.
-- To reset the sample schema, replace everything with
-- two dots ('..' - without quotes).

CREATE TABLE "departments" (
    "dept_no" varchar(4)   NOT NULL,
    "dept_name" varchar(20)   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "dept_emp" (
    "emp_no" int   NOT NULL,
    "dept_no" varchar(4)   NOT NULL,
    "from_date" date   NOT NULL,
    "to_date" date   NOT NULL
);

CREATE TABLE "dept_manager" (
    "dept_no" varchar(4)   NOT NULL,
    "emp_no" int   NOT NULL,
    "from_date" date   NOT NULL,
    "to_date" date   NOT NULL
);

CREATE TABLE "employees" (
    "emp_no" int   NOT NULL,
    "birth_date" date   NOT NULL,
    "first_name" varchar(20)   NOT NULL,
    "last_name" varchar(20)   NOT NULL,
    "gender" varchar(1)   NOT NULL,
    "hire_date" date   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "salaries" (
    "emp_no" int   NOT NULL,
    "salary" int   NOT NULL,
    "from_date" date   NOT NULL,
    "to_date" date   NOT NULL
);

CREATE TABLE "titles" (
    "emp_no" int   NOT NULL,
    "title" varchar(30)   NOT NULL,
    "from_date" date   NOT NULL,
    "to_date" date   NOT NULL
);

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "titles" ADD CONSTRAINT "fk_titles_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");



--View Tables
--departments
select * from departments;
--dept_emp
select * from dept_emp;
--dept_manager
select * from dept_manager;
--employees
select * from employees;
--salaries
select * from salaries;
--titles
select * from titles;



--Perform Queries
--Query #1: List the following details of each employee: employee number, last name, first name, gender, and salary.
create view query_1_employee_info as
select employees.emp_no, employees.last_name, employees.first_name, employees.gender, salaries.salary
from employees
inner join salaries
on employees.emp_no = salaries.emp_no;

select *
from query_1_employee_info;

--Query #2: List employees who were hired in 1986.
create view query_2_employees_1986 as
select emp_no, first_name, last_name, hire_date
from employees
where hire_date >= '01/01/1986' and hire_date <= '12/31/1986'
order by hire_date asc;

select *
from query_2_employees_1986;

--Query #3: List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name, and start and end employment dates.
create view query_3_manager_info as
select departments.dept_no, departments.dept_name, dept_manager.emp_no, employees.last_name, employees.first_name, titles.title, titles.from_date, titles.to_date
from departments
inner join dept_manager
on departments.dept_no = dept_manager.dept_no
inner join employees
on dept_manager.emp_no = employees.emp_no
inner join titles
on employees.emp_no = titles.emp_no
order by dept_no, emp_no, from_date, to_date asc;

select *
from query_3_manager_info;

--Query #4: List the department of each employee with the following information: employee number, last name, first name, and department name.
create view query_4_employee_dept_info as
select employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
from employees
inner join dept_emp
on employees.emp_no = dept_emp.emp_no
inner join departments
on dept_emp.dept_no = departments.dept_no
order by emp_no, dept_name asc;

select *
from query_4_employee_dept_info;

--Query #5: List all employees whose first name is "Hercules" and last names begin with "B."
create view query_5_hercules_b as
select first_name, last_name
from employees
where first_name = 'Hercules' and last_name like 'B%'
order by last_name asc;

select *
from query_5_hercules_b;

--Query #6: List all employees in the Sales department, including their employee number, last name, first name, and department name.
create view query_6_sales_employees_info as
select *
from query_4_employee_dept_info
where dept_name = 'Sales';

select *
from query_6_sales_employees_info;

--Query #7: List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
create view query_7_sales_development_employees_info as
select *
from query_4_employee_dept_info
where dept_name = 'Sales' or dept_name = 'Development';

select *
from query_7_sales_development_employees_info;

--Query #8: In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
create view query_8_frequency_last_name as
select last_name, count(last_name) as "Last Name Frequency"
from employees
group by last_name
order by "Last Name Frequency" desc;

select *
from query_8_frequency_last_name;
