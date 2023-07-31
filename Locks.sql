create database LockDb
use LockDb

create table table1
(col1 int , 
col2 char(5))

insert into table1 values
(1,'A'),
(2,'B')

select* from table1


-- exclusive locking

begin tran
update table1
set col2 = 'C' 
where col1=2
-- now go to lock2
--rollback





-- shared locking 

set tran ISOLATION LEVEL REPEATABLE READ
BEGIN TRAN
	select * from table1

--NOW GO TO LOCK2 AND REF 2ND QUERY

