create database SP;
use SP;

create table supplier(
	sno varchar(255) primary key check(substr(sno,1,1) = 's'),
	sname varchar(255),
	city varchar(255),
	phone varchar(10) check(length(phone) = 10),
	email varchar(255)
);

insert into supplier(sno,sname,city,phone,email)
	values('s9009','Adarsh Industries','Ropar',9123456780,'adarsh@gmail.com');
insert into supplier(sno,sname,city,phone,email)
	values('s4444','Nakul Traders','Allahabad',8976543210,'nakul@hotmail.com');
insert into supplier(sno,sname,city,phone,email)
	values('s1234','Shresth Co. & Sons','Jaipur',7612985404,'kumar@yahoo.com');
insert into supplier(sno,sname,city,phone,email)
	values('s5142','Vishwanath Inc.','Varanasi',8899665544,'mahadev@gmail.com');

create table parts(
	pno varchar(255) primary key check(substr(pno,1,1) = 'p'),
	pname varchar(255),
	weight integer,
	color varchar(255)
);

insert into parts(pno,pname,weight,color)
	values('p5455','Screw Jack',2050,'Black');
insert into parts(pno,pname,weight,color)
	values('p4004','Power Bank',544,'Grey');
insert into parts(pno,pname,weight,color)
	values('p4544','Carburettor',5446,'Golden');
insert into parts(pno,pname,weight,color)
	values('p516','Lead Shots',4654,'Silver');

create table sp(
	sno varchar(255),
	pno varchar(255),
	qty integer,
	primary key(sno,pno),
	foreign key(sno) references supplier(sno),
	foreign key(pno) references parts(pno)
);

insert into sp(sno,pno,qty)
	values('s9009','p4004',5000);
insert into sp(sno,pno,qty)
	values('s1234','p4004',2500);
insert into sp(sno,pno,qty)
	values('s4444','p4544',1200);
insert into sp(sno,pno,qty)
	values('s5142','p516',650);
insert into sp(sno,pno,qty)
	values('s4444','p5455',150);
insert into sp(sno,pno,qty)
	values('s1234','p4544',1500);

/*1
Display only the numbers from sno.*/
select substring(sno,2) as numbers_from_sno from supplier;

/*2
Display the sname with exactly two ‘a’.*/
select sno,sname from supplier
	where (length(`sname`)-length(replace(`sname`, 'a', '')) = 2);

/*3
Show sno and pno combination as followings‐ if sno is ‘s123’ and pno is ‘p10’
then display ‘sp12310’.*/
select sno,pno,concat(substring(sno,1,1),substring(pno,1,1)
	,substring(sno,2),substring(pno,2)) as sno_pno_combination from sp;

/*4
Display the sno where the numerical part is a palindrome.*/
select sno as palindromic_sno from supplier
	where substring(sno,2)=reverse(substring(sno,2));

/*5
Display the sno of a given supplier as follows‐ if sno is ‘s123’ then display it as ‘suppl123’.*/
select sno,concat("suppl",substring(sno,2)) as mod_sno from supplier;

/*6
Display the phone in xxxxx‐xxxxx format*/
select sno,concat_ws('-',substring(phone,1,length(phone)/2),substring(phone,length(phone)/2)) 
	as phone from supplier;

/*7
For each sno, generate a key which starts with the last digit of sno, 5th and 8th digits of
its phone number and ends with a random number between 0 to 99.*/
select sno,concat(substring(reverse(sno),1,1),
	substring(phone,5,1),substring(phone,8,1),floor(rand()*(100-0))) as my_key from supplier;

/*8
Assume that the weight unit in parts table is in 'gm'. Now display the weight unit in 'kg'
by rounding off 2 digits.*/
select pno,pname,format((weight*1.0)/1000.0,2) as weight_kg from parts;

/*9
Retrieve the domain name of the email of the suppliers. If the email is abc@gmail.com
then retrieve only ‘gmail’.*/
select sno,sname,substring(email,position('@' in email)+1,
	position('.' in email)-position('@' in email)-1) 
	as domain_name from supplier;

/*10
Display a chart that will show the pno and its weight with asterisks (*). For
example: if the weight is any value in {0,1,2,...,9} then use ‘*’, if the weight is any value in
{10,11,12,...,19} use ‘**’, if the weight is any value in {20,21,22,...,29 use ‘***’ and so on.*/
select pno, lpad('',floor(weight/10)+1,'*') as star_weight from parts;
