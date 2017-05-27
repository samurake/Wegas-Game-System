DROP TABLE PLAYERS cascade constraints;


CREATE TABLE PLAYERS
(
	userid NUMBER(10,0),
	username VARCHAR2(30) not null unique,
	email VARCHAR2(50) not null,
	passwd VARCHAR2(20) not null,
	CONSTRAINT pk_user PRIMARY KEY(userid)
);


DROP TABLE CITY cascade constraints;


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


DROP TABLE USER_BUILDINGS cascade constraints;


CREATE TABLE USER_BUILDINGS
(
users_id NUMBER(10,0),
building_id NUMBER(10,0),
cityID NUMBER(10,0),
building_points NUMBER(10,0),
entity_id NUMBER(10),
building_level NUMBER(10),
CONSTRAINT fk_user_user_buildings FOREIGN KEY (users_id) REFERENCES PLAYERS(userid),
CONSTRAINT fk_city_user_buildings FOREIGN KEY (cityID) REFERENCES CITY(cityID),
CONSTRAINT fk_buildings_user_buildings FOREIGN KEY (building_id) REFERENCES BUILDINGS(building_id)
);


DROP TABLE BUILDINGS cascade constraints;


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


DROP TABLE BUILDING_FUNCTIONS cascade constraints;


CREATE TABLE BUILDING_FUNCTIONS
(
function_name VARCHAR2(10),
functionID NUMBER(10,0) not null unique,
CONSTRAINT fk_fct_id_buildings FOREIGN KEY (functionID) REFERENCES BUILDINGS(bFunction)
);


DROP TABLE BUILDINGLEVELS cascade constraints;


CREATE TABLE BUILDINGLEVELS
(
building_id NUMBER(10,0),
levelID NUMBER(10,0),
levelCostWood NUMBER(10,0),
levelCostStone NUMBER(10,0),
levelCostFood NUMBER(10,0),
buildingFunctionID NUMBER(10,0),
pointsvalue NUMBER(10),
CONSTRAINT fk_build_id_buildinlevel FOREIGN KEY (building_id) REFERENCES BUILDINGS(building_id),
CONSTRAINT fk_functional_id_buildings FOREIGN KEY (buildingFunctionID) REFERENCES BUILDING_FUNCTIONS(functionID)
);