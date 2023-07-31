use master
create table CursorTable(
RollNo int,
name varchar(100),
class varchar(100),
science int,
maths int,
english int,
)

insert into CursorTable values
(1,'Prajwal','12th',50,50,50),
(2,'Rahul','12th',20,58,50),
(3,'Suyash','12th',80,56,50),
(4,'sony','12th',90,88,50),
(5,'pankaj','12th',70,99,80),
(6,'patu','12th',58,22,77),
(7,'rushi','12th',40,66,98),
(8,'mohan','12th',45,77,65)

select * from CursorTable


declare @rollNo int,
@sname varchar(100),
@sciencem int,
@mathsm int,
@englishm int
declare 
@total int,
@percentage int 

declare studentcursor cursor for
select RollNo , name,science,maths,english from CursorTable

open studentcursor

fetch next from studentcursor into @rollNo,@sname,@sciencem,@mathsm,@englishm 

while @@FETCH_STATUS=0
begin 
print concat('Name:- ',@sname);
print concat('RollNo:- ',@rollNo);
print concat('Science:- ',@sciencem);
print concat('English:- ',@englishm);
print concat('Maths:- ',@mathsm);

set @total = @englishm+@mathsm+@sciencem

print concat('Total:- ',@total);
set @percentage = @total/3;
print concat('PErcentage:- ',@percentage)
print '--------------------------'
fetch next from studentcursor into @rollNo,@sname,@sciencem,@mathsm,@englishm 
end


CLOSE studentcursor;
DEALLOCATE studentcursor;
