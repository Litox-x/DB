Use Ostapuk_UNIVER
SELECT Номер_зачетки, Фамилия FROM STUDENT;
SELECT COUNT(*) From STUDENT;
SELECT * FROM STUDENT WHERE Фамилия = 'Остапук'
SELECT DISTINCT TOP(2) * FROM STUDENT ORDER BY Номер_зачетки Desc;