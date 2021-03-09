use Z_UNIVER

--task1

create table TR_AUDIT
(
	ID int identity,
	STMT varchar(20) check (STMT in ('INS' ,'DEL' , 'UPD')),
	TRNAME varchar(50),
	CC varchar(300)
)

create trigger TR_TEACHER_INS 
	on TEACHER after insert
as declare @a1 char(10), @a2 varchar(100), @a3 char(1), @a4 char(20), @in varchar(300);
print 'Insert Updates';
set @a1 = (select inserted.GENDER from inserted)
set @a2 = (select inserted.PULPIT from inserted)
set @a3 = (select inserted.TEACHER from inserted)
set @a4 = (select inserted.TEACHER_NAME from inserted)
set @in = @a1 + ' ' + @a2 + ' ' + @a3 + ' ' + @a4;
insert into TR_AUDIT(STMT, TRNAME, CC) values('INS', 'TR_TEACHER_INS', @in)
return

select * from TEACHER
insert into TEACHER values('БЛНВ', 'Блинова Евгения Александровна', 'ж', 'ИСиТ');
select * from TR_AUDIT

--task2

create  trigger TR_TEACHER_DEL 
      on TEACHER after DELETE  
      as declare @a1 char(10), @a2 varchar(100), @a3 char(1), @a4 char(20), @in varchar(300);
      print 'Delete operation';
      set @a1 = (select TEACHER from DELETED);
      set @a2= (select TEACHER_NAME from DELETED);
      set @a3= (select GENDER from DELETED);
	  set @a4 = (select PULPIT from DELETED);
      set @in = @a1+' '+ @a2 +' '+ @a3+ ' ' +@a4;
      insert into TR_AUDIT(STMT, TRNAME, CC)  
                            values('DEL', 'TR_TEACHER_DEL', @in);	         
      return;
go

select * from TEACHER
delete from TEACHER where TEACHER = 'БЛНВ'
select * from TR_AUDIT

--task3

create trigger TR_TEACHER_UPD 
      on TEACHER after UPDATE  
      as declare @a1 char(10), @a2 varchar(100), @a3 char(1), @a4 char(20), @in varchar(300);
      print 'Update operation';
      set @a1 = (select TEACHER from DELETED);
      set @a2= (select TEACHER_NAME from DELETED);
      set @a3= (select GENDER from DELETED);
	  set @a4 = (select PULPIT from DELETED);
      set @in = @a1+' '+ @a2 +' '+ @a3+ ' ' +@a4;
	  set @a1 = (select TEACHER from INSERTED);
      set @a2= (select TEACHER_NAME from INSERTED);
      set @a3= (select GENDER from INSERTED);
	  set @a4 = (select PULPIT from INSERTED);
      set @in = rtrim(@in) +' -> ' + @a1+' '+ @a2 +' '+ @a3+ ' ' +@a4;
      insert into TR_AUDIT(STMT, TRNAME, CC)  
                            values('UPD', 'TR_TEACHER_UPD', @in);	         
      return;  


insert into TEACHER values('БЛНВ', 'Блинова Евгения Александровна', 'ж', 'ОХ');
update TEACHER set PULPIT = 'ИСиТ' where TEACHER = 'БЛНВ'
select * from TR_AUDIT

drop table TR_AUDIT
drop trigger TR_TEACHER_INS

go

--task4

create trigger TR_TEACHER   on TEACHER after INSERT, DELETE, UPDATE  
 as declare @a1 char(10), @a2 varchar(100), @a3 char(1), @a4 char(20), @in varchar(300);
	  declare @ins int = (select count(*) from inserted),
              @del int = (select count(*) from deleted); 
   if  @ins > 0 and  @del = 0
   begin
   print 'Event: INSERT';
      set @a1 = (select TEACHER from INSERTED);
      set @a2= (select TEACHER_NAME from INSERTED);
      set @a3= (select GENDER from INSERTED);
	  set @a4 = (select PULPIT from INSERTED);
      set @in = @a1+' '+ @a2 +' '+ @a3+ ' ' +@a4;
      insert into TR_AUDIT(STMT, TRNAME, CC)  
                            values('INS', 'TR_TEACHER', @in);	
	 end;
	else		  	 
    if @ins = 0 and  @del > 0
	begin
	print 'Event: DELETE';
      set @a1 = (select TEACHER from DELETED);
      set @a2= (select TEACHER_NAME from DELETED);
      set @a3= (select GENDER from DELETED);
	  set @a4 = (select PULPIT from DELETED);
      set @in = @a1+' '+ @a2 +' '+ @a3+ ' ' +@a4;
      insert into TR_AUDIT(STMT, TRNAME, CC)  
                            values('DEL', 'TR_TEACHER', @in);
	  end;
	else	  
    if @ins > 0 and  @del > 0
	begin
	print 'Event: UPDATE'; 
      set @a1 = (select TEACHER from DELETED);
      set @a2= (select TEACHER_NAME from DELETED);
      set @a3= (select GENDER from DELETED);
	  set @a4 = (select PULPIT from DELETED);
      set @in = @a1+' '+ @a2 +' '+ @a3+ ' ' +@a4;
	  set @a1 = (select TEACHER from INSERTED);
      set @a2= (select TEACHER_NAME from INSERTED);
      set @a3= (select GENDER from INSERTED);
	  set @a4 = (select PULPIT from INSERTED);
      set @in = rtrim(@in) +' -> ' + @a1+' '+ @a2 +' '+ @a3+ ' ' +@a4;
      insert into TR_AUDIT(STMT, TRNAME, CC)  
                            values('UPD', 'TR_TEACHER', @in); 
	  end;
	  return;  
	  go


insert into TEACHER values ('ОСВ','Остапук Сергей Викторович','м','ОХ')
update TEACHER set PULPIT = 'ИСиТ' where TEACHER = 'ОРА'
delete TEACHER where TEACHER = 'ОРА'
select * from TR_AUDIT

--task5

insert into TEACHER values ('Err','Error in Gender','E','ПОИТ')
select * from TR_AUDIT
go

--task6

create trigger AUD_AFTER_DEL1 on TEACHER after DELETE  
as print 'AUD_AFTER_DEL1';
 return;  
go 

create trigger AUD_AFTER_DEL2 on TEACHER after DELETE  
as print 'AUD_AFTER_DEL2';
 return;  
go  

create trigger AUD_AFTER_DEL3 on TEACHER after DELETE  
as print 'AUD_AFTER_DEL3';
 return;  
go    


select t.name, e.type_desc 
  from sys.triggers  t join  sys.trigger_events e  on t.object_id = e.object_id  
  where OBJECT_NAME(t.parent_id)='TEACHER' and e.type_desc = 'DELETE' ;  

exec  SP_SETTRIGGERORDER @triggername = 'AUD_AFTER_DEL3', 
	                        @order='First', @stmttype = 'DELETE';
exec  SP_SETTRIGGERORDER @triggername = 'AUD_AFTER_DEL2', 
	                        @order='Last', @stmttype = 'DELETE';
go

--task7

create trigger TR_AUDITORIUM_CAPACITY 
	on AUDITORIUM after INSERT, DELETE, UPDATE  
	as declare @c int = (select sum(A.AUDITORIUM_CAPACITY) from AUDITORIUM as A); 	 
	 if (@c >= 500) 
	 begin
		raiserror('Common capasity must be less than 500', 10, 1);
		rollback; 
	 end; 
	 return;
go

insert into AUDITORIUM values ('Err', NULL, 90, 'Err');
go

--task8
	select * from FACULTY

	create trigger TR_FACULTY 
	on FACULTY instead of DELETE 
	as raiserror(N'Remove bloked', 10, 1);
	return;

	delete FACULTY where FACULTY = 'ИТ'

	drop trigger TR_FACULTY
	drop trigger TR_AUDITORIUM_CAPACITY 
	drop trigger TR_TEACHER
	drop trigger TR_TEACHER_UPD 
	drop trigger TR_TEACHER_INS 
	drop trigger TR_TEACHER_DEL
	drop trigger AUD_AFTER_DEL1
	drop trigger AUD_AFTER_DEL2
	drop trigger AUD_AFTER_DEL3
	go

--task9

create trigger DDL_FACULTY on database 
                          for DDL_DATABASE_LEVEL_EVENTS  as   
  declare @t varchar(50) =  EVENTDATA().value('(/EVENT_INSTANCE/EventType)[1]', 'varchar(50)');
  declare @t1 varchar(50) = EVENTDATA().value('(/EVENT_INSTANCE/ObjectName)[1]', 'varchar(50)');
  declare @t2 varchar(50) = EVENTDATA().value('(/EVENT_INSTANCE/ObjectType)[1]', 'varchar(50)'); 
  if @t1 = 'FACULTY' 
  begin
       print 'Тип события: '+@t;
       print 'Имя объекта: '+@t1;
       print 'Тип объекта: '+@t2;
       raiserror( N'операции с таблицей FACULTY запрещены', 16, 1);  
       rollback;    
   end;
go

drop trigger DDL_FACULTY

alter table FACULTY add Error varchar(50);
alter table FACULTY drop column Error;

-- *

create table WEATHER 
(
	City varchar(50),
	Start_Date smalldatetime,
	End_Date smalldatetime,
	Temperature float
)
go 

create trigger TR_WEATHER 
	on WEATHER for INSERT, UPDATE
	as declare @a1 varchar(50), @a2 smalldatetime, @a3 smalldatetime, @a4 float, @count int, @in varchar(300)
	begin
	  set @a1 = (select City from INSERTED);
      set @a2= (select Start_Date from INSERTED);
      set @a3= (select End_Date from INSERTED);
	  set @a4 = (select Temperature from INSERTED);
	  set @in = 'Dublicate: '+ @a1 + ' '+ cast(@a2 as varchar(20)) +' '+ cast(@a3 as varchar(20))+ ' ' +cast(@a4 as varchar(20));
	  set @count = (select count(*) from WEATHER as W where W.City = @a1 and W.Start_Date >= @a2 and W.End_Date <= @a3)
	  if @count > 1
		begin
			raiserror(@in, 11, 1);  
			rollback;
		end
	end
	return
go

insert into WEATHER values ('Минск','01-01-2017 00:00','01-01-2017 23:59', -6);
insert into WEATHER values ('Минск','01.01.2017 00:00','01.01.2017 23:58', -2);

select * from WEATHER;
delete from WEATHER;

drop table WEATHER;
drop trigger TR_WEATHER;