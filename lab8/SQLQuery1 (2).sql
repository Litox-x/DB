use Z_UNIVER
--1
--create view [Преподаватель]
--as select TEACHER[Учитель],
--TEACHER_NAME[ФИО],
--GENDER[Гендер],
--PULPIT[Кафедра] from TEACHER;
Select * from Преподаватель;
--2

create view [Количество кафедр]
as select FACULTY.FACULTY_NAME [ФАКУЛЬТЕТ],
count (PULPIT.PULPIT) [КОЛИЧЕСТВО КАФЕДР]
FROM FACULTY JOIN PULPIT 
ON FACULTY.FACULTY = PULPIT.FACULTY
group by FACULTY.FACULTY_NAME;

Insert [Количество кафедр] values(
'kl',32);
 
Select * from [Количество кафедр]
---3
create view Аудитории1(код, [тип аудитории], наименование)
as select AUDITORIUM, AUDITORIUM_TYPE, AUDITORIUM_NAME from AUDITORIUM
where AUDITORIUM_TYPE Like 'ЛК%';

insert Аудитории1 values(
1,'ЛК',1)

select * from Аудитории1;






create view Аудитории(код, [тип аудитории], наименование)
as select AUDITORIUM, AUDITORIUM_TYPE, AUDITORIUM_NAME FROM AUDITORIUM
WHERE AUDITORIUM_TYPE LIKE 'ЛК%' WITH CHECK OPTION
GO

SELECT * FROM Аудитории

INSERT Аудитории values(432, 'ЛБ4', 666)

CREATE VIEW ДИСЦИПЛИНЫ 
AS SELECT TOP 2 S.SUBJECT, S.SUBJECT_NAME, P.PULPIT 
FROM SUBJECT AS S INNER JOIN PULPIT AS P
ON S.PULPIT= P.PULPIT
ORDER BY S.SUBJECT

Select * from ДИСЦИПЛИНЫ

ALTER VIEW [Количество кафедр] WITH SCHEMABINDING
as select FACULTY.FACULTY_NAME [ФАКУЛЬТЕТ],
count (PULPIT.PULPIT) [КОЛИЧЕСТВО КАФЕДР]
FROM dbo.FACULTY JOIN dbo.PULPIT 
ON FACULTY.FACULTY = PULPIT.FACULTY
group by FACULTY.FACULTY_NAME;

Select * from [Количество кафедр]
