


--INSERT INTO COLOR (ID_color , Color_name)
--VALUES ('r' , 'red'),
--       ('gr', 'green'),
--       ('yell' , 'yellow');
--ALTER TABLE COLOR ADD  Color_name char (10) ;


--INSERT INTO CHOKO ( Choko, Color)
--VALUES ('Alenka' , 'r'),
--       ('Misha' , 'r'),
--       ('Chokolad' , 'gr'),
--       ('Sweet' , NULL);
       
       
 SELECT Choko ,   Color_name 
 FROM CHOKO ch FULL OUTER JOIN COLOR cl ON ch.Color = cl.ID_color;  
  
       /*�������� ������ ������� � �� �������� ������ �����*/
 SELECT Choko ,   Color_name 
 FROM CHOKO ch FULL OUTER JOIN COLOR cl ON ch.Color = cl.ID_color
 WHERE Color_name IS NOT NULL AND Choko IS NULL; 
       
       /*�������� ������ ����� � �� ������*/
SELECT Choko ,   Color_name 
 FROM CHOKO ch FULL OUTER JOIN COLOR cl ON ch.Color = cl.ID_color
 WHERE Color_name IS NULL AND Choko IS NOT NULL;
 
  /*�������� ������ ������ �  �����*/
SELECT Choko ,   Color_name 
 FROM CHOKO ch FULL OUTER JOIN COLOR cl ON ch.Color = cl.ID_color
 WHERE Color_name IS NOT NULL AND Choko IS NOT NULL;
 
 
