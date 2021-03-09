--task1
select rtrim(TEACHER.GENDER) as 'GENDER',
	   rtrim(TEACHER.PULPIT) as 'PULPIT', 
	   rtrim(TEACHER.TEACHER) as 'TEACHER', 
	   rtrim(TEACHER.TEACHER_NAME) as 'TEACHER'
	from TEACHER where PULPIT = '����' for xml path('teacher'), root('list_teacher'), elements;

--taks2
select rtrim(A.AUDITORIUM) as 'AUDITORIUM',
	   rtrim(A.AUDITORIUM_TYPE) as 'AUDITORIUM_TYPE',
	   rtrim(A.AUDITORIUM_CAPACITY) as 'AUDITORIUM_CAPACITY'
	from AUDITORIUM as A
	inner join AUDITORIUM_TYPE as A_T 
		on A.AUDITORIUM_TYPE = A_T.AUDITORIUM_TYPE
		where A_T.AUDITORIUM_TYPE = '��' for xml auto,
		root('List_auditorium'), elements;

--task3
declare @h int = 0,
@xml varchar(3000) = '<?xml version="1.0" encoding="windows-1251" ?>
                      <����������>
					     <���������� ���="����" ��������="������������ ��������� � �������" �������="����" />
						 <���������� ���="��" ��������="������ ����������" �������="����" />
						 <���������� ���="���" ��������="������ ������ ����������" �������="����" />
					  </����������>';

exec sp_xml_preparedocument @h output, @xml;
insert SUBJECT select[���], [��������], [�������] from openxml(@h, '/����������/����������',0)
    with([���] char(10), [��������] varchar(100), [�������] char(20));
go

select * from SUBJECT where SUBJECT.SUBJECT = '����' or SUBJECT.SUBJECT='��' or SUBJECT.SUBJECT='���';
delete from SUBJECT where SUBJECT.SUBJECT = '����' or SUBJECT.SUBJECT='��' or SUBJECT.SUBJECT='���';
go

--task4
------------------------------------------------------

insert into STUDENT(IDGROUP, NAME, BDAY, INFO) values(1, '������� ������ ����������', '14.09.2000',
                                                          '<�������>
														     <������� �����="��" �����="+1234567" ����="01.01.2010" />
															 <�������>12345678</�������>
															 <�����>
															    <������>��������</������>
																<�����>�����</�����>
																<�����>���������</�����>
																<���>25</���>
																<��������>212</��������>
															 </�����>
														  </�������>');

select * from STUDENT where NAME = '������� ������ ����������';

update STUDENT set INFO = '<�������>
						     <������� �����="��" �����="1234567" ����="01.01.2010" />
							 <�������>12345678</�������>
							 <�����>
							    <������>��������</������>
								<�����>�����</�����>
								<�����>���������</�����>
								<���>1</���>
								<��������>1</��������>
							 </�����>
						  </�������>'
where STUDENT.INFO.value('(/�������/�����/���)[1]','int') = 25;

select NAME, 
	INFO.value('(�������/�������/@�����)[1]', 'char(2)')[����� ��������],
	INFO.value('(�������/�������/@�����)[1]', 'varchar(20)')[����� ��������],
	INFO.query('/�������/�����')[�����]
from  STUDENT where NAME = '������� ������ ����������';

delete from STUDENT where NAME = '������� ������ ����������';

--task5

create xml schema collection Student as 
N'<?xml version="1.0" encoding="utf-16" ?>
<xs:schema attributeFormDefault="unqualified" 
   elementFormDefault="qualified"
   xmlns:xs="http://www.w3.org/2001/XMLSchema">
<xs:element name="�������">
<xs:complexType><xs:sequence>
<xs:element name="�������" maxOccurs="1" minOccurs="1">
  <xs:complexType>
    <xs:attribute name="�����" type="xs:string" use="required" />
    <xs:attribute name="�����" type="xs:unsignedInt" use="required"/>
    <xs:attribute name="����"  use="required">
	<xs:simpleType>  <xs:restriction base ="xs:string">
		<xs:pattern value="[0-9]{2}.[0-9]{2}.[0-9]{4}"/>
	 </xs:restriction> 	</xs:simpleType>
     </xs:attribute>
  </xs:complexType>
</xs:element>
<xs:element maxOccurs="3" name="�������" type="xs:unsignedInt"/>
<xs:element name="�����">   <xs:complexType><xs:sequence>
   <xs:element name="������" type="xs:string" />
   <xs:element name="�����" type="xs:string" />
   <xs:element name="�����" type="xs:string" />
   <xs:element name="���" type="xs:string" />
   <xs:element name="��������" type="xs:string" />
</xs:sequence></xs:complexType>  </xs:element>
</xs:sequence></xs:complexType>
</xs:element></xs:schema>';

alter table STUDENT alter column INFO xml(Student);

drop XML SCHEMA COLLECTION Student;

--task7
select 
	F.FACULTY as "@���",
	(
		select COUNT(*) from PULPIT as P where P.FACULTY = F.FACULTY
	) as "����������_������",
	(
		select 
			p.PULPIT as "@���",
			(
				select 
					T.TEACHER as "�������������/@���",
					T.TEACHER_NAME as "�������������"
				from 
					TEACHER as T where T.PULPIT = p.PULPIT
				for xml path(''),type, root('�������������')
			)
		from 
			PULPIT as p where p.FACULTY = F.FACULTY 
		for xml path('�������'), type, root('�������')
	) 
from
	FACULTY as F
for xml path('���������'), type, root('�����������')




