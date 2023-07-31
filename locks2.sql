-- exclusive locking
select * from table1 where col1=2





-- shared locking 
update table1 set col2 = 'xx' 
	where col1 =2
	commit tRAN 
	ROLLBACK