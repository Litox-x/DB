USE Z_UNIVER;
select AUDITORIUM , AUDITORIUM.AUDITORIUM_TYPE, AUDITORIUM_CAPACITY, AUDITORIUM_NAME, AUDITORIUM_TYPENAME from
AUDITORIUM cross join AUDITORIUM_TYPE
where AUDITORIUM.AUDITORIUM_TYPE = AUDITORIUM_TYPE.AUDITORIUM_TYPE
