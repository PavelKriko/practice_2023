create or replace function music_project.load_users(start_date date, end_date date)
returns void as $$
	with tmp as (select * from music_project.get_data_between_dates(start_date, end_date))
	
	
	insert into music_project.users (userID, Report_date)
    select distinct "userID", "Report_date"
    from tmp
    order by "Report_date" asc
    ON CONFLICT DO nothing; 
$$ language sql;

---Проверка работы---
delete from music_project.users
select music_project.load_users('2023-01-01', '2023-05-01')


create or replace function music_project.load_genres(start_date date, end_date date)
returns void as $$
	insert into music_project.genres(genrename,report_date)
	select distinct on (tmp."genre") tmp."genre", tmp."Report_date"
	from (select "genre", "Report_date" from music_project.get_data_between_dates(start_date, end_date) order by "Report_date") as tmp
	order by tmp."genre", tmp."Report_date"
$$ language sql;

---Проверка работы---
delete from music_project.genres;
select music_project.load_genres('2023-01-01', '2023-05-01')

create or replace function music_project.load_artists(start_date date, end_date date)
returns void as $$
	insert into music_project.artists(artistname, report_date)
	select distinct on (tmp."artist") tmp."artist", tmp."Report_date"
	from (select "artist", "Report_date" from music_project.get_data_between_dates(start_date, end_date) order by "Report_date") as tmp
	order by tmp."artist", tmp."Report_date"
$$ language sql;

---Проверка работы---
delete from music_project.artists;
select music_project.load_artists('2023-01-01', '2023-05-01');

create or replace function music_project.load_tracks(start_date date, end_date date)
returns void as $$
	insert into music_project.tracks(trackname,genreid, report_date)
	select distinct on (tmp."Track") tmp."Track", music_project.genres.genreid, tmp."Report_date"
	from (select "Track", "Report_date", "genre" from music_project.get_data_between_dates(start_date, end_date) order by "Report_date") as tmp
	inner join music_project.genres on music_project.genres.genrename = tmp."genre"
	order by tmp."Track", tmp."Report_date"
$$ language sql;

---Проверка работы---
delete from music_project.tracks ;
select music_project.load_tracks('2023-01-01', '2023-05-01');


create or replace function music_project.load_perfomances(start_date date, end_date date)
returns void as $$
	insert into music_project.perfomances(trackid, artistid, report_date)
	select distinct on (music_project.tracks.trackid, music_project.artists.artistid) music_project.tracks.trackid, music_project.artists.artistid, tmp."Report_date"
	from (select "Track", "Report_date", "artist" from music_project.get_data_between_dates(start_date, end_date) order by "Report_date") as tmp
	inner join music_project.tracks on music_project.tracks.trackname = tmp."Track"
	inner join music_project.artists on music_project.artists.artistname = tmp."artist"
	order by music_project.tracks.trackid, music_project.artists.artistid
$$ language sql;

---Проверка работы---
delete from music_project.perfomances;
select music_project.load_perfomances('2023-01-01', '2023-05-01');

select music_project.perfomances.trackid  from music_project.perfomances
group by music_project.perfomances.trackid 
having count(*) > 1 

create or replace function music_project.load_cities(start_date date, end_date date)
returns void as $$
	insert into music_project.cities(cityname, report_date)
	select distinct on (tmp."City") tmp."City", tmp."Report_date"
	from (select "City", "Report_date" from music_project.get_data_between_dates(start_date, end_date) order by "Report_date") as tmp
$$ language sql;

---Проверка работы---
delete from music_project.cities;
select music_project.load_cities('2023-01-01', '2023-05-01');

select * from music_project.cities c 

create or replace function music_project.load_listenings(start_date date, end_date date)
returns void as $$
	insert into music_project.listenings(userid,trackid,dayid,"time",reportdate ,cityid)
	select tmp."userID", music_project.tracks.trackid, music_project.days.dayid, tmp."time",tmp."Report_date", music_project.cities.cityid
	from (select * from music_project.get_data_between_dates(start_date, end_date)) as tmp
	inner join music_project.tracks on music_project.tracks.trackname = tmp."Track"
	inner join music_project.days on music_project.days.dayname = tmp."Weekday"
	inner join music_project.cities on music_project.cities.cityname = tmp."City"
$$ language sql;

---Проверка работы---
delete from music_project.listenings;
select music_project.load_listenings('2023-01-01', '2023-05-01');

select count(*) from music_project.listenings

select count(*) from music_project.get_data_between_dates('2023-01-01', '2023-05-01')
