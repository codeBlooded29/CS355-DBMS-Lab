create database LAB8;
use LAB8;

create table LOCATION(
	Location_Id varchar(255) not null,
	Regional_Group varchar(255),
	constraint PK_LOCATION primary key(Location_Id)
);

insert into LOCATION(Location_Id,Regional_Group)
	values('1234','Bihar');
insert into LOCATION(Location_Id,Regional_Group)
	values('1235','UP');
insert into LOCATION(Location_Id,Regional_Group)
	values('1236','Kerala');
insert into LOCATION(Location_Id,Regional_Group)
	values('1244','MP');
insert into LOCATION(Location_Id,Regional_Group)
	values('1235','UP');

create table DEPARTMENT(
	Department_id varchar(255) not null,
	Name varchar(255),
	Location_Id varchar(255),
	constraint PK_DEPARTMENT primary key(Department_id),
	constraint FK_DEPARTMENT foreign key(Location_Id)
		references LOCATION(Location_Id) 
);

insert into DEPARTMENT(Department_id,Name,Location_Id)
	values('1234','Research','1234');
insert into DEPARTMENT(Department_id,Name,Location_Id)
	values('1235','Accounting','1235');
insert into DEPARTMENT(Department_id,Name,Location_Id)
	values('1244','Admin','1234');
insert into DEPARTMENT(Department_id,Name,Location_Id)
	values('1245','House Keeping','1244');

create table JOB(
	Job_Id varchar(255) not null, 
	Function varchar(255),
	constraint PK_JOB primary key(Job_Id),
	constraint CHK_Function check(Function='CLERK' or Function='STAFF'
		or Function='ANALYST' or Function='SALESPERSON' or Function='MANAGER'
		or Function='PRESIDENT')
);

insert into JOB(Job_Id, Function)
	values('1','CLERK');
insert into JOB(Job_Id, Function)
	values('2','STAFF');
insert into JOB(Job_Id, Function)
	values('3','ANALYST');
insert into JOB(Job_Id, Function)
	values('4','SALESPERSON');
insert into JOB(Job_Id, Function)
	values('5','MANAGER');
insert into JOB(Job_Id, Function)
	values('6','PRESIDENT');

create table EMPLOYEE(
	Employee_Id varchar(255) not null,
	Last_Name varchar(255) not null,
	First_Name varchar(255),
	Middle_Name varchar(255),
	Job_Id varchar(255),
	Manager_Id varchar(255),
	Hire_Date date,
	Salary integer,
	Comm integer,
	Department_id varchar(255),
	constraint PK_EMPLOYEE primary key(Employee_Id),
	constraint FK_EMPLOYEE1 foreign key(Department_id)
		references DEPARTMENT(Department_id),
	constraint FK_EMPLOYEE2 foreign key(Job_Id)
		references JOB(Job_Id)
);

insert into EMPLOYEE(Employee_Id,Last_Name,First_Name,Middle_Name,
	Job_Id,Manager_Id,Hire_Date,Salary,Comm,Department_id)
	values('1','Smith','John','B','1','1','1985-04-02',3500,1200,'1234');

insert into EMPLOYEE(Employee_Id,Last_Name,First_Name,Middle_Name,
	Job_Id,Manager_Id,Hire_Date,Salary,Comm,Department_id)
	values('2','Smith','Rose','A','2','1','1985-04-05',4000,1200,'1234');

insert into EMPLOYEE(Employee_Id,Last_Name,First_Name,Middle_Name,
	Job_Id,Manager_Id,Hire_Date,Salary,Comm,Department_id)
	values('3','Harry','John','B','3','1','1985-04-02',3500,1200,'1234');

insert into EMPLOYEE(Employee_Id,Last_Name,First_Name,Middle_Name,
	Job_Id,Manager_Id,Hire_Date,Salary,Comm,Department_id)
	values('6','Smith','Robert','B','4','1','1985-04-05',3500,1200,'1235');

insert into EMPLOYEE(Employee_Id,Last_Name,First_Name,Middle_Name,
	Job_Id,Manager_Id,Hire_Date,Salary,Comm,Department_id)
	values('5','Robert','John','B','5','1','1985-01-02',4000,1200,'1235');

insert into EMPLOYEE(Employee_Id,Last_Name,First_Name,Middle_Name,
	Job_Id,Manager_Id,Hire_Date,Salary,Comm,Department_id)
	values('7','Robert','Brown','W','5','1','1986-01-02',5500,1200,'1244');

insert into EMPLOYEE(Employee_Id,Last_Name,First_Name,Middle_Name,
	Job_Id,Manager_Id,Hire_Date,Salary,Comm,Department_id)
	values('8','Robert','Brown','W','5','1','1986-01-02',5500,1200,'1234');

/*1*
Create a view having first name, last_name, salary, commission for all
employees.*/
create view Q1 as 
	select First_Name, Last_Name, Salary, Comm
	from EMPLOYEE;

/*2
Create a view having the employee’s annual salary with their names only.*/
create view Q2 as
	select concat(First_Name,' ',Last_Name) as Name, 12*Salary as Annual_Salary
	from EMPLOYEE;

/*3
Create a view having the employees who are working in department 20.*/
create view Q3 as
	select * from EMPLOYEE
	where Department_id=20;

/*4
Create a view having the employees who are earning salary between 3000
and 4500.*/
create view Q4 as
	select * from EMPLOYEE
	where salary between 3000 and 4500;

/*5
Create a view having the employees who are working in department 10
or 20.*/
create view Q5 as
	select * from EMPLOYEE
	where Department_id=10 or Department_id=20;

/*6
Create a view having the employees whose name starts with “S”.*/
create view Q6 as
	select * from EMPLOYEE
	where First_Name like 'S%';

/*7
Create a view having the employees whose name length is 4 and start with
“S”.*/
create view Q7 as
	select * from EMPLOYEE
	where First_Name like '%S' and char_length(First_Name)=4;

/*8
Create a view having the employee details according to their last_name
in ascending order and salaries in descending order.*/
create view Q8 as
	select * from EMPLOYEE
	order by Last_Name asc, Salary desc;

/*9
List out the department wise maximum salary, minimum salary, average
salary of the employees.*/
create view Q9 as
	select Name as Dept_Name, max(Salary), min(Salary), avg(Salary)
	from EMPLOYEE inner join DEPARTMENT
		on EMPLOYEE.Department_id=DEPARTMENT.Department_id
	group by DEPARTMENT.Department_id;

/*10
Create a view having the no. of employees for each month and year,
in the ascending order based on the year, month.*/
create view Q10 as
	select month(Hire_Date) as month, year(Hire_Date) as year, count(*)
	from EMPLOYEE
	group by extract(year_month from Hire_Date)
	order by extract(year_month from Hire_Date) asc;

/*11
List out the department id having at least four employees.*/
create view Q11 as
	select DEPARTMENT.Department_id, Name as Dept_Name
	from DEPARTMENT inner join EMPLOYEE
		on DEPARTMENT.Department_id=EMPLOYEE.Department_Id
	group by DEPARTMENT.Department_id
	having count(Employee_Id)>=4;

/*12
How many employees in January month.*/
create view Q12 as
	select count(Employee_Id)
	from EMPLOYEE
	where month(Hire_Date)=1;

/*13
List the department id, having greater than or equal to 3 employees
joined in April 1985.*/
create view Q13 as
	select DEPARTMENT.Department_id, Name as Dept_Name
	from DEPARTMENT, EMPLOYEE
	where DEPARTMENT.Department_id=EMPLOYEE.Department_Id
		and month(Hire_Date)=4 and year(Hire_Date)=1985
	group by DEPARTMENT.Department_id
	having count(Employee_Id)>=3;

/*14
Create a view having the common jobs in Research and Accounting
Departments in ascending order.*/
create view Q14 as
	select Function,count(Function)
	from JOB
	where Function in
		(select Function from
		JOB inner join EMPLOYEE
			on EMPLOYEE.Job_Id=JOB.Job_Id
		where Employee_Id in(select Employee_Id
			from EMPLOYEE inner join DEPARTMENT
			on EMPLOYEE.Department_id=DEPARTMENT.Department_id
			where DEPARTMENT.Name='Research'))
	and Function in
		(select Function from
		JOB inner join EMPLOYEE
			on EMPLOYEE.Job_Id=JOB.Job_Id
		where Employee_Id in(select Employee_Id
			from EMPLOYEE inner join DEPARTMENT
			on EMPLOYEE.Department_id=DEPARTMENT.Department_id
			where DEPARTMENT.Name='Accounting'))
	group by Function
	order by Function asc;
