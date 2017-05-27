set serveroutput on;

create or replace trigger deleteCity
after delete on city
referencing old as oldRow
for each row
declare
 v_city_id int;
begin
  select cityid into v_city_id from user_buildings where cityid = :oldRow.cityid;
  execute immediate 'delete from user_buildings where cityid = '||v_city_id;
end;