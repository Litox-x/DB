--1
      set nocount on
	if  exists (select * from  SYS.OBJECTS       
	            where OBJECT_ID= object_id(N'DBO.X') )	            
	drop table X;           
	declare @c int, @flag char = 'y';
	SET IMPLICIT_TRANSACTIONS  ON  
	CREATE table X(K int );                        
		INSERT X values (1),(2),(3);
		set @c = (select count(*) from X);
		print 'количество строк в таблице X: ' + cast( @c as varchar(2));
		if @flag = 'c'  commit;                
	          else   rollback;                                
      SET IMPLICIT_TRANSACTIONS  OFF   
	
	if  exists (select * from  SYS.OBJECTS       
	            where OBJECT_ID= object_id(N'DBO.X') )
	print 'таблица X есть';  
      else print 'таблицы X нет'


--2
use Z_UNIVER
begin try
begin tran
--delete SUBJECT where SUBJECT ='KS'
delete SUBJECT where SUBJECT ='KLGS'
--insert SUBJECT values ('KS','Computer networks','ISiT');
insert SUBJECT values ('OAIP','Основы алгоритмизации и программирования','ISiT');
commit tran;
end try
begin catch
		print 'error: ' + case 
			when error_number() = 2627 and patindex('%PK_SUBJECT%', error_message()) > 0
          then N'дублирование предмета' 
          else N'неизвестная ошибка: '+cast(@@Trancount as  varchar(5))+ '=='+ cast(error_number() as  varchar(5))+ error_message()  
	  end; 
if @@TRANCOUNT >0 rollback;
end catch
--3
declare @point varchar(32);
begin try
begin tran
--delete SUBJECT where SUBJECT ='OOP'
set @point ='point1' ;save tran @point;
insert SUBJECT values ('ОООП','Объект ор прогр', 'Исит');
--delete SUBJECT where SUBJECT ='KMS'
set @point ='point2'; save tran @point;
insert SUBJECT values('KMS','Computer modeling system', 'ISiT');
commit tran;
end try
begin catch
print 'error: ' + case 
			when error_number() = 2627 and patindex('%PK_SUBJECT%', error_message()) > 0
          then N'дублирование предмета' 
          else N'неизвестная ошибка: '+cast(@@Trancount as  varchar(5))+ '=='+ cast(error_number() as  varchar(5))+ error_message()  
	  end; 
	  if @@TRANCOUNT > 0 
	  begin 
	  print 'kontrolnaia tochka: '+@point;
	  rollback tran @point;
	  commit tran;
	  end;
	  end catch;


--4
--A--
set transaction isolation level read uncommitted 
begin transaction 
--t1
	select @@SPID, 'insert FACULTY', N'результат', *
	from FACULTY 
	select @@SPID , 'update PULPIT', N'результат', *
	from PULPIT where FACULTY = 'IT';
--t2
commit;
--B--
begin transaction 
	select @@SPID
	insert FACULTY values ('MN','MoneyN');
	update PULPIT set FACULTY = N'LOO' where PULPIT = N'POiPS'
	select * from PULPIT
--t1
--t2
rollback;
go
--5
set transaction isolation level read committed 
begin transaction
	select count(*) from PULPIT
		where FACULTY = 'IT';
--t1
--t2
	select 'update PULPIT', N'результат', count(*)
	from PULPIT where FACULTY = 'IT';
commit;


begin transaction 
--t1
	update PULPIT set FACULTY = N'LH' where PULPIT = N'POiPS'
	commit;
--t2
USE Z_UNIVER
--6
--A
set transaction isolation level repeatable read
begin transaction
	select TEACHER_NAME from TEACHER
	where PULPIT = 'POiPS';
--t1
--t2
	select case 
	when TEACHER_NAME like '%Vladimir%' then 'insert TEACHER'
	else ''
	end N'результат ', TEACHER_NAME
	from TEACHER where PULPIT = 'POiPS';
	commit;

--B
begin transaction 
--t1
delete TEACHER where TEACHER_NAME like '%Vladimir%';
insert TEACHER values('PANA','Pacei Natali','f','POiPS')
commit
--T2

--7
DELETE TEACHER WHERE TEACHER_NAME LIKE '%Eduard%'
--A
set transaction isolation level serializable
begin tran
DELETE TEACHER WHERE TEACHER_NAME LIKE 'Pacei%'
insert TEACHER values('KhKI','Ostapuk Sergey','m','ISiT')
update TEACHER set TEACHER_NAME = 'Eduard Popkov' where TEACHER_NAME like '%Ostapuk%'
select TEACHER_NAME FROM TEACHER WHERE PULPIT LIKE 'ISiT'
--t1
select TEACHER_NAME FROM TEACHER WHERE PULPIT LIKE 'ISiT'
--t2
COMMIT

--B
BEGIN TRAN
DELETE TEACHER WHERE TEACHER_NAME LIKE 'Pacei%'
insert TEACHER values('KhKI','Ostapuk Sergey','m','ISiT')
update TEACHER set TEACHER_NAME = 'Eduard Popkov' where TEACHER_NAME like '%Ostapuk%'
select TEACHER_NAME FROM TEACHER WHERE PULPIT LIKE 'ISiT'
--t1
COMMIT
select TEACHER_NAME FROM TEACHER WHERE PULPIT LIKE 'ISiT'
--t2

--8
begin tran 
	insert FACULTY values ('PIM','Print Technologies');
	begin tran
		update PULPIT set FACULTY = 'PIM' where PULPIT = 'BP'
	commit;
	if @@TRANCOUNT >0 commit; --rollback отменит всё
	select (select count(*) from PULPIT where FACULTY = 'PIM') 'PULPIT',
	(select count(8) from FACULTY where FACULTY = 'PIM')  'FACULTY';

update PULPIT set FACULTY = 'IT' where PULPIT = 'BP'
delete faculty where FACULTY = 'PIM'