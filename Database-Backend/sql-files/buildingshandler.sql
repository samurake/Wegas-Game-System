CREATE OR REPLACE PACKAGE buildingshandler
  AS
      function newBuildingC(p_id_user int) return NUMBER;
      function getBuildingTotalPointsR(p_entity_id number) return NUMBER;
      procedure calculateBuildingPointsRU(p_entity_id number);
      procedure deleteBuildingD(p_entity_id number);
      function getUsersPoints(ID_user NUMBER) RETURN NUMBER;

  end buildingshandler;


CREATE OR REPLACE PACKAGE body buildingshandler
  AS
      function getBuildingTotalPointsR(p_entity_id number) return NUMBER
      AS
        v_result NUMBER(10) := 0;
        BEGIN
            SELECT BUILDING_POINTS INTO V_RESULT from USER_BUILDINGS where ENTITY_ID=p_entity_id;
            return v_result;
                EXCEPTION
        WHEN no_data_found THEN
          v_result := 0;
          return v_result;
          end getBuildingTotalPointsR;

      procedure calculateBuildingPointsRU(p_entity_id number)
      IS
        v_building_id NUMBER(10) := 0;
        v_curr_level NUMBER(10) := 0;
        v_looper NUMBER(10) := 0;
        v_result NUMBER(10) := 0;
        BEGIN
          SELECT BUILDING_ID into v_building_id from user_buildings where entity_id = p_entity_id;
          SELECT max(building_level) into v_curr_level from user_buildings where entity_id = p_entity_id;
          for i in 1..v_curr_level LOOP
            select pointsvalue into v_looper from buildinglevels where levelid = i and building_id = v_building_id;
            v_result := v_result + v_looper;
          END LOOP;
          UPDATE user_buildings SET BUILDING_POINTS = v_result where ENTITY_ID = p_entity_id;
          end calculateBuildingPointsRU;

      FUNCTION getUsersPoints ( ID_user NUMBER )
      RETURN NUMBER AS
      v_points NUMBER(10) := 0;
      v_dummy NUMBER(10) := 0;
      CURSOR user_buildingsCursor IS
        SELECT BUILDING_LEVEL, BUILDING_POINTS FROM USER_BUILDINGS WHERE USERS_ID = ID_user;
      BEGIN
        SELECT BUILDING_POINTS into v_dummy FROM USER_BUILDINGS WHERE USERS_ID = ID_USER and rownum = 1;
       FOR i_line in user_buildingsCursor LOOP
         v_points := v_points + i_line.BUILDING_LEVEL * i_line.BUILDING_POINTS;
       END LOOP;
        RETURN v_points;
      END;

      procedure deleteBuildingD(p_entity_id number)
      IS
        v_result NUMBER(10) := 0;
        BEGIN
          select entity_id into v_result from user_buildings where entity_id = p_entity_id;
          delete from user_buildings where entity_id = p_entity_id;
          end deleteBuildingD;


      function newBuildingC(p_id_user int)
      return NUMBER as
        v_city_id NUMBER(10);
        v_entity_id NUMBER(10) := 0;
        v_check_null_entity NUMBER(10) := 0;
      begin
        select count(*) into v_check_null_entity from user_buildings;
        if v_check_null_entity = 0 THEN
          v_entity_id := 0;
        ELSE
          select max(entity_id) into v_entity_id from user_buildings;
        END IF;
        select cityid into v_city_id from players p join city c on p.userid=c.users_id where userid=p_id_user;
        insert into user_buildings(users_id, building_id, cityid, building_points, entity_id, building_level) values(p_id_user, 1, v_city_id, dbms_random.value(1,200),v_entity_id + 1, 1);
        insert into user_buildings(users_id, building_id, cityid, building_points, entity_id, building_level) values(p_id_user, 2, v_city_id, dbms_random.value(1,200),v_entity_id + 2, 1);
        insert into user_buildings(users_id, building_id, cityid, building_points, entity_id, building_level) values(p_id_user, 3, v_city_id, dbms_random.value(1,200),v_entity_id + 3, 1);
        return 1;
        EXCEPTION
          WHEN NO_DATA_FOUND THEN
              null;
      end newBuildingC;
  END buildingshandler;