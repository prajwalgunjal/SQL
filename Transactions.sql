create table empTransactions (
id int,
name varchar (50),
dept varchar(50),
age int,
sal int
)

insert into empTransactions values 
(1,'a','it',11,1000),
(2,'b','mech',21,2000),
(3,'c','electrical',22,3000),
(4,'d','help',44,4000)


------------AUTOCOMMIT  (Default)-------------------------
insert into empTransactions values(5,'e','tech',55,1000)
update empTransactions set sal=8888 where id=1
delete from empTransactions where id=2
select @@TRANCOUNT

----------------- Implicit transactions

-- enable inplicit transaction

set implicit_Transactions on

Insert Into empTransactions values (110,'f','ieie',88,4000)
update empTransactions set sal=0000 where id=1
delete from empTransactions where id=3

--select @@TRANCOUNT as countoftransaction
--commit
--select @@TRANCOUNT as countoftransaction
-- jar 1 asel tr commit kara nai tr rollback

declare @choice int 
set @choice =1;
if @choice=1
begin 
commit 
end 
else
begin 
rollback
end 

--------------------Explicit

insert into empTransactions values(5,'e','tech',55,1000)
update empTransactions set sal=8888 where id=1
delete from empTransactions where id=2
select @@TRANCOUNT

----------------- Implicit transactions

-- enable inplicit transaction

BEGIN TRANSACTION
Insert Into empTransactions values (110,'f','ieie',88,4000)
update empTransactions set sal=0000 where id=1
delete from empTransactions where id=3

--select @@TRANCOUNT as countoftransaction
--commit
--select @@TRANCOUNT as countoftransaction
-- jar 1 asel tr commit kara nai tr rollback

declare @choice int 
set @choice =1;
if @choice=1
begin 
commit 
end 
else
begin 
rollback
end 



-------------savepoint 
BEGIN TRANSACTION
	INSERT INTO empTransactions values (150,'z','uuu',77,7787)
	save transaction Deletepoint 
	delete empTransactions where id =1;
	delete empTransactions where id =4;
	rollback transaction Deletepoint
	commit 