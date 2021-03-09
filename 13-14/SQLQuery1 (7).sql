use Z_UNIVER
--1
   create table TR_AUDIT
   (
     ID   int  identity,    -- номер
     STMT varchar(20)       -- DML-оператор 
       check (STMT in ('INS', 'DEL','UPD')), 
     TRNAME varchar(50),    -- имя триггера
     CC     varchar(300)    -- комментарий 
    ) 
go
create  trigger TRIG_Teacher_Ins 
      on Teacher after INSERT  
      as
      declare @a1 varchar(50), @a2 varchar(50), @in varchar(300);
      print N'Операция вставки';
      set @a1 = (select TEACHER from INSERTED);
      set @a2= (select TEACHER_NAME from INSERTED);    
      set @in = @a1+' '+@a2;
      insert into TR_AUDIT(STMT, TRNAME, CC)  
          values('INS', 'TRIG_TEACHER_Ins ', @in);	         
      return;  
      go

     insert into  TEACHER(TEACHER, TEACHER_NAME,gender,PULPIT)
                   values(23, 'Ostapuk Sergey','m','POiPS');
	     select * from TR_AUDIT

		 select * from TEACHER

--2
go
create trigger TRIG_TEACHER_DEL  on TEACHER after DELETE
 as declare @a1 varchar(50), @a2 varchar(50), @in varchar(300);
 set @a1 = (select TEACHER from deleted);
 set @a2 = (select TEACHER_NAME from deleted);	 
	set @in = @a1+' '+@a2;
	insert into TR_AUDIT(STMT, TRNAME, CC)  values('DEL', 'TRIG_TEACHER_DEL', @in);
	return;  
go
                   
  delete from TEACHER where TEACHER = 23;                  

select * from TR_AUDIT 
go

--3

go
create trigger TRIG_TEACHER_UP  on TEACHER after UPDATE
 as declare @a1 varchar(50), @a2 varchar(50),@a11 varchar(50), @a22 varchar(50), @in varchar(300);
 set @a11 = (select TEACHER from INSERTED);
 set @a22= (select TEACHER_NAME from INSERTED);
 set @a1 = (select TEACHER from deleted);
 set @a2 = (select TEACHER_NAME from deleted);	 
	set @in = @a1+' '+@a2+' - '+@a11+' '+@a22;
	insert into TR_AUDIT(STMT, TRNAME, CC)  values('UPD', 'TRIG_TEACHER_UP', @in);
	return;  
go
                   
UPDATE TEACHER SET TEACHER_NAME = 'KOLYA' where TEACHER = 13;                  

select * from TR_AUDIT 
go

--4
go
create trigger TRIG_TEACHER  on TEACHER after INSERT, DELETE, UPDATE  
	as declare @a1 varchar(50), @a2 varchar(50), @in varchar(300);
	declare @ins int = (select count(*) from inserted),
			@del int = (select count(*) from deleted); 
if @ins = 0 and  @del = 0  begin print N'Событие: INSERT';
	set @a1 = (select TEACHER from inserted);
	set @a2 = (select TEACHER_NAME from inserted);	 
	set @in = @a1 + ' '+ @a2;
	insert into TR_AUDIT(STMT, TRNAME, CC)  values('INS', 'TRIG_TEACHER', @in);
	end;
else	
if @ins = 0 and  @del > 0  begin print 'Событие: DELETE';
	set @a1 = (select TEACHER from deleted);
	set @a2 = (select TEACHER_NAME from deleted);	 
	set @in = @a1+' '+ @a2;
	insert into TR_AUDIT(STMT, TRNAME, CC)  values('DEL', 'TRIG_TEACHER', @in);
	end;
else	  
if @ins > 0 and  @del > 0  begin print 'Событие: UPDATE'; 
	set @a1 = (select TEACHER from inserted);
	set @a2 = (select TEACHER_NAME from inserted);
	set @in = @a1+' '+ @a2;
	set @a1 = (select TEACHER from deleted);
	set @a2 = (select TEACHER_NAME from deleted);
    set @in = @a1+' '+@a2+' '+@in;
	insert into TR_AUDIT(STMT, TRNAME, CC)  values('UPD', 'TRIG_TEACHER', @in); 
	end;
return;  
go

	insert into  TEACHER(TEACHER, TEACHER_NAME,GENDER,PULPIT)
                                     values(23,'Ostapuk ', 'm','POiPS');                   
	delete TEACHER where TEACHER = 23;        
	update TEACHER set TEACHER_NAME = 'KOLYA YARMOLIC' where TEACHER = 13;                
	select * from TR_AUDIT 
go

--5
CREATE TABLE XUNIVER(
	A1 INT CHECK(A1 >=15)
);
GO
create  trigger TRIG_Ins 
      on XUNIVER after INSERT  
      as
      declare @a1 varchar(50);
      print N'Операция вставки';
      set @a1 = (select * from INSERTED);
      insert into TR_AUDIT(STMT, TRNAME, CC)  
          values('INS', 'TRIG_TEACHER_Ins ', @a1);	         
      return;  
      go
go
INSERT XUNIVER(A1) VALUES(3);

select * from TR_AUDIT
--6
go   
create trigger AUD_AFTER_DEL1 on TEACHER after DELETE  
as print 'AUD_AFTER_DEL_A';
 return;  
go 
create trigger AUD_AFTER_DEL2 on TEACHER after DELETE 
as print 'AUD_AFTER_DEL_B';
 return;  
go  
create trigger AUD_AFTER_DEL3 on TEACHER after DELETE  
as print 'AUD_AFTER_DEL_C';
 return;  
go     
  select t.name, e.type_desc 
  from sys.triggers  t join  sys.trigger_events e  on t.object_id = e.object_id  
  where OBJECT_NAME(t.parent_id)='TEACHER' and   e.type_desc = 'DELETE' ;    
exec  SP_SETTRIGGERORDER @triggername = 'AUD_AFTER_DEL3', 
	                        @order='First', @stmttype = 'DELETE';
exec  SP_SETTRIGGERORDER @triggername = 'AUD_AFTER_DEL1', 
	                        @order='Last', @stmttype = 'DELETE';

go

DELETE TEACHER WHERE TEACHER = 13

SELECT * FROM TR_AUDIT


--7
go 
create trigger Tov_Tran 
 on XUNIVER after INSERT, DELETE, UPDATE  
	as   declare @c int = (select count(*) from XUNIVER); 	 
	 if (@c >200) 
	 begin
       raiserror('Общая количество не может быть >200', 10, 1);
	rollback; 
	end;
return;          
go
declare @c int = 300;
while @c > 0 
begin
insert XUNIVER(A1) values (@c);
set @c = @c - 1;
end;

select * from XUNIVER

--8
go
drop trigger Tov_INSTEAD_OF 
go
use TMPF_UNIVER
go 
create trigger Tov_INSTEAD_OF on TEACHER instead of DELETE 
	as raiserror (N'Удаление запрещено из-за присутсвия нашего тригера', 10, 1);
return;
 delete from TEACHER where TEACHER = 9;  
 go
 
 select * from teacher

--9
drop trigger DDL_TMPF_UNIVER
go	
create  trigger DDL_TMPF_UNIVER on database 
for DDL_DATABASE_LEVEL_EVENTS  
     as   declare @t varchar(50)= EVENTDATA().value('(/EVENT_INSTANCE/EventType)[1]', 'varchar(50)');
     declare @t1 varchar(50)= 	 EVENTDATA().value('(/EVENT_INSTANCE/ObjectName)[1]', 'varchar(50)');
     declare @t2 varchar(50)= 	 EVENTDATA().value('(/EVENT_INSTANCE/ObjectType)[1]', 'varchar(50)'); 
   begin
   print 'Тип события: '+@t;
   print 'Имя объекта: '+@t1;
   print 'Тип объекта: '+@t2;
   raiserror( N'операции с таблицей запрещены', 16, 1);  
   rollback;    
   end;
 
   alter table TEACHER Drop Column  TEACHER_NAME;
go

 
 