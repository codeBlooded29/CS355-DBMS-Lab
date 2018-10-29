/*Lab-6 Assignment*/

create database Banking;
use Banking;

create table BRANCH(
	BranchID varchar(255) not null unique,
	branch_name varchar(255) not null unique,
	branch_city varchar(255),
	assets integer not null,
	ModifiedDate date,
	primary key(BranchID)
);

insert into BRANCH(BranchID,branch_name,branch_city,assets,ModifiedDate)
	values('1','Boring Road','Patna',15050709,curdate());
insert into BRANCH(BranchID,branch_name,branch_city,assets,ModifiedDate)
	values('2','Durga Kund','Varanasi',25500987,curdate());

create table ACCOUNT(
	AccountID varchar(255) primary key,
	BranchID varchar(255),
	AccountNumber varchar(255),
	AccountType varchar(255),
	Balance integer,
	ModifiedDate date,
	foreign key (BranchID) references BRANCH(BranchID) on delete cascade
);

insert into ACCOUNT(AccountID,BranchID,AccountNumber,AccountType,Balance,ModifiedDate)
	values('11','1','1234','SB',2500,curdate());
insert into ACCOUNT(AccountID,BranchID,AccountNumber,AccountType,Balance,ModifiedDate)
	values('22','1','1245','Current',495,curdate());
insert into ACCOUNT(AccountID,BranchID,AccountNumber,AccountType,Balance,ModifiedDate)
	values('33','2','1244','RD',11500,curdate());
insert into ACCOUNT(AccountID,BranchID,AccountNumber,AccountType,Balance,ModifiedDate)
	values('44','2','4545','SB',5000,curdate());
insert into ACCOUNT(AccountID,BranchID,AccountNumber,AccountType,Balance,ModifiedDate)
	values('55','2','9876','Loan',5000,curdate());

create table CUSTOMER(
	CustomerID varchar(255) primary key,
	Name varchar(255),
	Street varchar(255),
	City varchar(255),
	State varchar(255),
	Zip varchar(255),
	Country varchar(255),
	ModifiedDate date
);

insert into CUSTOMER(CustomerID,Name,Street,City,State,Zip,Country,ModifiedDate)
	values('111','Vikas','Frazer Road','Patna','Bihar','801105','India',curdate());
insert into CUSTOMER(CustomerID,Name,Street,City,State,Zip,Country,ModifiedDate)
	values('222','Nakul','Nehru Road','Varanasi','UP','221454','India',curdate());
insert into CUSTOMER(CustomerID,Name,Street,City,State,Zip,Country,ModifiedDate)
	values('444','Arjun','Wall Street','Varanasi','UP','221454','India',curdate());

create table LOAN(
	LoanID varchar(255) primary key,
	AccountID varchar(255),
	BranchID varchar(255),
	LoanNumber varchar(255),
	LoanType varchar(255) check(LoanType='Personal' or LoanType='Home' or LoanType='Car'),
	Amount integer,
	ModifiedDate date,
	foreign key(AccountID) references ACCOUNT(AccountID) on delete cascade,
	foreign key(BranchID) references BRANCH(BranchID) on delete cascade
);

insert into LOAN(LoanID,AccountID,BranchID,LoanNumber,LoanType,Amount,ModifiedDate)
	values('1111','11','1','4567','Personal',150000,curdate());
insert into LOAN(LoanID,AccountID,BranchID,LoanNumber,LoanType,Amount,ModifiedDate)
	values('1254','11','1','5589','Home',5500000,curdate());
insert into LOAN(LoanID,AccountID,BranchID,LoanNumber,LoanType,Amount,ModifiedDate)
	values('1224','11','1','6798','Car',900000,curdate());
insert into LOAN(LoanID,AccountID,BranchID,LoanNumber,LoanType,Amount,ModifiedDate)
	values('5455','44','2','8899','Car',545000,curdate());
insert into LOAN(LoanID,AccountID,BranchID,LoanNumber,LoanType,Amount,ModifiedDate)
	values('6666','55','2','9999','Personal',545000,curdate());
insert into LOAN(LoanID,AccountID,BranchID,LoanNumber,LoanType,Amount,ModifiedDate)
	values('7777','55','2','9876','Home',545000,curdate());
insert into LOAN(LoanID,AccountID,BranchID,LoanNumber,LoanType,Amount,ModifiedDate)
	values('8888','55','2','9988','Car',545000,curdate());	

create table DEPOSITOR(
	CustomerID varchar(255),
	AccountID varchar(255),
	ModifiedDate date,
	PRIMARY KEY ( CustomerID, AccountID ),
	FOREIGN KEY ( AccountID ) REFERENCES ACCOUNT(AccountID) ON DELETE CASCADE,
	FOREIGN KEY ( CustomerID ) REFERENCES CUSTOMER(CustomerID) on delete cascade
);

insert into DEPOSITOR(CustomerID,AccountID,ModifiedDate)
	values('111','11',curdate());
insert into DEPOSITOR(CustomerID,AccountID,ModifiedDate)
	values('222','22',curdate());
insert into DEPOSITOR(CustomerID,AccountID,ModifiedDate)
	values('111','33',curdate());
insert into DEPOSITOR(CustomerID,AccountID,ModifiedDate)
	values('222','44',curdate());

create table BORROWER(
	CustomerID varchar(255),
	LoanID varchar(255),
	ModifiedDate date,
	PRIMARY KEY ( CustomerID, LoanID ),
	FOREIGN KEY ( CustomerID ) REFERENCES CUSTOMER(CustomerID) on delete cascade,
	FOREIGN KEY ( LoanID ) REFERENCES LOAN(LoanID) on delete cascade
);

insert into BORROWER(CustomerID,LoanID,ModifiedDate)
	values('111','1111',curdate());
insert into BORROWER(CustomerID,LoanID,ModifiedDate)
	values('111','1254',curdate());
insert into BORROWER(CustomerID,LoanID,ModifiedDate)
	values('111','1224',curdate());
insert into BORROWER(CustomerID,LoanID,ModifiedDate)
	values('222','5455',curdate());
insert into BORROWER(CustomerID,LoanID,ModifiedDate)
	values('444','6666',curdate());
insert into BORROWER(CustomerID,LoanID,ModifiedDate)
	values('444','7777',curdate());
insert into BORROWER(CustomerID,LoanID,ModifiedDate)
	values('444','8888',curdate());

create table TRANSACTION(
	TransactionID varchar(255),
	AccountID varchar(255),
	TranType varchar(255),
	Amount int,
	ModifiedDate date,
	PRIMARY KEY ( TransactionID ),
	FOREIGN KEY ( AccountID ) REFERENCES ACCOUNT(AccountID) ON DELETE CASCADE
);

/*1
Update the balance of those customers by decreasing 3% of their balance whose
balance is below 3000*/
update ACCOUNT
	set Balance=0.97*Balance
	where Balance<3000;

/*2
Delete the entry of customer whose balance is below 500 and savepoint (sp1)*/
savepoint sp1;
commit;
delete from CUSTOMER
	where CustomerID in(
		select CustomerID from DEPOSITOR inner join ACCOUNT
			on DEPOSITOR.AccountID=ACCOUNT.AccountID and Balance<500);

delete from CUSTOMER
	where CustomerID in(
		select CustomerID from BORROWER inner join LOAN
			on BORROWER.LoanID=LOAN.LoanID inner join ACCOUNT on
			ACCOUNT.AccountID=LOAN.AccountID
			and Balance<500);

/*3
List all the customer details who have taken atleast 2 loans*/
select * from CUSTOMER where CustomerID in(
	select CUSTOMER.CustomerID from BORROWER inner join CUSTOMER on
		BORROWER.CustomerID=CUSTOMER.CustomerID
		group by CustomerID
		having count(LoanID)>1	
);

/*4
Delete the customers who have taken all 3 type of loans*/
delete from CUSTOMER where CustomerID in(
	select CustomerID from(
	select CUSTOMER.CustomerID from BORROWER inner join CUSTOMER
		on BORROWER.CustomerID=CUSTOMER.CustomerID inner join LOAN
		on BORROWER.LoanID=LOAN.LoanID
		group by CUSTOMER.CustomerID
		having count(distinct LoanType)=3)as c);

/*5
Execute rollback command till sp1 and commit*/
rollback to sp1;
commit;

/*6
Lock(read) the table Account and increase the balance of the customers by
5% whose balance > 10000.*/
lock table ACCOUNT read;
update ACCOUNT
	set Balance=1.05*Balance
	where Balance>10000;

/*7
Unlock the Account table and apply write lock on the same table(account). Then
increase the balance of the customers by 5% whose balance > 10000.*/
unlock tables;
lock table ACCOUNT write;
update ACCOUNT
	set Balance=1.05*Balance
	where Balance>10000;

/*8
Unlock all the tables*/
unlock tables;
