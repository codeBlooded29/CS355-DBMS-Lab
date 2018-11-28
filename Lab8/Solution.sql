/*1*/
create table Customer(
	Customer_Id varchar(255) primary key,
	Customer_Name varchar(255),
	City varchar(255),
	Pincode varchar(255),
	State varchar(255),
	Balance_Due integer 
);

insert into Customer(Customer_Id,Customer_Name,City,Pincode,State,Balance_Due)
	values('1','Adarsh','Ropar',654321,'Punjab',1200);
insert into Customer(Customer_Id,Customer_Name,City,Pincode,State,Balance_Due)
	values('2','Vedant','Noida',123456,'Uttar Pradesh',108);
insert into Customer(Customer_Id,Customer_Name,City,Pincode,State,Balance_Due)
	values('3','Nakul','Allahabad',987654,'Uttar Pradesh',5500);
insert into Customer(Customer_Id,Customer_Name,City,Pincode,State,Balance_Due)
	values('4','Shresth','Jaipur',109856,'Rajasthan',1600);

create table Product(
	Product_Code varchar(255) primary key,
	Product_Name varchar(255),
	Qty_Available integer,
	Cost_Price integer,
	Selling_Price integer
);

insert into Product(Product_Code,Product_Name,Qty_Available,Cost_Price,Selling_Price)
	values('1','Power Bank',120,700,800);
insert into Product(Product_Code,Product_Name,Qty_Available,Cost_Price,Selling_Price)
	values('2','Ear Phones',500,200,250);
insert into Product(Product_Code,Product_Name,Qty_Available,Cost_Price,Selling_Price)
	values('3','Battery Charger',500,400,600);
insert into Product(Product_Code,Product_Name,Qty_Available,Cost_Price,Selling_Price)
	values('4','Screen Guard',200,100,140);

create table Order_Info(
	Order_No varchar(255),
	Order_Date date,
	Customer_Id varchar(255), 
	Product_Code varchar(255),
	Quantity integer,
	primary key(Order_No),
	foreign key(Customer_Id) references Customer(Customer_Id),
	foreign key(Product_Code) references Product(Product_Code)
);

insert into Order_Info(Order_No,Order_Date,Customer_Id,Product_Code,Quantity)
	values('1234','2018-09-15','1','1',5);
insert into Order_Info(Order_No,Order_Date,Customer_Id,Product_Code,Quantity)
	values('3456','2018-06-12','2','4',10);
insert into Order_Info(Order_No,Order_Date,Customer_Id,Product_Code,Quantity)
	values('7876','2016-09-15','4','3',6);
insert into Order_Info(Order_No,Order_Date,Customer_Id,Product_Code,Quantity)
	values('4567','2018-05-20','3','2',4);

/*1A*/
create unique index 1A
	on Customer(Customer_Id); 

/*1B*/
create unique index 1B
	on Order_Info(Order_No,Customer_Id,Product_Code);

/*2*/
create table employees(
	employee_id INT(6),
	first_name VARCHAR(20),
	last_name VARCHAR(25) NOT NULL,
	/*CONSTRAINT emp_last_name_nn_demo NOT NULL(last_name),*/
	email VARCHAR(25) UNIQUE NOT NULL,
	/*CONSTRAINT emp_email_nn_demo NOT NULL(email),*/
	phone_number VARCHAR(20), 
	hire_date DATE,
	job_id VARCHAR(10) NOT NULL,
	/*CONSTRAINT emp_job_nn_demo NOT NULL(job_id),*/
	salary DECIMAL(8,2) NOT NULL CHECK(salary>0),
	/*CONSTRAINT emp_salary_nn_demo NOT NULL(salary),*/ 
	commission_pct DECIMAL(2,2), 
	manager_id INT(6), 
	department_id INT(4), 
	dn VARCHAR(300)
	/*CONSTRAINT emp_hire_date_nn_demo NOT NULL(hire_date)*/  
	/*CONSTRAINT emp_salary_min_demo CHECK (salary > 0),*/ 
	/*CONSTRAINT emp_email_uk_demo UNIQUE(email)*/
);

insert into employees(employee_id,first_name,last_name,email,phone_number,
	hire_date,job_id,salary,commission_pct,manager_id,department_id,dn)
	values(1,'Adarsh','Kumar','ad@gmail.com',0542221504,curdate(),1,
		15000.00,0.5,1,8,10);

insert into employees(employee_id,first_name,last_name,email,phone_number,
	hire_date,job_id,salary,commission_pct,manager_id,department_id,dn)
	values(2,'Nakul','Kumar','nakul@gmail.com',0542221504,curdate(),1,
		14000.00,0.25,1,8,10);

insert into employees(employee_id,first_name,last_name,email,phone_number,
	hire_date,job_id,salary,commission_pct,manager_id,department_id,dn)
	values(3,'Shresth','Sharma','sharma@gmail.com',0542221505,curdate(),5,
		20000.00,0.90,9,7,11);

insert into employees(employee_id,first_name,last_name,email,phone_number,
	hire_date,job_id,salary,commission_pct,manager_id,department_id,dn)
	values(4,'Vedant','Singh','harsh@gmail.com',0542521505,curdate(),5,
		14500.00,0.95,9,7,11);

insert into employees(employee_id,first_name,last_name,email,phone_number,
	hire_date,job_id,salary,commission_pct,manager_id,department_id,dn)
	values(5,'Harshit','Verma','hv@gmail.com',0547521505,curdate(),1,
		11000.00,0.45,9,7,11);

insert into employees(employee_id,first_name,last_name,email,phone_number,
	hire_date,job_id,salary,commission_pct,manager_id,department_id,dn)
	values(5,'Aditya','Jha','AJ@gmail.com',0547521405,curdate(),1,
		4000.00,0.45,9,7,11);

ALTER TABLE employees ADD COLUMN final_salary DECIMAL(8,2) 
	GENERATED ALWAYS AS (salary + (salary*commission_pct)) STORED;

CREATE INDEX income_ix
ON employees(final_salary);

select first_name, last_name from employees
	use index(income_ix)
	where final_salary > 15000;
