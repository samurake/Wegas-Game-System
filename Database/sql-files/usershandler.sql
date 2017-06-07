CREATE or replace PACKAGE usershandler
AS
    function isUserRegisteredR(p_numeuser varchar2) return boolean;
    function isUserRegisteredR(p_numeuser varchar2, p_email varchar2) return boolean;
    function isUserValidR(p_numeuser varchar2, p_passwd varchar2) return boolean;
    function registerC(p_numeuser varchar2, p_email varchar2, p_passwd varchar2) return NUMBER;
    function loginR(p_numeuser varchar2, p_passwd varchar2) return NUMBER;
    function deletePlayerD(p_player_id number) return boolean;
end usershandler;


create or replace package body usershandler AS

  function isUserRegisteredR(p_numeuser varchar2) return boolean AS
    v_test_id int := 0;
    begin
      select userid into v_test_id from players where username=p_numeuser;
      if(v_test_id > 0)
      then return true;
        ELSE return false;
        end if;
      EXCEPTION
        WHEN no_data_found THEN
      return false;
    end isUserRegisteredR;

  function isUserRegisteredR(p_numeuser varchar2, p_email varchar2) return boolean AS
    v_test_id int := 0;
    begin
      select userid into v_test_id from players where username=p_numeuser and email=p_email;
      if(v_test_id > 0)
      then return true;
        ELSE return false;
        end if;
      EXCEPTION
        WHEN no_data_found THEN
      return false;
    end isUserRegisteredR;

  function isUserValidR(p_numeuser varchar2, p_passwd varchar2) return boolean AS
    v_test_id int := 0;
    BEGIN
      select userid into v_test_id from players where username=p_numeuser and passwd=p_passwd;
      if(v_test_id > 0)
      then return true;
        ELSE return false;
        end if;
      EXCEPTION
        WHEN no_data_found THEN
      return false;
    END isUserValidR;

  function registerC(p_numeuser varchar2, p_email varchar2, p_passwd varchar2) return NUMBER as
      v_user_id int := 0;
      v_city_id int := 0;
      v_max_id int := 0;
      v_city_max_id int := 0;
      v_check_user_null int := 0;
      v_check_city_null int := 0;
  begin
      if isUserRegisteredR(p_numeuser,p_Email) = true then
        return 0;
      else

        select count(*) into v_check_user_null from players;
        select count(*) into v_check_city_null from city;

        if v_check_user_null = 0 then
          v_user_id := 1;
        ELSE
          select max(userid) into v_max_id from players;
          v_user_id := v_max_id + 1;
        end if;

        if v_check_city_null = 0 THEN
          v_city_id := 1;
        ELSE
          select max(cityid) into v_city_max_id from city;
          v_city_id := v_city_max_id + 1;
        END IF;

        insert into players(userid, username, email, passwd) values(trim(v_user_id), trim(p_numeuser), trim(p_email), trim(p_passwd));
        insert into city(users_id, cityid, cityposx, cityposy, citypoints, storagewood, storagestone, storagefood, storagemaxcapacity) values(v_user_id, v_city_id, dbms_random.value(0,1000), dbms_random.value(0,1000), 0, 50, 50, 50, 200);
        return 1;
    end if;
      EXCEPTION
        WHEN no_data_found THEN
      return 0;
        WHEN exceptionhandler.insert_null_into_notnull THEN
          return -1;
        RAISE;
  end registerC;

  function loginR(p_numeuser varchar2, p_passwd varchar2) return NUMBER AS
    v_returnID NUMBER;
    BEGIN
      if isUserRegisteredR(trim(p_numeuser)) = true THEN
        if isUserValidR(trim(p_numeuser),trim(p_passwd)) = true THEN
          SELECT userid into v_returnID from players where username = trim(p_numeuser);
        ELSE
          v_returnID := -1;
          end if;
      ELSE
        v_returnID := 0;
        end if;
      return v_returnID;
            EXCEPTION
        WHEN no_data_found THEN
          return 0;
    END loginR;

  function deletePlayerD(p_player_id number) return boolean
  AS
    BEGIN
        delete from Players where userid = p_player_id;
	      delete from CITY where users_id = p_player_id;
	      delete from USER_BUILDINGS where users_id = p_player_id;
        RETURN TRUE;
            EXCEPTION
        WHEN no_data_found THEN
          return false;
      end deletePlayerD;

end usershandler;