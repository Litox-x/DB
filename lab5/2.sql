use Z_UNIVER;
select FACULTY.FACULTY_NAME as '���������',PULPIT.PULPIT_NAME as '�������', PROFESSION.PROFESSION_NAME as '�������������',SUBJECT.SUBJECT_NAME as '����������', STUDENT.name as '���' , progress.SUBJECT as '�������',
case
	when (PROGRESS.NOTE = 6) then '�����'
	when (PROGRESS.NOTE = 7 )then '����'
	when (PROGRESS.NOTE = 8 )then '������'
	end '������ '
from faculty join pulpit on
	FACULTY.FACULTY = PULPIT.FACULTY
	join PROFESSION on 
	PROFESSION.FACULTY = FACULTY.FACULTY
	join GROUPS on 
	GROUPS.PROFESSION = PROFESSION.PROFESSION
	join SUBJECT on 
	SUBJECT.PULPIT = PULPIT.PULPIT
	join STUDENT on 
	STUDENT.IDGROUP = GROUPS.IDGROUP
	join PROGRESS on
	PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
	where PROGRESS.NOTE between 6 and 8
order by PROGRESS.NOTE desc 
	