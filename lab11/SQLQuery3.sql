 use Z_UNIVER

declare @tv char(20),
		@t char(300) = '';
declare task1 cursor
	for select SUBJECT from SUBJECT where PULPIT = 'ИСИТ'

open task1;
fetch task1 into @tv;
print 'Предметы';
while @@FETCH_STATUS = 0                 
	begin 
		set @t = RTRIM(@tv) + ',' + @t;
		fetch task1 into @tv;
	end
	print @t
close task1 
deallocate task1 

go -- task2 локальный и глобальный


use Z_UNIVER

declare @tv char(20),
		@t char(300) = '';

declare task2 cursor local
	for select PROFESSION_NAME from PROFESSION
declare @tv char(40);
open task2
	fetch task2 into @tv 
	print '1.' + @tv
go
	fetch task2 into @tv 
	print '2.' + @tv
close task2
deallocate task2


use Z_UNIVER

declare task2 cursor global
	for select PROFESSION_NAME from PROFESSION
declare @tv char(40);
open task2
	fetch task2 into @tv 
	print '1.' + @tv
go
declare @tv char(40);
	fetch task2 into @tv 
	print '2.' + @tv
close task2
deallocate task2


--task3 static and dynamic cursors

use Z_UNIVER

DECLARE @note char(10), @id char(40), @sub char(1);  
DECLARE task3 CURSOR LOCAL STATIC                              
		 for select NOTE, IDSTUDENT, SUBJECT from PROGRESS where PROGRESS.SUBJECT = 'КГ'			   
open task3;
	print   'Количество строк : '+cast(@@CURSOR_ROWS as varchar(5)); 
	UPDATE PROGRESS set NOTE = 5 where IDSTUDENT = '1020';
	DELETE PROGRESS where IDSTUDENT = 1018;
	INSERT PROGRESS (IDSTUDENT, NOTE, SUBJECT) 
	                 values (1024, 8, 'БД'); 
	FETCH  task3 into @note, @id, @sub;     
	while @@fetch_status = 0                                    
	begin 
		print @note + ' '+ @id + ' '+ @sub;      
		fetch task3 into @note, @id, @sub; 
	end;          
CLOSE  task3;
deallocate task3;

DECLARE @note1 char(10), @id1 char(40), @sub1 char(1);  
DECLARE task3 CURSOR LOCAL DYNAMIC                             
		 for select NOTE, IDSTUDENT, SUBJECT from PROGRESS where PROGRESS.SUBJECT = 'КГ'			   
open task3;
	print   'Количество строк : '+cast(@@CURSOR_ROWS as varchar(5)); 
	UPDATE PROGRESS set NOTE = 5 where IDSTUDENT = '1020';
	DELETE PROGRESS where IDSTUDENT = 1018;
	INSERT PROGRESS (IDSTUDENT, NOTE, SUBJECT) 
	                 values (1024, 8, 'БД'); 
	FETCH  task3 into @note1, @id1, @sub1;     
	while @@fetch_status = 0                                    
	begin 
		print @note1 + ' '+ @id1 + ' '+ @sub1;      
		fetch task3 into @note1, @id1, @sub1; 
	end;          
CLOSE  task3;
deallocate task3;


-- task4 scroll up


DECLARE  @id4 int;  
DECLARE task4 cursor local static SCROLL                               
               for SELECT IDSTUDENT FROM STUDENT
                                              
OPEN task4;
	FETCH next from task4 into  @id4;					 
	print @id4;      
	
	FETCH  first from  task4 into @id4;					
	print @id4; 

	FETCH  prior from  task4 into @id4;					
	print @id4; 

	FETCH  last from  task4 into @id4;					  
	print @id4;      
	
	FETCH  absolute 3 from  task4 into @id4;			--3 строка от начала  
	print @id4;
	
	FETCH  relative 4 from task4 into @id4;				--4 строка от текущей
	print @id4; 
CLOSE task4;
deallocate task4;

--task5

declare @note5 int;
declare task5 cursor local dynamic
	for select NOTE from PROGRESS for update;
open task5
fetch task5 into @note5
delete PROGRESS where current of task5 
fetch task5 into @note5
update PROGRESS set NOTE += 1 
	where current of task5 
close task5 

go --task6

declare @name char(20), @note6 int;
declare task6 cursor local dynamic
	for select NAME,NOTE  from PROGRESS
		inner join STUDENT on STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
		inner join groups on STUDENT.IDGROUP = GROUPS.IDGROUP
		where PROGRESS.NOTE <= 4
		for update;
open task6
fetch task6 into @name,@note6
delete PROGRESS where current of task6 
close task6 


declare @note6_2 int;

declare task6 cursor local dynamic
	for select NOTE from PROGRESS where IDSTUDENT = 1014
		for update;
open task6
fetch task6 into @note6_2
update PROGRESS set NOTE += 1 
	where current of task6 
close task6 


use Z_UNIVER
select * from PROGRESS 

