create database SP;
use SP;

create table supplier(
	sno varchar(255) primary key check(substr(sno,1,1) = 's'),
	sname varchar(255),
	city varchar(255),
	phone varchar(10) check(length(phone) = 10),
	email varchar(255)
);

create table parts(
	pno varchar(255) primary key check(substr(pno,1,1) = 'p'),
	pname varchar(255),
	weight integer,
	color varchar(255)
);

create table sp(
	sno varchar(255),
	pno varchar(255),
	qty integer,
	primary key(sno,pno),
	foreign key(sno) references supplier(sno),
	foreign key(pno) references parts(pno)
);

alter table sp
	add column dos date;

alter table parts
	add column dom date;

alter table supplier
	add column dob date;

insert into supplier(sno,sname,city,phone,email,dob)
	values('s9009','Adarsh Industries','Ropar',9123456780,'adarsh@gmail.com','1980-06-12');
insert into supplier(sno,sname,city,phone,email,dob)
	values('s4444','Nakul Traders','Allahabad',8976543210,'nakul@hotmail.com','1985-07-06');
insert into supplier(sno,sname,city,phone,email,dob)
	values('s123','Shresth Co. & Sons','Jaipur',7612985404,'kumar@yahoo.com','1965-01-02');
insert into supplier(sno,sname,city,phone,email,dob)
	values('s5142','Vishwanath Inc.','Varanasi',8899665544,'mahadev@gmail.com','1971-12-09');

insert into parts(pno,pname,weight,color,dom)
	values('p5455','Screw Jack',2050,'Black','2011-12-01');
insert into parts(pno,pname,weight,color,dom)
	values('p4004','Power Bank',544,'Grey','2012-02-15');
insert into parts(pno,pname,weight,color,dom)
	values('p4544','Carburettor',5446,'Golden','2014-11-26');
insert into parts(pno,pname,weight,color,dom)
	values('p516','Lead Shots',4654,'Silver','2015-05-05');

insert into sp(sno,pno,qty,dos)
	values('s9009','p4004',5000,'2012-06-17');
insert into sp(sno,pno,qty,dos)
	values('s123','p4004',2500,'2016-07-29');
insert into sp(sno,pno,qty,dos)
	values('s4444','p4544',1200,'2015-02-04');
insert into sp(sno,pno,qty,dos)
	values('s5142','p516',650,'2012-09-30');
insert into sp(sno,pno,qty,dos)
	values('s4444','p5455',150,'2015-02-28');
insert into sp(sno,pno,qty,dos)
	values('s123','p4544',1500,'2018-01-05');

/*1*/
select * from supplier
	order by dob desc
	limit 1;

/*2*/
select * from supplier
	where floor(datediff(curdate(),dob)/365.25) > 30;

/*3*/
select city,avg(floor(datediff(curdate(),dob)/365.25)) as Avg_Age
	from supplier
	group by city;

/*4*/
select sname from supplier inner join sp
	on supplier.sno=sp.sno
	where dos between '2012-01-01' and '2012-12-31';

/*5*/
select distinct sname from supplier inner join sp
	on supplier.sno=sp.sno
	where dos > '2015-02-01';

/*6*/
select pname,dos from parts inner join sp
	on parts.pno=sp.pno
	order by dos desc
	limit 1;

/*7*/
select sname from(
	select distinct i1.sno from sp i1 join sp i2
	on i1.sno = i2.sno and i1.pno!=i2.pno and datediff(i1.dos,i2.dos)<=30)
	as foo join supplier on foo.sno=supplier.sno;

/*8*/
select parts.pno,pname,dos, date_add(dos,interval 3 month) as warranty_expiry
	from parts inner join sp
		on sp.pno=parts.pno
		order by pname;

/*9*/
select pno, date_add(dos,interval 3 month) as warranty_expiry
	from sp where sno='s123' and date_add(dos,interval 3 month) > curdate;

/*10*/
select distinct sname from supplier inner join sp
	on sp.sno=supplier.sno inner join parts
		on parts.pno=sp.pno
			where dom < date_sub(curdate(),interval 6 month);
