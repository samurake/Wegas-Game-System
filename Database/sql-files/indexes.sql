--preluarea tuturor datelor despre un player la logarea acestuia
select * from players p join city c on p.userid=c.users_id join user_buildings u on c.users_id=u.users_id join buildings b
on b.building_id=u.building_id join buildinglevels l on b.building_id=l.building_id
where email='panamanianfox1490.dummy@yahoo.com';

--crearea unui index peste campul cel mai des solicitat la logarile playerilor - email
create index user_email on players(email);
--crearea altor indecsi peste campuri des solicitate la join -users_id din tabela city(userid din players e PK si indexat automat)
--users_id din tabela user_buildings
--building_id din user_buildings si buildinglevels
create index city_users on city(users_id);
create index building_users on user_buildings(users_id);
create index building_id on user_buildings(building_id);
create index building_id_levels on buildinglevels(building_id);

select * from players p join city c on p.userid=c.users_id join user_buildings u on c.users_id=u.users_id join buildings b
on b.building_id=u.building_id join buildinglevels l on b.building_id=l.building_id
where email='angolangoogle213.dummy@yahoo.com';

drop index user_email;
drop index city_users;
drop index building_users;
drop index building_id;
drop index building_id_levels;



select u.cityid, sum(building_points) from city c join user_buildings u on c.cityid=u.cityid
group by u.cityid;

create index city on user_buildings(cityid);
select u.cityid, sum(building_points) from city c join user_buildings u on c.cityid=u.cityid
group by u.cityid;

drop index city;








