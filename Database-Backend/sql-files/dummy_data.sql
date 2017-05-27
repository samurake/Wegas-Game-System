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
		EXCEPTION
			WHEN OTHERS
			THEN
			implanted_users(1);
		END;
	END LOOP;
END;

begin
implanted_users(10000);
end;
