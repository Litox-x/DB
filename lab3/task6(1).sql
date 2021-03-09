USE Ostapuk_UNIVER
SELECT DISTINCT * FROM STUDENT 
   WHERE Номер_группы in (1,2,3,7,8,9)
SELECT * FROM STUDENT 
   WHERE Номер_зачетки between 1 and 20000000
Drop table Student