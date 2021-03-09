--1
use Z_UNIVER
exec SP_HELPINDEX  'AUDITORIUM'
exec SP_HELPINDEX  'AUDITORIUM_TYPE'
exec SP_HELPINDEX  'FACULTY'
exec SP_HELPINDEX  'GROUPS'
exec SP_HELPINDEX  'PROFESSION'
exec SP_HELPINDEX  'PULPIT'
exec SP_HELPINDEX  'STUDENT'
exec SP_HELPINDEX  'SUBJECT'
exec SP_HELPINDEX  'TEACHER'


CREATE TABLE #EXPLER
(
TIND INT,
TFIELD VARCHAR(100)
);

declare @a int=0;
while @a < 1001
begin
insert #EXPLER(TIND, TFIELD)
values(floor(20000*rand()), replicate('string',10));
if(@a % 100=0) print @a;
set @a +=1;
end;

select *from #EXPLER where TIND between 1500 and 2500 order by TIND

checkpoint;
dbcc dropcleanbuffers;

--2
create table #2EX
(
key1 int identity(1,1),
numb int
);
 
set nocount on;
declare @i int = 0;
while @i < 20000
begin
insert #2EX(numb) values(floor(100000*rand()));
set @i +=1;
end;

select count(*)[number of string] from #2EX;
select * from #2EX where numb between 9000 and 10000 order by key1

CREATE index #EX_NONCLU on #2EX(key1, numb)

select * from #2EX where key1>1500 and numb < 4500;
select * from #2EX order by key1, numb

select * from #2EX where key1 = 556 and numb > 3

--3
CREATE  index #EX_TKEY_X on #2EX(key1) INCLUDE (numb)

drop index #EX_TKEY_X on #2EX
SELECT numb from #2EX where key1>15000 

--4
SELECT key1 from  #2EX where key1 between 5000 and 19999; 
SELECT key1 from  #2EX where key1>15000 and  key1 < 20000  
SELECT key1 from  #2EX where key1=17000

CREATE  index #EX_WHERE on #2EX(key1) where (key1>=15000 and 
 key1 < 20000);  

 drop index #EX_WHERE on #2EX

--5
CREATE index #EX_TKEY ON #2EX(key1)

SELECT name [Индекс], avg_fragmentation_in_percent [Фрагментация (%)]
FROM sys.dm_db_index_physical_stats(DB_ID(N'TEMPDB'), 
OBJECT_ID(N'#2EX'), NULL, NULL, NULL) ss
JOIN sys.indexes ii on ss.object_id = ii.object_id and ss.index_id = ii.index_id  
WHERE name is not null;


--6

create table #task6(
	id int,
	value varchar(80),
	cc int identity(1,1),
);
go

set nocount on
declare @c int = 0;
while @c < 10000
begin
insert #task6 (id, value)
values(floor(4000*rand()), 'ratarata');
set @c = @c +1;
end;
go


select * from #task6 where id between 1000 and 2000

checkpoint ;
DBCC DROPCLEANBUFFERS;

create index #task6_i on #task6(id) with (fillfactor = 20);

drop table #task6