use Ostapuk_UNIVER
drop table RESULTS
create table RESULTS
(
ID int primary key identity(1,1),
STUDENT_NAME nvarchar(20),
EXAM_MARK1 int,
EXAM_MARK2 int, 
AVER_VALUE as (EXAM_MARK1 + EXAM_MARK2)/2
)
INSERT into RESULTS (STUDENT_NAME, EXAM_MARK1, EXAM_MARK2)
 values ('�������',2, 4),
        ('��������',3, 4),
		('��������',9, 9),
		('���������',10, 7)
SELECT * FROM RESULTS
