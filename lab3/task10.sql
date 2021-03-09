use Ostapuk_UNIVER
DROP TABLE STUDENT
CREATE TABLE STUDENT
(
Номер_зачетки int primary key,
ФИО nvarchar(50) not null unique,
Дата_рождения date,
Пол nchar(1) default 'м' check (Пол in ('м', 'ж')),
Дата_поступления date 
)

INSERT into STUDENT (Номер_зачетки,ФИО,Дата_рождения,Пол,Дата_поступления) values
(12345678,'Остапук Сергей Викторович','2000-10-05','м','2018-05-11'),
(12345679,'Сухой Сергей Андреевич','2000-10-05','м','2018-05-11'),
(12345670,'Крыж Андрей Викторович','2000-10-05','м','2018-05-11'),
(12345673,'Баранова Анастасия Александровна','1999-04-05','ж','2018-05-11'),
(12345672,'Разумовская Ирма Батьковна','2002-10-05','ж','2019-05-11')

SELECT * FROM STUDENT WHERE ФИО LIKE 'О%'
SELECT ФИО [я] FROM STUDENT WHERE ФИО LIKE 'О%'
SELECT * FROM STUDENT where DATEDIFF(year, Дата_рождения,Дата_поступления)>=18 and Пол='ж'
and
 datepart(month,Дата_рождения)<=datepart(month,Дата_поступления)
and
 datepart(day,Дата_рождения)<=datepart(day,Дата_поступления) 
 