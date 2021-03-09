use Z_UNIVER

--1

declare @a char = 'a',
@b varchar(4) = 'adas';
declare @c datetime, @d time;
set @c = (select BDAY from STUDENT WHERE IDSTUDENT = 1007);
set @d = '18:30:13';
declare @e int, @f smallint, @g tinyint, @h numeric(12,5);
set @e = (select count(*) from AUDITORIUM);
set @f = (select NOTE from PROGRESS WHERE SUBJECT = 'OAIP' AND IDSTUDENT = 1007);
set @g = (select count(*) from PULPIT);
SELECT @a, @b, @c, @d;
PRINT 'Number of auditorium = ' + convert(nvarchar(10),@e);
print 'Note of the 1007 student by OAIP = ' + CONVERt(NVARCHAR(10), @f) + ', Number of pulpit = ' + convert(nvarchar(10), @g);

--2

declare @x1 INT = (select sum(AUDITORIUM_CAPACITY) FROM AUDITORIUM), @x2 tinyint, @x3 float,
@y1 float = (select avg(AUDITORIUM_CAPACITY) FROM AUDITORIUM), @x4 tinyint, @x5 float;
if @x1 > 200
begin
select @x2 = (select count(*) from AUDITORIUM),
@x3 = (select avg(AUDITORIUM_CAPACITY) FROM AUDITORIUM where AUDITORIUM_CAPACITY < @y1),
@x4  = (select count(*) from AUDITORIUM where AUDITORIUM_CAPACITY < @y1),
@x5 = (@x4 * 100)/ @x2
select @x2 'Общее количсетво аудиторий', @x3 'средняя вместимость аудиторий меньше средней', @x4 'Количество аудиторий вместимсоть которых меньше средней',
@x5 'Процент аудиторий вместимость которых меньше среднего'
end
else
print 'Сумма вместимостей аудиторий'

--3
PRINT @@ROWCOUNT
PRINT @@VERSION
PRINT @@SPID
PRINT @@ERROR
PRINT @@SERVERNAME
PRINT @@TRANCOUNT
PRINT @@FETCH_STATUS
PRINT @@NESTLEVEL

--4


DECLARE @t float=5,@x float=6,@shag float= 1, @N int= 15, @z float=0
	begin
		IF (@t>@x)
		begin
			SET @z=sin(@t)*sin(@t);
		end
		ELSE IF (@t<@x)
		begin
			SET @z=4*(@t+@x);
		end
		ELSE IF (@t=@x)
		begin
			SET @z=1-exp(@x-2);
		end
		PRINT 'z='+cast(@z as nvarchar(50))
	end


DECLARE @student nvarchar(50),
@surname nvarchar(50),
@name nvarchar(50),
@lastname nvarchar(50),
@result nvarchar(50)
SET @student='Ostapuk Sergey Viktorivich'
SET @surname=rtrim(ltrim(substring(@student,1,CHARINDEX(' ',@student,1))))
SET @name=rtrim(ltrim(right(@student,len(@student)-len(@surname))))
set @name=rtrim(ltrim(SUBSTRING(@name,1,CHARINDEX(' ',@name,1))))
SET @lastname=rtrim(ltrim(right(@student,len(@student)-(len(@surname)+len(@name)))))
set @lastname=rtrim(ltrim(right(@lastname,len(@lastname) - CHARINDEX(' ',@lastname,1))))
SET @result=@surname+' '+left(@name,1)+'.'+left(@lastname,1)+'.'
PRINT 'Start name: '+@student
PRINT 'Change name: '+@result

use Z_UNIVER
declare @day nvarchar(50)=sysdatetime()
print @day
SET @day=format((cast(substring(@day,6,2) as int) + 1), '00')
--print @day
SELECT S.NAME,S.BDAY,AGE=(YEAR(SYSDATETIME())-YEAR(S.BDAY)) FROM STUDENT AS S
WHERE format(MONTH(S.BDAY),'00') like @day


--use Z_UNIVER
--declare @dateTimeNow nvarchar(50)=sysdatetime(),
--		@time nvarchar(50),
--		@codeMonth int,
--		@codeYear int,
--		@result1 int,
--		@countN int,
--		@studentName varchar(50),
--		@day1 varchar(20),
--		@ofs int
--		set @ofs = 0
--		set @countN = (SELECT count(*) FROM PROGRESS AS P
--						INNER JOIN STUDENT AS S
--						ON P.IDSTUDENT=S.IDSTUDENT
--						WHERE P.SUBJECT LIKE '%SUBD%'
--						)
--while @countN > 0
--begin
--	set @time = (SELECT P.PDATE FROM PROGRESS AS P
--						INNER JOIN STUDENT AS S
--						ON P.IDSTUDENT=S.IDSTUDENT
--						WHERE P.SUBJECT LIKE '%SUBD%'
--						order by s.NAME
--						Offset @ofs rows fetch first 1 rows only);
--	set @codeYear = (6+cast(substring(@time,3,2)as int) + cast(substring(@time,3,2)as int)/7)%7
--	set @codeMonth = cast(substring(@time,6,2) as int);
--	if (@codeMonth = 1 or @codeMonth = 10) set @codeMonth = 1
--	if (@codeMonth = 2 or @codeMonth = 3 or @codeMonth = 11) set @codeMonth = 4
--	if (@codeMonth = 5) set @codeMonth = 2
--	if (@codeMonth = 8) set @codeMonth = 3
--	if (@codeMonth = 6) set @codeMonth = 5
--	if (@codeMonth = 12 or @codeMonth = 9) set @codeMonth = 6
--	if (@codeMonth = 4 or @codeMonth = 7) set @codeMonth = 0
--	set @result1 = (cast(substring(@time,3,2)as int)+@codeMonth+@codeyear)%7
--	if(@result1 = 0) set @day1 = 'St'
--	if(@result1 = 1) set @day1 = 'Sun'
--	if(@result1 = 2) set @day1 = 'Mon'
--	if(@result1 = 3) set @day1 = 'Tu'
--	if(@result1 = 4) set @day1 = 'Wen'
--	if(@result1 = 5) set @day1 = 'Thu'
--	if(@result1 = 6) set @day1 = 'Fr'
--	set @studentName = cast((SELECT s.NAME FROM PROGRESS AS P
--						INNER JOIN STUDENT AS S
--						ON P.IDSTUDENT=S.IDSTUDENT
--						WHERE P.SUBJECT LIKE '%SUBD%'
--						order by s.NAME
--						Offset @ofs rows fetch first 1 rows only)as varchar(50)) ;
--	print @day1 + ' - '+ @studentName;
--	set @ofs+=1
--	set @countN-=1
--end

use Z_UNIVER
declare @dateTimeNow nvarchar(50)=sysdatetime(),
		@time nvarchar(50),
		@result1 int,
		@countN int,
		@studentName varchar(50),
		@day1 varchar(20),
		@ofs int,
		@m int
		set @ofs = 0
		set @countN = (SELECT count(*) FROM PROGRESS AS P
						INNER JOIN STUDENT AS S
						ON P.IDSTUDENT=S.IDSTUDENT
						WHERE P.SUBJECT LIKE '%КГ%'
						)
while @countN > 0
begin 
	set @time = (SELECT P.PDATE FROM PROGRESS AS P
						INNER JOIN STUDENT AS S
						ON P.IDSTUDENT=S.IDSTUDENT
						WHERE P.SUBJECT LIKE '%КГ%'
						order by s.NAME
						Offset @ofs rows fetch first 1 rows only)
	set @day1 = day(@time)
	if(@day1 = day(getdate())) set @m = 0
	if(@day1 = day(getdate())) set @m = 1
	if(@day1 = day(getdate())) set @m = 2
	if(@day1 = day(getdate())) set @m = 3
	if(@day1 = day(getdate())) set @m = 4
	if(@day1 = day(getdate())) set @m = 5
	if(@day1 = day(getdate())) set @m = 6
	set @result1 = datename(weekday, dateadd(day, @m,getdate()))
	set @studentName = cast((SELECT s.NAME FROM PROGRESS AS P
					INNER JOIN STUDENT AS S
					ON P.IDSTUDENT=S.IDSTUDENT
					WHERE P.SUBJECT LIKE '%КГ%'
					order by s.NAME
					Offset @ofs rows fetch first 1 rows only)as varchar(50));
select @result1;
set @ofs+=1
set @countN -= 1
end





--5
DECLARE @s float=0
SET @s=(SELECT CAST(AVG(P.NOTE) as float) from PROGRESS as P)
if @s>5
begin
	PRINT 'Students have a good knowledge at university'
end
else
	PRINT 'Students have a bad knowledge at university'


--6
use Z_UNIVER
SELECT *
FROM(SELECT CASE 
			WHEN NOTE <6 THEN '<6'
			WHEN NOTE BETWEEN 6 AND 7 THEN '6-7'
			WHEN NOTE BETWEEN 8 AND 9 THEN '8-9'
			END [NOTE],COUNT(*)[NUMBERS]
	FROM PROGRESS
	GROUP BY CASE  
			WHEN NOTE <6 THEN '<6'
			WHEN NOTE BETWEEN 6 AND 7 THEN '6-7'
			WHEN NOTE BETWEEN 8 AND 9 THEN '8-9'
			END) AS T
ORDER BY CASE[NOTE]
			WHEN '<6' THEN 3
			WHEN '6-7' THEN 2
			WHEN '8-9' THEN 1
			ELSE 0
			END



--7
CREATE TABLE #labs3 ( DATEOFEX DATE, IDSTUDENT int ,NOTE int)
 
DECLARE  @period INT, @stud int, @date DATE,@note int, @year int
SET @date = GETDATE()
SET @period = 10;
SET @stud = 1000;
SET @year=1
set @note=5
 
WHILE @period > 0
    BEGIN
        INSERT INTO #labs3 VALUES(@date, @stud,@note)
        SET @period = @period - 1
        SET @date = DATEADD(year, 1, @date)
        SET @stud = @stud + 1
		SET @note = rand()*(10 -1)+1
    END;
 
SELECT *
FROM #labs3

drop table #labs3

--8
DECLARE @m int=0
print @m+10
return
print @m+3

--9
use Z_UNIVER
begin try
UPDATE dbo.PROGRESS SET NOTE=-5
WHERE NOTE='6'
end try
begin catch
print ERROR_NUMBER() 
print ERROR_MESSAGE()
print ERROR_LINE()
print ERROR_PROCEDURE()
print ERROR_SEVERITY()
print ERROR_STATE()
end catch