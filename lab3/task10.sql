use Ostapuk_UNIVER
DROP TABLE STUDENT
CREATE TABLE STUDENT
(
�����_������� int primary key,
��� nvarchar(50) not null unique,
����_�������� date,
��� nchar(1) default '�' check (��� in ('�', '�')),
����_����������� date 
)

INSERT into STUDENT (�����_�������,���,����_��������,���,����_�����������) values
(12345678,'������� ������ ����������','2000-10-05','�','2018-05-11'),
(12345679,'����� ������ ���������','2000-10-05','�','2018-05-11'),
(12345670,'���� ������ ����������','2000-10-05','�','2018-05-11'),
(12345673,'�������� ��������� �������������','1999-04-05','�','2018-05-11'),
(12345672,'����������� ���� ���������','2002-10-05','�','2019-05-11')

SELECT * FROM STUDENT WHERE ��� LIKE '�%'
SELECT ��� [�] FROM STUDENT WHERE ��� LIKE '�%'
SELECT * FROM STUDENT where DATEDIFF(year, ����_��������,����_�����������)>=18 and ���='�'
and
 datepart(month,����_��������)<=datepart(month,����_�����������)
and
 datepart(day,����_��������)<=datepart(day,����_�����������) 
 