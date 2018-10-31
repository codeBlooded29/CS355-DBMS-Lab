create database DBLAB7;
use DBLAB7;

/*A*/
create table STUDENT(
	ID integer,
	firstname varchar(255),
	lastname varchar(255),
	department varchar(255)
);

insert into STUDENT(ID,firstname,lastname,department)
	values(1,'ABCD','XYZA','CSE');
insert into STUDENT(ID,firstname,lastname,department)
	values(2,'XYZA','ABCD','CSE');
insert into STUDENT(ID,firstname,lastname,department)
	values(3,'PQRS','TUVW','EE');
insert into STUDENT(ID,firstname,lastname,department)
	values(4,'IJKL','MNOP','CBE');
insert into STUDENT(ID,firstname,lastname,department)
	values(5,'UVWX','QRST','CEE');

/*1*/
delimiter //
create function full_name(firstname varchar(255),lastname varchar(255))
	returns varchar(255)
begin
	declare name varchar(255);
	set name=concat(lastname,', ',firstname);
	return name;
end; //
delimiter ;

/*2*/
select firstname, lastname, full_name(firstname,lastname), ID
	from STUDENT where department='CSE';

/*B*/
/*1*/
delimiter //
create function root_calculation(a DOUBLE, b DOUBLE, c DOUBLE)
	returns varchar(255)
begin
	declare alpha DOUBLE;
	declare beta DOUBLE;
	declare discriminant DOUBLE;
	declare roots varchar(255);

	if a=0 then
		return ('Not a valid Quadratic Equation');
	end if;

	set discriminant=pow(b,2)-4*a*c;

	set alpha=(-1.0*b+discriminant)/(2.0*a);
	set beta=(-1.0*b-discriminant)/(2.0*a);

	set roots=concat(cast(alpha as char),'_',cast(beta as char));
	return roots;
end; //
delimiter ;

drop function root_calculation;
select root_calculation(1,2,2);

/*2*/
delimiter //
create function root_calculation(a DOUBLE, b DOUBLE, c DOUBLE)
	returns varchar(255)
begin
	declare alpha DOUBLE;
	declare beta DOUBLE;
	declare discriminant DOUBLE;
	declare roots varchar(255);

	if a=0 then
		return ('Not a valid Quadratic Equation');
	end if;

	set discriminant=pow(b,2)-4*a*c;

	if discriminant<0 then
		return ('Roots are imaginary');
	end if;

	set alpha=(-1.0*b+discriminant)/(2.0*a);
	set beta=(-1.0*b-discriminant)/(2.0*a);

	set roots=concat(cast(alpha as char),'_',cast(beta as char));
	return roots;
end; //
delimiter ;
