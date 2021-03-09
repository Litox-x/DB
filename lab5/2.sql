use Z_UNIVER;
select FACULTY.FACULTY_NAME as 'факультет',PULPIT.PULPIT_NAME as 'кафедра', PROFESSION.PROFESSION_NAME as 'специальность',SUBJECT.SUBJECT_NAME as 'дисциплина', STUDENT.name as 'имя' , progress.SUBJECT as 'предмет',
case
	when (PROGRESS.NOTE = 6) then 'шесть'
	when (PROGRESS.NOTE = 7 )then 'семь'
	when (PROGRESS.NOTE = 8 )then 'восемь'
	end 'оценка '
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
	