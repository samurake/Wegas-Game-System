DROP TABLE PLAYERS cascade constraints;
/
CREATE TABLE PLAYERS
(
	userid NUMBER(10,0),
	username VARCHAR2(30) not null unique,
	email VARCHAR2(50) not null,
	passwd VARCHAR2(20) not null,
	CONSTRAINT pk_user PRIMARY KEY(userid)
);
/
DROP TABLE CITY cascade constraints;
/
CREATE TABLE CITY
(
	users_id NUMBER(10,0),
	cityID NUMBER(10,0),
	cityPosX NUMBER(10,0),
	cityPosY NUMBER(10,0),
	cityPoints NUMBER(10,0),
	StorageWood NUMBER(10,0),
	StorageStone NUMBER(10,0),
	StorageFood NUMBER(10,0),
	StorageMaxCapacity NUMBER(10,0),
	CONSTRAINT fk_user_city FOREIGN KEY (users_id) REFERENCES PLAYERS(userid),
	CONSTRAINT pk_city PRIMARY KEY(cityID)
);
/
DROP TABLE USER_BUILDINGS cascade constraints;
/
CREATE TABLE USER_BUILDINGS
(
users_id NUMBER(10,0),
building_id NUMBER(10,0),
cityID NUMBER(10,0),
building_points NUMBER(10,0),
CONSTRAINT fk_user_user_buildings FOREIGN KEY (users_id) REFERENCES PLAYERS(userid),
CONSTRAINT fk_city_user_buildings FOREIGN KEY (cityID) REFERENCES CITY(cityID),
CONSTRAINT fk_buildings_user_buildings FOREIGN KEY (building_id) REFERENCES BUILDINGS(building_id)
);
/
DROP TABLE BUILDINGS cascade constraints;
/
CREATE TABLE BUILDINGS
(
building_id NUMBER(10,0),
building_name VARCHAR2(20),
building_level NUMBER(2,0),
costInWood NUMBER(10,0),
costInFood NUMBER(10,0),
costInStone NUMBER(10,0),
bFunction NUMBER(10,0) not null unique,
CONSTRAINT pk_building_id_building PRIMARY KEY(building_id)
);
/
DROP TABLE BUILDING_FUNCTIONS cascade constraints;
/
CREATE TABLE BUILDING_FUNCTIONS
(
function_name VARCHAR2(10),
functionID NUMBER(10,0) not null unique,
CONSTRAINT fk_fct_id_buildings FOREIGN KEY (functionID) REFERENCES BUILDINGS(bFunction)
);
/
DROP TABLE BUILDINGLEVELS cascade constraints;
/
CREATE TABLE BUILDINGLEVELS
(
building_id NUMBER(10,0),
levelID NUMBER(10,0),
levelCostWood NUMBER(10,0),
levelCostStone NUMBER(10,0),
levelCostFood NUMBER(10,0),
buildingFunctionID NUMBER(10,0),
CONSTRAINT fk_build_id_buildinlevel FOREIGN KEY (building_id) REFERENCES BUILDINGS(building_id),
CONSTRAINT fk_functional_id_buildings FOREIGN KEY (buildingFunctionID) REFERENCES BUILDING_FUNCTIONS(functionID)
);
/
CREATE OR REPLACE PROCEDURE implanted_city (usr_id IN INTEGER) IS
	numb_city NUMBER(1,0);
	city_max_id NUMBER(10,0);
BEGIN
	numb_city := dbms_random.value(1,3);
	BEGIN
		select cityID into city_max_id from CITY where cityID =(select max(cityID) from CITY);
		EXCEPTION
			WHEN no_data_found 
			THEN
			city_max_id := 0;
	END;
	FOR i IN 1..numb_city LOOP
		city_max_id := city_max_id + 1;
		INSERT INTO CITY(users_id, cityID, cityPosX, cityPosY, cityPoints, StorageWood, StorageStone, StorageFood, StorageMaxCapacity) 
		VALUES(usr_id, city_max_id, dbms_random.value(0, 1000), dbms_random.value(0, 1000), dbms_random.value(0, 3000), dbms_random.value(0, 1000), dbms_random.value(0, 1000), dbms_random.value(0, 1000), dbms_random.value(1000, 50000));
	END LOOP;  
END;
/
CREATE OR REPLACE PROCEDURE implanted_users (numb_users IN INTEGER) IS
	nm_usr varchar2(25);
	add_usr NUMBER(9,0);
	email_usr varchar2(40);
	pass_usr VARCHAR2(20);
	rand_numb NUMBER(2,0);
	usr_procedure_id NUMBER(10,0);
BEGIN
	BEGIN
		select userid into usr_procedure_id from PLAYERS where userid =(select max(userid) from PLAYERS);
		EXCEPTION
			WHEN no_data_found 
			THEN
			usr_procedure_id := 0;
	END;
	FOR i IN 1..numb_users LOOP
		usr_procedure_id := usr_procedure_id + 1;
		rand_numb := DBMS_RANDOM.VALUE(1,30);
		CASE rand_numb 
			WHEN 1 THEN nm_usr := 'panamanianfox';
			WHEN 2 THEN nm_usr := 'estoniangillette'; 
			WHEN 3 THEN nm_usr := 'swedishadidas';
			WHEN 4 THEN nm_usr := 'israelinissan';
			WHEN 5 THEN nm_usr := 'congoleseapple';
			WHEN 6 THEN nm_usr := 'romaniancanon';
			WHEN 7 THEN nm_usr := 'belgiancolgate';
			WHEN 8 THEN nm_usr := 'angolangoogle';
			WHEN 9 THEN nm_usr := 'pakistanivisa';
			WHEN 10 THEN nm_usr := 'algerianvolkswagon';
			WHEN 11 THEN nm_usr := 'croatianrolex';
			WHEN 12 THEN nm_usr := 'koreantoyota';
			WHEN 13 THEN nm_usr := 'finnishibm';
			WHEN 14 THEN nm_usr := 'lithuanianlancome';
			WHEN 15 THEN nm_usr := 'liberianmercedes';
			WHEN 16 THEN nm_usr := 'eritreanpepsi';
			WHEN 17 THEN nm_usr := 'yemenichanel';
			WHEN 18 THEN nm_usr := 'macedonianintel';
			WHEN 19 THEN nm_usr := 'georgianheineken';
			WHEN 20 THEN nm_usr := 'mongolianshell';
			WHEN 21 THEN nm_usr := 'namibiangucci';
			WHEN 22 THEN nm_usr := 'costaricanhyundai';
			WHEN 23 THEN nm_usr := 'albanianbudweiser';
			WHEN 24 THEN nm_usr := 'tunisianmicrosoft';
			WHEN 25 THEN nm_usr := 'vietnamesecisco';
			WHEN 26 THEN nm_usr := 'lithuanianfacebook';
			WHEN 27 THEN nm_usr := 'egyptiansantander';
			WHEN 30 THEN nm_usr := 'japanesepampers';
			WHEN 28 THEN nm_usr := 'slovenianheineken';
			WHEN 29 THEN nm_usr := 'canadianmercedes';
			WHEN 30 THEN nm_usr := 'BORmasina';
	    END CASE;
	    add_usr := DBMS_RANDOM.VALUE(1,3000);
		nm_usr := nm_usr || add_usr;
		email_usr := nm_usr || '.dummy@yahoo.com';
		pass_usr := dbms_random.string('A', 18);
		BEGIN
		INSERT INTO PLAYERS(userid, username, email, passwd) VALUES(usr_procedure_id, nm_usr, email_usr, pass_usr);
		implanted_city(usr_procedure_id);
		EXCEPTION
			WHEN OTHERS
			THEN
			implanted_users(1);
		END;
	END LOOP;  
END;
/
begin
implanted_users(10000);
end;
/