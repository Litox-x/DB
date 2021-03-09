use Z_UNIVER
--1
Drop function count_students;
go
create function count_students (@faculty varchar (20)) returns int
	as begin declare @count int = 0;
	set @count = (select count(*) from FACULTY as F
								inner join GROUPS as G
								on F.FACULTY = G.Faculty
								inner join Student as S
								on S.IDGROUP = G.IDGROUP
					where F.FACULTY like @faculty)
	return @count
	end;

go
declare  @count int = 0
set @count = dbo.count_students('ËÕÔ');
print 'count student = '+cast(@count as varchar(4));

go
alter function count_students(@faculty varchar (20),@prof varchar(20)) returns int
	as begin declare @count int = 0;
	set @count = (select count(*) from FACULTY as F
								inner join GROUPS as G
								on F.FACULTY = G.Faculty
								inner join Student as S
								on S.IDGROUP = G.IDGROUP
					where F.FACULTY like @faculty and G.PROFESSION like @prof)
	return @count
	end;
go

declare  @count int = 0
set @count = dbo.count_students('ËÕÔ','1-75 02 01');
print 'count student = '+cast(@count as varchar(4));

--2

go
create function fsubjects(@p varchar(20)) returns char(300)
	as begin 
	declare @tv varchar(200), @t nvarchar (300) = N'Äèñöèïëèíû: ';
	declare subjectCursor cursor local static
		for select SUBJECT from subject where PULPIT like @p;
	open subjectCursor;
		fetch subjectCursor into @tv;
		while @@FETCH_STATUS = 0
		begin 
			set @t = @t + ' ' +rtrim(@tv) + '; ';
			fetch subjectCursor into @tv;
		end;
	return @t;
end;

go 
select PULPIT, dbo.fsubjects(PULPIT) as Subjects from PULPIT

--3
go
create function FFACPUL (@FACULTY varchar(20),@pulpit varchar(20)) returns table as return
	select F.FACULTY, P.Pulpit
	from FACULTY as F
	left join PULPIT as P
	on F.FACULTY = P.FACULTY
	where F.FACULTY = ISNULL(@FACULTY,F.FACULTY) and
	P.PULPIT = ISNULL(@pulpit, P.PULPIT);

go
select * from dbo.FFACPUL(null,null)
select * from dbo.FFACPUL('ËÕÔ',null)
select * from dbo.FFACPUL(null,'ËÂ')
select * from dbo.FFACPUL('ËÕÔ','ËÂ')
go

--4
create function fteacher(@pulpit varchar(30)) returns int as
begin
	declare @countTeacher int = (select count(*) from TEACHER as T where T.PULPIT = ISNULL(@pulpit,T.PULPIT))
	return @countTeacher;
end
go

select Pulpit, dbo.fteacher(PULPIT) as countTeacher
from PULPIT
--5
go 

create function CountPulp(@faculty varchar(20)) returns int as
begin
declare @count int = (select count(PULPIT) from PULPIT where FACULTY = @faculty);
return @count;
end
go
create function CountGroup(@faculty varchar(20)) returns int as
begin
declare @count int = (select count(IDGROUP) from GROUPS where FACULTY = @faculty);
return @count;
end
go
create function CountSpec(@faculty varchar(20)) returns int as
begin
declare @count int = (select count(PROFESSION) from PROFESSION where FACULTY = @faculty);
return @count;
end

go

create function FACULTY_REPORT(@count int) returns @faculty_report table
             (faculty varchar(50),count_pulpit int,count_group int,count_student int,count_speciality int)
as begin 
	declare cc CURSOR static for 
	select FACULTY from FACULTY 
		where dbo.COUNT_STUDENTS(FACULTY,'1-75 02 01') > 0; 		
	declare @f varchar(30);
	open cc;  
    fetch cc into @f;
		while @@fetch_status = 0
	    begin
			insert @faculty_report values( @f,dbo.CountPulp(@f),dbo.CountGroup(@f),dbo.COUNT_STUDENTS(@f, default),dbo.CountSpec(@f)); 
	   fetch cc into @f;  
	   end;   
       return; 
	end;

Select * from FACULTY_REPORT(0)
drop function FACULTY_REPORT;