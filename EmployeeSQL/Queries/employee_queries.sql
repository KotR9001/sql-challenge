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
