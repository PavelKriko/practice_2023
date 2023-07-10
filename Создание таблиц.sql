-- music_project.artists definition

-- Drop table

-- DROP TABLE music_project.artists;

CREATE TABLE music_project.artists (
	artistname varchar(255) NULL,
	artistid serial4 NOT NULL,
	report_date date NULL,
	CONSTRAINT artists_pk PRIMARY KEY (artistid)
);

-- music_project.cities definition

-- Drop table

-- DROP TABLE music_project.cities;

CREATE TABLE music_project.cities (
	cityname varchar(255) NULL,
	cityid serial4 NOT NULL,
	report_date date NULL,
	CONSTRAINT cities_pk PRIMARY KEY (cityid)
);

-- music_project.days definition

-- Drop table

-- DROP TABLE music_project.days;

CREATE TABLE music_project.days (
	dayid bpchar(1) NOT NULL,
	dayname bpchar(11) NULL,
	CONSTRAINT days_pk PRIMARY KEY (dayid)
);

-- music_project.genres definition

-- Drop table

-- DROP TABLE music_project.genres;

CREATE TABLE music_project.genres (
	genrename bpchar(50) NULL,
	report_date date NULL,
	genreid serial4 NOT NULL,
	CONSTRAINT genres_pk PRIMARY KEY (genreid)
);

-- music_project.listenings definition

-- Drop table

-- DROP TABLE music_project.listenings;

CREATE TABLE music_project.listenings (
	id bigserial NOT NULL,
	userid bpchar(10) NULL,
	trackid int8 NULL,
	dayid bpchar(1) NULL,
	"time" float8 NULL,
	reportdate date NULL,
	cityid int4 NULL,
	CONSTRAINT listenings_pkey PRIMARY KEY (id)
);


-- music_project.listenings foreign keys

ALTER TABLE music_project.listenings ADD CONSTRAINT listenings_fk_cityid FOREIGN KEY (cityid) REFERENCES music_project.cities(cityid);
ALTER TABLE music_project.listenings ADD CONSTRAINT listenings_fk_daysid FOREIGN KEY (dayid) REFERENCES music_project.days(dayid);
ALTER TABLE music_project.listenings ADD CONSTRAINT listenings_fk_trackid FOREIGN KEY (trackid) REFERENCES music_project.tracks(trackid);
ALTER TABLE music_project.listenings ADD CONSTRAINT listenings_userid_fkey FOREIGN KEY (userid) REFERENCES music_project.users(userid);

-- music_project.perfomances definition

-- Drop table

-- DROP TABLE music_project.perfomances;

CREATE TABLE music_project.perfomances (
	trackid int8 NOT NULL,
	artistid int4 NOT NULL,
	report_date date NULL,
	CONSTRAINT perfomances_pk PRIMARY KEY (trackid, artistid)
);


-- music_project.perfomances foreign keys

ALTER TABLE music_project.perfomances ADD CONSTRAINT perfomances_fk FOREIGN KEY (trackid) REFERENCES music_project.tracks(trackid);
ALTER TABLE music_project.perfomances ADD CONSTRAINT perfomances_fk_artist FOREIGN KEY (artistid) REFERENCES music_project.artists(artistid);

-- music_project."source" definition

-- Drop table

-- DROP TABLE music_project."source";

CREATE TABLE music_project."source" (
	column1 int4 NULL,
	"userID" varchar(50) NULL,
	track varchar(255) NULL,
	artist varchar(255) NULL,
	genre varchar(50) NULL,
	"City" varchar(50) NULL,
	"time" varchar(50) NULL,
	report_date varchar(50) NULL,
	weekday varchar(50) NULL
);

-- music_project.tracks definition

-- Drop table

-- DROP TABLE music_project.tracks;

CREATE TABLE music_project.tracks (
	trackname varchar(255) NULL,
	genreid int4 NULL,
	trackid bigserial NOT NULL,
	report_date date NULL,
	CONSTRAINT tracks_pk PRIMARY KEY (trackid)
);


-- music_project.tracks foreign keys

ALTER TABLE music_project.tracks ADD CONSTRAINT tracks_fk FOREIGN KEY (genreid) REFERENCES music_project.genres(genreid);

-- music_project.users definition

-- Drop table

-- DROP TABLE music_project.users;

CREATE TABLE music_project.users (
	userid bpchar(10) NOT NULL,
	report_date date NULL,
	CONSTRAINT users_pkey PRIMARY KEY (userid)
);
