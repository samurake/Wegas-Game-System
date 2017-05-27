create or replace trigger createUserTrigger
after insert on players
referencing new as newRow
for each row
declare
	v_user_id int;
	numb_city NUMBER(1,0);
	city_max_id NUMBER(10,0);
	build_entity_id NUMBER(10,0);
begin
	BEGIN
		select cityID into city_max_id from CITY where cityID =(select max(cityID) from CITY);
		EXCEPTION
			WHEN no_data_found
			THEN
			city_max_id := 0;
	END;
	BEGIN
	select entity_id into build_entity_id from user_buildings where entity_id =(select max(entity_id) from user_buildings);
	EXCEPTION
		WHEN no_data_found
		THEN
		build_entity_id := 0;
	END;
	city_max_id := city_max_id + 1;
	INSERT INTO CITY(users_id, cityID, cityPosX, cityPosY, cityPoints, StorageWood, StorageStone, StorageFood, StorageMaxCapacity)
	VALUES(:newRow.userid, city_max_id, dbms_random.value(0, 1000), dbms_random.value(0, 1000), 500, 200, 200, 200, 1000);

	build_entity_id := build_entity_id + 1;
	insert into user_buildings(users_id, building_id, cityID, building_points, entity_id, building_level)
	values(:newRow.userid, 1, city_max_id, 200, build_entity_id,1);

	build_entity_id := build_entity_id + 1;
	insert into user_buildings(users_id, building_id, cityID, building_points, entity_id, building_level)
	values(:newRow.userid, 2, city_max_id, 250, build_entity_id,1);

	build_entity_id := build_entity_id + 1;
	insert into user_buildings(users_id, building_id, cityID, building_points, entity_id, building_level)
	values(:newRow.userid, 3, city_max_id, 300, build_entity_id,1);
end;


create or replace trigger deleteUserTrigger
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


create or replace trigger deleteCityTrigger
after delete on city
referencing old as oldRow
for each row
declare
 v_city_id int;
begin
  select cityid into v_city_id from user_buildings where cityid = :oldRow.cityid;
  execute immediate 'delete from user_buildings where cityid = '||v_city_id;
end;