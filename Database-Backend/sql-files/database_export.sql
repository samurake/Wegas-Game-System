SET SERVEROUTPUT ON;
CREATE OR REPLACE DIRECTORY EXPORT_DIR AS 'C:\Users\';
GRANT READ ON DIRECTORY EXPORT_DIR TO PUBLIC;

CREATE OR REPLACE PROCEDURE RECREATE_TABLES(tblName IN VARCHAR2, 
 exportFile IN UTL_FILE.FILE_TYPE) IS 
 
 SQL_refCursor INTEGER DEFAULT DBMS_SQL.OPEN_CURSOR; 
 SQL_colValue VARCHAR2(4000); 
 SQL_exec INTEGER; 
 SQL_rawQuery VARCHAR2(1000) DEFAULT 'SELECT * FROM ' || tblName; 
 SQL_nrOfColumns NUMBER := 0;
 SQL_SEP VARCHAR2(1); 
 SQL_tblDescribe DBMS_SQL.DESC_TAB; 
 var_line VARCHAR2(4000) := '';
 var_indx INT :=0;

 BEGIN  
    DBMS_SQL.PARSE(SQL_refCursor, SQL_rawQuery, DBMS_SQL.NATIVE); 
    DBMS_SQL.DESCRIBE_COLUMNS(SQL_refCursor, SQL_nrOfColumns, SQL_tblDescribe); 
 
    FOR indx_line IN 1 .. SQL_nrOfColumns LOOP 
      DBMS_SQL.DEFINE_COLUMN(SQL_refCursor, indx_line, SQL_colValue, 4000); 
      SQL_SEP := ','; 
    END LOOP; 
    UTL_FILE.NEW_LINE(exportFile); 
 
    SQL_exec := DBMS_SQL.EXECUTE(SQL_refCursor); 
 
    WHILE (DBMS_SQL.FETCH_ROWS(SQL_refCursor) > 0) LOOP 
      SQL_SEP := ''; 
      var_indx := var_indx + 1;
      IF var_indx > 200 THEN
        EXIT;
      END IF;
      UTL_FILE.PUT(exportFile, 'INSERT INTO ' || tblName);
      UTL_FILE.NEW_LINE( exportFile ); 
      UTL_FILE.PUT(exportFile, '(' ); 
 
      var_line := '';
    FOR indx_line IN 1 .. SQL_nrOfColumns LOOP 
        DBMS_SQL.COLUMN_VALUE( SQL_refCursor, indx_line, SQL_colValue ); 
        var_line := var_line || SQL_tblDescribe(indx_line).COL_NAME || ', ';
    END LOOP; 
    
    UTL_FILE.PUT(exportFile, SUBSTR(var_line,0,LENGTH(var_line) - 2) || ')' ); 
    UTL_FILE.NEW_LINE(exportFile); 
    UTL_FILE.PUT(exportFile, 'VALUES'); 
    UTL_FILE.NEW_LINE(exportFile); 
    UTL_FILE.PUT(exportFile, '('); 
    
    var_line := '';
    FOR indx_line IN 1 .. SQL_nrOfColumns LOOP 
        DBMS_SQL.COLUMN_VALUE(SQL_refCursor,indx_line,SQL_colValue);
        IF SQL_tblDescribe(indx_line).COL_TYPE = 12 THEN
          var_line := var_line  || 'TO_DATE(''' || REPLACE(SQL_colValue,'''','''''') || ''' ,''DD-MON-YY :HH24:MI:SS'')'  || ', ';
        ELSE 
          var_line := var_line || CHR(39) || REPLACE(SQL_colValue,'''','''''') || CHR(39) || ', ';
        END IF;
    END LOOP;     

    UTL_FILE.PUT(exportFile, SUBSTR(var_line,0,LENGTH(var_line) - 2)||');' ); 
    UTL_FILE.NEW_LINE(exportFile);  
    UTL_FILE.NEW_LINE(exportFile); 
 END LOOP; 
  DBMS_SQL.CLOSE_CURSOR(SQL_refCursor); 
  
 END;
/

DECLARE
	expData UTL_FILE.FILE_TYPE;

BEGIN
	expData := UTL_FILE.FOPEN('EXPORT_DIR','exported_db.sql','W');

	DBMS_METADATA.SET_TRANSFORM_PARAM(DBMS_METADATA.SESSION_TRANSFORM, 'EMIT_SCHEMA', false);      
	DBMS_METADATA.SET_TRANSFORM_PARAM(DBMS_METADATA.SESSION_TRANSFORM,'SEGMENT_ATTRIBUTES',false);
	DBMS_METADATA.SET_TRANSFORM_PARAM(DBMS_METADATA.SESSION_TRANSFORM,'REF_CONSTRAINTS',false);
	DBMS_METADATA.SET_TRANSFORM_PARAM (DBMS_METADATA.SESSION_TRANSFORM, 'SQLTERMINATOR', true);


-- Exporting database
FOR position IN
  (SELECT * FROM ALL_OBJECTS WHERE OWNER = 'STUDENT') LOOP
    BEGIN
    
      UTL_FILE.PUT_LINE(expData,dbms_metadata.get_ddl('TABLE',position.OBJECT_NAME,'STUDENT'));
      IF position.OBJECT_TYPE = 'TABLE' THEN
        RECREATE_TABLES(position.OBJECT_NAME, expData);
      END IF;
      EXCEPTION WHEN OTHERS THEN NULL;
    END;
  END LOOP;

  FOR position IN
  (SELECT * FROM ALL_OBJECTS WHERE OWNER = 'STUDENT') LOOP
    BEGIN
     IF position.OBJECT_TYPE != 'LOB' AND  position.OBJECT_TYPE != 'TABLE'  AND  position.OBJECT_TYPE != 'INDEX' THEN
        IF position.OBJECT_NAME != 'RECREATE_TABLES' THEN
            UTL_FILE.PUT_LINE(expData,dbms_metadata.get_ddl(position.OBJECT_TYPE,position.OBJECT_NAME,'STUDENT'));
        END IF;    
    END IF;  
        EXCEPTION WHEN OTHERS THEN NULL;
    END;
  END LOOP;

  UTL_FILE.FCLOSE(expData);
END;
