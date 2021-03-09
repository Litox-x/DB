USE Z_UNIVER;
select PULPIT.PULPIT as 'кафедра' , isnull(TEACHER.TEACHER, '***')  as 'преподаватель'
from PULPIT left join TEACHER on
PULPIT.PULPIT = TEACHER.PULPIT

select PULPIT.PULPIT as 'кафедра' , isnull(TEACHER.TEACHER, '***')  as 'преподаватель'
from TEACHER left join PULPIT on
PULPIT.PULPIT = TEACHER.PULPIT

select PULPIT.PULPIT as 'кафедра' , isnull(TEACHER.TEACHER, '***')  as 'преподаватель'
from TEACHER right join PULPIT on
PULPIT.PULPIT = TEACHER.PULPIT

