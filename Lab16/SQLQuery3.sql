--task1
select rtrim(TEACHER.GENDER) as 'GENDER',
	   rtrim(TEACHER.PULPIT) as 'PULPIT', 
	   rtrim(TEACHER.TEACHER) as 'TEACHER', 
	   rtrim(TEACHER.TEACHER_NAME) as 'TEACHER'
	from TEACHER where PULPIT = 'ИСиТ' for xml path('teacher'), root('list_teacher'), elements;

--taks2
select rtrim(A.AUDITORIUM) as 'AUDITORIUM',
	   rtrim(A.AUDITORIUM_TYPE) as 'AUDITORIUM_TYPE',
	   rtrim(A.AUDITORIUM_CAPACITY) as 'AUDITORIUM_CAPACITY'
	from AUDITORIUM as A
	inner join AUDITORIUM_TYPE as A_T 
		on A.AUDITORIUM_TYPE = A_T.AUDITORIUM_TYPE
		where A_T.AUDITORIUM_TYPE = 'ЛК' for xml auto,
		root('List_auditorium'), elements;

--task3
declare @h int = 0,
@xml varchar(3000) = '<?xml version="1.0" encoding="windows-1251" ?>
                      <дисциплины>
					     <дисциплина код="КГиГ" название="Компьютерная геометрия и графика" кафедра="ИСиТ" />
						 <дисциплина код="ВМ" название="Высшая математика" кафедра="ИСиТ" />
						 <дисциплина код="ОЗИ" название="Основы защиты информации" кафедра="ИСиТ" />
					  </дисциплины>';

exec sp_xml_preparedocument @h output, @xml;
insert SUBJECT select[код], [название], [кафедра] from openxml(@h, '/дисциплины/дисциплина',0)
    with([код] char(10), [название] varchar(100), [кафедра] char(20));
go

select * from SUBJECT where SUBJECT.SUBJECT = 'КГиГ' or SUBJECT.SUBJECT='ВМ' or SUBJECT.SUBJECT='ОЗИ';
delete from SUBJECT where SUBJECT.SUBJECT = 'КГиГ' or SUBJECT.SUBJECT='ВМ' or SUBJECT.SUBJECT='ОЗИ';
go

--task4
------------------------------------------------------

insert into STUDENT(IDGROUP, NAME, BDAY, INFO) values(1, 'Остапук Сергей Викторович', '14.09.2000',
                                                          '<студент>
														     <паспорт серия="АВ" номер="+1234567" дата="01.01.2010" />
															 <телефон>12345678</телефон>
															 <адрес>
															    <страна>Беларусь</страна>
																<город>Минск</город>
																<улица>Бобруская</улица>
																<дом>25</дом>
																<квартира>212</квартира>
															 </адрес>
														  </студент>');

select * from STUDENT where NAME = 'Остапук Сергей Викторович';

update STUDENT set INFO = '<студент>
						     <паспорт серия="АВ" номер="1234567" дата="01.01.2010" />
							 <телефон>12345678</телефон>
							 <адрес>
							    <страна>Беларусь</страна>
								<город>Брест</город>
								<улица>Советская</улица>
								<дом>1</дом>
								<квартира>1</квартира>
							 </адрес>
						  </студент>'
where STUDENT.INFO.value('(/студент/адрес/дом)[1]','int') = 25;

select NAME, 
	INFO.value('(студент/паспорт/@серия)[1]', 'char(2)')[Серия паспорта],
	INFO.value('(студент/паспорт/@номер)[1]', 'varchar(20)')[Номер паспорта],
	INFO.query('/студент/адрес')[Адрес]
from  STUDENT where NAME = 'Остапук Сергей Викторович';

delete from STUDENT where NAME = 'Остапук Сергей Викторович';

--task5

create xml schema collection Student as 
N'<?xml version="1.0" encoding="utf-16" ?>
<xs:schema attributeFormDefault="unqualified" 
   elementFormDefault="qualified"
   xmlns:xs="http://www.w3.org/2001/XMLSchema">
<xs:element name="студент">
<xs:complexType><xs:sequence>
<xs:element name="паспорт" maxOccurs="1" minOccurs="1">
  <xs:complexType>
    <xs:attribute name="серия" type="xs:string" use="required" />
    <xs:attribute name="номер" type="xs:unsignedInt" use="required"/>
    <xs:attribute name="дата"  use="required">
	<xs:simpleType>  <xs:restriction base ="xs:string">
		<xs:pattern value="[0-9]{2}.[0-9]{2}.[0-9]{4}"/>
	 </xs:restriction> 	</xs:simpleType>
     </xs:attribute>
  </xs:complexType>
</xs:element>
<xs:element maxOccurs="3" name="телефон" type="xs:unsignedInt"/>
<xs:element name="адрес">   <xs:complexType><xs:sequence>
   <xs:element name="страна" type="xs:string" />
   <xs:element name="город" type="xs:string" />
   <xs:element name="улица" type="xs:string" />
   <xs:element name="дом" type="xs:string" />
   <xs:element name="квартира" type="xs:string" />
</xs:sequence></xs:complexType>  </xs:element>
</xs:sequence></xs:complexType>
</xs:element></xs:schema>';

alter table STUDENT alter column INFO xml(Student);

drop XML SCHEMA COLLECTION Student;

--task7
select 
	F.FACULTY as "@код",
	(
		select COUNT(*) from PULPIT as P where P.FACULTY = F.FACULTY
	) as "количество_кафедр",
	(
		select 
			p.PULPIT as "@код",
			(
				select 
					T.TEACHER as "преподаватель/@код",
					T.TEACHER_NAME as "преподаватель"
				from 
					TEACHER as T where T.PULPIT = p.PULPIT
				for xml path(''),type, root('преподаватели')
			)
		from 
			PULPIT as p where p.FACULTY = F.FACULTY 
		for xml path('кафедра'), type, root('кафедры')
	) 
from
	FACULTY as F
for xml path('факультет'), type, root('университет')




