
exec sp_helpindex 'AUDITORIUM_TYPE'
exec sp_helpindex 'AUDITORIUM'
exec sp_helpindex 'PULPIT'
exec sp_helpindex 'STUDENT'
exec sp_helpindex 'GROUPS'
exec sp_helpindex 'SUBJECT'
exec sp_helpindex 'FACULTY'
exec sp_helpindex 'TEACHER'
exec sp_helpindex 'PROGRESS'

create table #local1
(
	id int identity(1,1),
	num1 int
);


set nocount on;
DECLARE @i int = 0

while @i < 1000
begin
	insert #local1(num1) values(1000 * rand())
	set @i += 1
end

checkpoint;  --фиксация БД
DBCC DROPCLEANBUFFERS;  --очистить буферный кэш
select * from #local1 where num1 > 50 order by num1


checkpoint; 
DBCC DROPCLEANBUFFERS; 
CREATE clustered index #task1_index on #local1(num1 asc)
select * from #local1 where num1 > 50 order by num1


--task2
create table #local2
(
	id int identity(1,1),
	num1 int,
	num2 int
);


set nocount on;
DECLARE @j int = 0

while @j < 10000
begin
	insert #local2(num1, num2) values(1000 * rand(), 1000 * rand())
	set @j += 1
end

checkpoint; 
DBCC DROPCLEANBUFFERS;
select * from #local2 where num1 > 800 and num2 < 200

checkpoint; 
DBCC DROPCLEANBUFFERS;
CREATE index #task2_index on #local2(num1, num2)
select * from #local2 where num1 = 500 and num2 < 200


--task3
create table #local3
(
	id int identity(1,1),
	num1 int,
	num2 int
);


set nocount on;
DECLARE @k int = 0

while @k < 10000
begin
	insert #local3(num1, num2) values(1000 * rand(), 1000 * rand())
	set @k += 1
end

checkpoint; 
DBCC DROPCLEANBUFFERS;
select * from #local3 where num1 =500

create index #task3_index on  #local3(num1) include (num2);
select * from #local3 where num1 > 200

--task4
create table #local4
(
	id int identity(1,1),
	num1 int,
	num2 int
);


set nocount on;
DECLARE @m int = 0

while @m < 10000
begin
	insert #local4(num1, num2) values(1000 * rand(), 1000 * rand())
	set @m += 1
end

checkpoint; 
DBCC DROPCLEANBUFFERS;

create index #index_task4 on #local4(num1) where (num1 > 500)

select * from #local4 where num1 > 500


--task5
create table #local5
(
	id int identity(1,1),
	num1 int,
	num2 int
);


set nocount on;
DECLARE @n int = 0

while @n < 10000
begin
	insert #local5(num1, num2) values(100000 * rand(), 100000 * rand())
	set @n += 1
end

select * from #local5
checkpoint; 
DBCC DROPCLEANBUFFERS;

create index #index_task5 on #local5(num1) 

insert top(10000) #local5(num1, num2) select num1, num2 from #local5
SELECT name [Индекс], avg_fragmentation_in_percent [Фрагментация (%)]
        FROM sys.dm_db_index_physical_stats(DB_ID(N'TEMPDB'), 
        OBJECT_ID(N'#local5'), NULL, NULL, NULL) as ss
        JOIN sys.indexes ii on ss.object_id = ii.object_id and ss.index_id = ii.index_id  
        WHERE name is not null;


ALTER index #index_task5 on #local5 reorganize;
SELECT name [Индекс], avg_fragmentation_in_percent [Фрагментация (%)]
        FROM sys.dm_db_index_physical_stats(DB_ID(N'tempdb'), 
        OBJECT_ID(N'#local5'), NULL, NULL, NULL) ss
        JOIN sys.indexes ii on ss.object_id = ii.object_id and ss.index_id = ii.index_id  
        WHERE name is not null;

ALTER index #EX_TASK5 on #TEMP10000 rebuild with (online = off);
SELECT name [Индекс], avg_fragmentation_in_percent [Фрагментация (%)]
        FROM sys.dm_db_index_physical_stats(DB_ID(N'TEMPDB'), 
        OBJECT_ID(N'#local5'), NULL, NULL, NULL) ss
        JOIN sys.indexes ii on ss.object_id = ii.object_id and ss.index_id = ii.index_id  
        WHERE name is not null;
 

-- Задание 6
checkpoint; 
DBCC DROPCLEANBUFFERS;
DROP INDEX #index_task5 on #local5
CREATE index #index_task5 ON #local5(num1 asc) with (fillfactor = 50);

insert top(10000) #local5(num1,num2) select num1, num2 from #local5
SELECT name [Индекс], avg_fragmentation_in_percent [Фрагментация (%)]
        FROM sys.dm_db_index_physical_stats(DB_ID(N'TEMPDB'), 
        OBJECT_ID(N'#local5'), NULL, NULL, NULL) ss
        JOIN sys.indexes ii on ss.object_id = ii.object_id and ss.index_id = ii.index_id  
        WHERE name is not null;

drop table #local5
