


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
  
       /*содержит данные  правой и не содержит данные левой*/
 SELECT Choko ,   Color_name 
 FROM CHOKO ch FULL OUTER JOIN COLOR cl ON ch.Color = cl.ID_color
 WHERE Color_name IS NOT NULL AND Choko IS NULL; 
       
       /*содержит данные левой и не правой*/
SELECT Choko ,   Color_name 
 FROM CHOKO ch FULL OUTER JOIN COLOR cl ON ch.Color = cl.ID_color
 WHERE Color_name IS NULL AND Choko IS NOT NULL;
 
  /*содержит данные правой и  левой*/
SELECT Choko ,   Color_name 
 FROM CHOKO ch FULL OUTER JOIN COLOR cl ON ch.Color = cl.ID_color
 WHERE Color_name IS NOT NULL AND Choko IS NOT NULL;
 
 
