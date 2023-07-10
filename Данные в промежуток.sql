CREATE OR REPLACE FUNCTION quantity_data()
RETURNS TABLE (
    "userID" VARCHAR,
    "Track" VARCHAR,
    "artist" VARCHAR,
    "genre" VARCHAR,
    "City" VARCHAR,
    "time" FLOAT,
    "Report_date" DATE,
    "Weekday" VARCHAR
)
AS $$
BEGIN
    RETURN QUERY
    WITH full_records AS (
        SELECT
            source."userID",
            source."track",
            source."artist",
            source."genre",
            source."City",
            CAST(replace (source."time",',','.') AS FLOAT) AS "time",
            CAST(source."report_date" AS DATE) AS "Report_date",
            source."weekday"
        FROM
            music_project.source
        WHERE
            source."userID" IS NOT NULL AND
            source."userID" <> '' AND
            LENGTH(source."userID") <= 10 and
            source.track <> '' and source.artist <> '' and
            source."time" IS NOT NULL AND
            source."report_date" IS NOT null
    )
    SELECT *
    FROM full_records;
END;
$$ LANGUAGE plpgsql;

select * from quantity_data()

create or replace function  get_data_between_dates(start_date DATE, end_date DATE) 
returns TABLE (
    "userID" VARCHAR,
    "Track" VARCHAR,
    "artist" VARCHAR,
    "genre" VARCHAR,
    "City" VARCHAR,
    "time" FLOAT,
    "Report_date" DATE,
    "Weekday" VARCHAR
) as $$
    select * 
    from quantity_data() as t
    where t."Report_date" between start_date and end_date;
$$ language sql;


SELECT * FROM get_data_between_dates('2023-01-01', '2023-06-30');
