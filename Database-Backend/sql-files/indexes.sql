set serveroutput on;

--preluarea tuturor datelor despre un player la logarea acestuia
select * from players p join city c on p.userid=c.users_id join user_buildings u on c.users_id=u.users_id join buildings b
on b.building_id=u.building_id join buildinglevels l on b.building_id=l.building_id
where email='angolangoogle213.dummy@yahoo.com';

--crearea unui index peste campul cel mai des solicitat la logarile playerilor - email
create index idx_user_email on players(email);
--crearea altor indecsi peste campuri des solicitate la join -users_id din tabela city(userid din players e PK si indexat automat)
--users_id din tabela user_buildings
--building_id din user_buildings si buildinglevels
create index idx_city_users on city(users_id);
create index idx_building_users on user_buildings(users_id);
create index idx_building_id on user_buildings(building_id);
create index idx_building_id_levels on buildinglevels(building_id);

select * from players p join city c on p.userid=c.users_id join user_buildings u on c.users_id=u.users_id join buildings b
on b.building_id=u.building_id join buildinglevels l on b.building_id=l.building_id
where email='angolangoogle213.dummy@yahoo.com';

drop index idx_user_email;
drop index idx_city_users;
drop index idx_building_users;
drop index idx_building_id;
drop index idx_building_id_levels;



select u.cityid, sum(building_points) from city c join user_buildings u on c.cityid=u.cityid
group by u.cityid;

create index idx_city on user_buildings(cityid);
create index idx_points on user_buildings(building_points);
select u.cityid, sum(building_points) from city c join user_buildings u on c.cityid=u.cityid
group by u.cityid;

drop index idx_city;
drop index idx_points;








