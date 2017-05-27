set serveroutput on;

create or replace trigger deleteUser
after delete on players
referencing old as oldRow
for each row
declare
 v_user_id int;
begin
  select users_id into v_user_id from city where users_id = :oldRow.userid;
  execute immediate 'delete from user_buildings where users_id = '||v_user_id;
  execute immediate 'delete from city where users_id = '||v_user_id;
end;