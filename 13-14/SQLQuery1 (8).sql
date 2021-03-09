USE Z_UNIVER
GO
--1

Drop PROCEDURE PSUBJECT

CREATE PROCEDURE PSUBJECT
AS BEGIN
declare @i int = (select count(*) from SUBJECT);
	select * from SUBJECT;
	return @i ;
end;

GO

declare @k int = 0;
exec @k = PSUBJECT;
print 'COUNT STRING = ' +cast(@k as varchar(3));


--2
go
alter procedure [dbo].[PSUBJECT]
	@p varchar(20),
	@c int output
as begin 
	declare @k int = (select count (*) from SUBJECT);
		print N'Параметры: @p='+@p+', @c='+cast(@c as varchar(3));
		select top(@c) * from SUBJECT where PULPIT = @p;
		set @c = @@ROWCOUNT;
		return @k;
end;

declare @k int = 0,@r int = 10,@p varchar(20) = 'ИСиТ';
exec @k = PSUBJECT @p, @c = @r output;
print N'Всего записей - ' + cast(@k as varchar(3));
print N'Кол-во записей с кафедрой '+@p +': '+cast(@r as varchar(3));
go

--3
SELECT INTO #SUBJECT
from exec PSUBJECT

alter procedure PSUBJECT 
@p varchar(20)
as  begin 
declare @k int = (select count(*) from SUBJECT );            
select * from SUBJECT  where PULPIT = @p;
end;

drop table #SUBJECT
create table #SUBJECT(
	SUBJECT varchar(10),
	SUB_NAME varchar(100),
	PULPIT varchar(20)
);

INSERT #SUBJECT exec PSUBJECT @p = 'ИСиТ'
SELECT * from #SUBJECT

--4
drop procedure PAUDITORIUM_INSERT

go
create procedure PAUDITORIUM_INSERT
	@a char(20), @n varchar(50), @c int = 0,@t char(10)
	as declare @rc int = 1;
begin try
insert into AUDITORIUM(AUDITORIUM,AUDITORIUM_NAME,AUDITORIUM_CAPACITY,AUDITORIUM_TYPE)
values(@a, @n, @c,@t)
return @rc;
end try 
begin catch
  print N'номер ошибки  : ' + cast(error_number() as varchar(6));
  print N'сообщение     : ' + error_message();
  print N'уровень       : ' + cast(error_severity()  as varchar(6));
  print N'метка         : ' + cast(error_state()     as varchar(8));
  print N'номер строки  : ' + cast(error_line()      as varchar(8));
  if error_procedure() is not  null   
  print N'имя процедуры : ' + error_procedure();
  return -1;
end  catch; 

declare @r int;
exec @r = PAUDITORIUM_INSERT @a ='304-3',@n='304-3',@c=20,@t='L'
print  N'код ошибки : ' + cast(@r as varchar(3)); 

--5

create procedure SUBJECT_REPORT  @p CHAR(50)
   as  
   declare @r int=0;                            
    begin try    
    declare @v char(20), @t char(300)=' ';  
    declare myTable CURSOR  for 
    select SUBJECT from SUBJECT where PULPIT =@p;
	if not exists(select * from SUBJECT where PULPIT =@p)
	raiserror('Error: @p',11,1);
	else open myTable;	  
	fetch  myTable into @v;   
	print   N'Список дисциплин: ';   
	 while @@fetch_status = 0                                     
       begin 
         set @t = rtrim(@v)+', '+@t;  
         set @r=@r+1;       
         fetch myTable into @v; 
      end;   
      print @t;        
      close  myTable;
   return @r;
       end try  
    begin catch              
print N'ошибка в параметрах' 
if error_procedure() is not null   
 print N'имя процедуры : ' + error_procedure();
 return @r;
     end  catch; 
 go

 drop procedure SUBJECT_REPORT;

declare @rc int;  
exec @rc=SUBJECT_REPORT @p ='ИСиТ';  
print N'количество записей = ' + cast(@rc as varchar(3)); 


--6
go
drop procedure PAUDITORIUN_Insert_X


create  procedure PAUDITORIUN_Insert_X
     @a char(20), @n varchar(50), @c int = 0,@t char(10), @tn VARCHAR(50)   
as  declare @rc int=1;                            
begin try 
set transaction isolation level SERIALIZABLE;          
begin tran
insert into AUDITORIUM_TYPE(AUDITORIUM_TYPE,AUDITORIUM_TYPENAME) values(@t,@tn)
exec @rc = PAUDITORIUM_INSERT @a,@n,@c,@t  
if @rc < 0 rollback tran;
else commit tran; 
return @rc;
end try
begin catch           
 if @@trancount > 0 rollback tran ; 
 return -1;	  
end catch;
go


declare @rc int;  
exec @rc=PAUDITORIUN_Insert_X @a ='104-3',@n='104-3',@c=20,@t='OL',@tn = 'OL'
print N'код ошибки=' + cast(@rc as varchar(3));  

