USE Z_UNIVER;
select PULPIT.PULPIT as '�������' , isnull(TEACHER.TEACHER, '***')  as '�������������'
from PULPIT left join TEACHER on
PULPIT.PULPIT = TEACHER.PULPIT

select PULPIT.PULPIT as '�������' , isnull(TEACHER.TEACHER, '***')  as '�������������'
from TEACHER left join PULPIT on
PULPIT.PULPIT = TEACHER.PULPIT

select PULPIT.PULPIT as '�������' , isnull(TEACHER.TEACHER, '***')  as '�������������'
from TEACHER right join PULPIT on
PULPIT.PULPIT = TEACHER.PULPIT

