use Z_UNIVER
--1
--create view [�������������]
--as select TEACHER[�������],
--TEACHER_NAME[���],
--GENDER[������],
--PULPIT[�������] from TEACHER;
Select * from �������������;
--2

create view [���������� ������]
as select FACULTY.FACULTY_NAME [���������],
count (PULPIT.PULPIT) [���������� ������]
FROM FACULTY JOIN PULPIT 
ON FACULTY.FACULTY = PULPIT.FACULTY
group by FACULTY.FACULTY_NAME;

Insert [���������� ������] values(
'kl',32);
 
Select * from [���������� ������]
---3
create view ���������1(���, [��� ���������], ������������)
as select AUDITORIUM, AUDITORIUM_TYPE, AUDITORIUM_NAME from AUDITORIUM
where AUDITORIUM_TYPE Like '��%';

insert ���������1 values(
1,'��',1)

select * from ���������1;






create view ���������(���, [��� ���������], ������������)
as select AUDITORIUM, AUDITORIUM_TYPE, AUDITORIUM_NAME FROM AUDITORIUM
WHERE AUDITORIUM_TYPE LIKE '��%' WITH CHECK OPTION
GO

SELECT * FROM ���������

INSERT ��������� values(432, '��4', 666)

CREATE VIEW ���������� 
AS SELECT TOP 2 S.SUBJECT, S.SUBJECT_NAME, P.PULPIT 
FROM SUBJECT AS S INNER JOIN PULPIT AS P
ON S.PULPIT= P.PULPIT
ORDER BY S.SUBJECT

Select * from ����������

ALTER VIEW [���������� ������] WITH SCHEMABINDING
as select FACULTY.FACULTY_NAME [���������],
count (PULPIT.PULPIT) [���������� ������]
FROM dbo.FACULTY JOIN dbo.PULPIT 
ON FACULTY.FACULTY = PULPIT.FACULTY
group by FACULTY.FACULTY_NAME;

Select * from [���������� ������]
