INSERT INTO buildings(BUILDING_id,BUILDING_NAME,BUILDING_LEVEL,costinwood,COSTINFOOD,COSTINSTONE,BFUNCTION)
    VALUES(1,'Castle',1,dbms_random.value(10000,1532145),dbms_random.value(10000,1532145),dbms_random.value(10000,1532145),1);

INSERT INTO buildings(BUILDING_id,BUILDING_NAME,BUILDING_LEVEL,costinwood,COSTINFOOD,COSTINSTONE,BFUNCTION)
    VALUES(2,'Storage',1,dbms_random.value(10000,1532145),dbms_random.value(10000,1532145),dbms_random.value(10000,1532145),2);

INSERT INTO buildings(BUILDING_id,BUILDING_NAME,BUILDING_LEVEL,costinwood,COSTINFOOD,COSTINSTONE,BFUNCTION)
    VALUES(3,'Barrack',1,dbms_random.value(10000,1532145),dbms_random.value(10000,1532145),dbms_random.value(10000,1532145),3);


INSERT INTO BUILDING_FUNCTIONS(FUNCTION_NAME, FUNCTIONID)
    VALUES('CastleF',1);

INSERT INTO BUILDING_FUNCTIONS(FUNCTION_NAME, FUNCTIONID)
    VALUES('StorageF',2);

INSERT INTO BUILDING_FUNCTIONS(FUNCTION_NAME, FUNCTIONID)
    VALUES('BarrackF',3);


INSERT INTO BUILDINGLEVELS(BUILDING_ID, LEVELID, LEVELCOSTWOOD, LEVELCOSTSTONE, LEVELCOSTFOOD, BUILDINGFUNCTIONID,POINTSVALUE)
    VALUES(1,1,dbms_random.value(1000,14543),dbms_random.value(1000,14543),dbms_random.value(1000,14543),1,100);

INSERT INTO BUILDINGLEVELS(BUILDING_ID, LEVELID, LEVELCOSTWOOD, LEVELCOSTSTONE, LEVELCOSTFOOD, BUILDINGFUNCTIONID,POINTSVALUE)
    VALUES(1,2,dbms_random.value(1000,14543),dbms_random.value(1000,14543),dbms_random.value(1000,14543),1,200);

INSERT INTO BUILDINGLEVELS(BUILDING_ID, LEVELID, LEVELCOSTWOOD, LEVELCOSTSTONE, LEVELCOSTFOOD, BUILDINGFUNCTIONID,POINTSVALUE)
    VALUES(1,3,dbms_random.value(1000,14543),dbms_random.value(1000,14543),dbms_random.value(1000,14543),1,300);

INSERT INTO BUILDINGLEVELS(BUILDING_ID, LEVELID, LEVELCOSTWOOD, LEVELCOSTSTONE, LEVELCOSTFOOD, BUILDINGFUNCTIONID,POINTSVALUE)
    VALUES(2,1,dbms_random.value(1000,14543),dbms_random.value(1000,14543),dbms_random.value(1000,14543),2,100);

INSERT INTO BUILDINGLEVELS(BUILDING_ID, LEVELID, LEVELCOSTWOOD, LEVELCOSTSTONE, LEVELCOSTFOOD, BUILDINGFUNCTIONID,POINTSVALUE)
    VALUES(2,2,dbms_random.value(1000,14543),dbms_random.value(1000,14543),dbms_random.value(1000,14543),2,200);

INSERT INTO BUILDINGLEVELS(BUILDING_ID, LEVELID, LEVELCOSTWOOD, LEVELCOSTSTONE, LEVELCOSTFOOD, BUILDINGFUNCTIONID,POINTSVALUE)
    VALUES(2,3,dbms_random.value(1000,14543),dbms_random.value(1000,14543),dbms_random.value(1000,14543),2,300);

INSERT INTO BUILDINGLEVELS(BUILDING_ID, LEVELID, LEVELCOSTWOOD, LEVELCOSTSTONE, LEVELCOSTFOOD, BUILDINGFUNCTIONID,POINTSVALUE)
    VALUES(3,1,dbms_random.value(1800,14543),dbms_random.value(1000,14543),dbms_random.value(1000,14543),3,100);

INSERT INTO BUILDINGLEVELS(BUILDING_ID, LEVELID, LEVELCOSTWOOD, LEVELCOSTSTONE, LEVELCOSTFOOD, BUILDINGFUNCTIONID,POINTSVALUE)
    VALUES(3,2,dbms_random.value(1000,14543),dbms_random.value(1000,14543),dbms_random.value(1000,14543),3,200);

INSERT INTO BUILDINGLEVELS(BUILDING_ID, LEVELID, LEVELCOSTWOOD, LEVELCOSTSTONE, LEVELCOSTFOOD, BUILDINGFUNCTIONID,POINTSVALUE)
    VALUES(3,3,dbms_random.value(1000,14543),dbms_random.value(1000,14543),dbms_random.value(1000,14543),3,300);