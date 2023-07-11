create or replace function delete_date(date_from date)
returns void as $$
	delete from music_project.users
	where report_date >= date_from;

	delete from music_project.cities
	where report_date >= date_from;

	delete from music_project.genres
	where report_date >= date_from;

	delete from music_project.tracks
	where report_date >= date_from;

	delete from music_project.artists
	where report_date >= date_from;

	delete from music_project.perfomances 
	where report_date >= date_from;

	delete from music_project.listenings 
	where reportdate >= date_from;
$$ language sql;

---Проверка работы---
select delete_date('2023-05-01')

select * from listenings l 
order by reportdate desc


--Ошибка возникает при подгрузке в perfomance, могут поподаться повторяющиеся парные pk, на всякий добавил обработку ex для всех таблиц
create or replace function reload_data(date_start date, date_end date)
returns void as $$
begin
    begin
        select delete_date(date_start);
    exception when others then
        null; 
    end;

    begin
        select music_project.load_users(date_start, date_end);
    exception when others then
        null; 
    end;

    begin
        select music_project.load_genres(date_start, date_end);
    exception when others then
        null; 
    end;

    begin
        select music_project.load_artists(date_start, date_end);
    exception when others then
        null; 
    end;

    begin
        select music_project.load_tracks(date_start, date_end);
    exception when others then
        null; 
    end;

    begin
        select music_project.load_perfomances(date_start, date_end);
    exception when others then
        null; 
    end;

    begin
        select music_project.load_cities(date_start, date_end);
    exception when others then
        null; 
    end;

    begin
        select music_project.load_listenings(date_start, date_end);
    exception when others then
        null;
    end;
end;
$$ language plpgsql;

select reload_data('2023-03-01', '2023-04-01')

select * from music_project.listenings l 


