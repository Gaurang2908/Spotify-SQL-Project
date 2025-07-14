-- Advanced SQL Project using Spotify dataset 

DROP TABLE IF EXISTS spotify;
CREATE TABLE spotify (
    artist VARCHAR(255),
    track VARCHAR(255),
    album VARCHAR(255),
    album_type VARCHAR(50),
    danceability FLOAT,
    energy FLOAT,
    loudness FLOAT,
    speechiness FLOAT,
    acousticness FLOAT,
    instrumentalness FLOAT,
    liveness FLOAT,
    valence FLOAT,
    tempo FLOAT,
    duration_min FLOAT,
    title VARCHAR(255),
    channel VARCHAR(255),
    views FLOAT,
    likes BIGINT,
    comments FLOAT,
    licensed BOOLEAN,
    official_video BOOLEAN,
    stream BIGINT,
    energy_liveness FLOAT,
    most_played_on VARCHAR(50)
);

/* --Data Analysis - Easy Questions--
1. Retrieve the names of all tracks that have more than 1 billion streams.
2. List all albums along with their respective artists.
3. Get the total number of comments for tracks where licensed = TRUE.
4. Find all tracks that belong to the album type single.
5. Count the total number of tracks by each artist.
*/

-- 1. Retrieve the names of all tracks that have more than 1 billion streams.

select * from spotify
where stream>1000000000


-- 2. List all albums along with their respective artists.

select distinct album, artist from spotify


-- 3. Get the total number of comments for tracks where licensed = TRUE.

-- select distinct licensed from spotify
select sum(comments) as total_comments from spotify 
where licensed = 'true'


-- 4. Find all tracks that belong to the album type single.

select * from spotify 
where album_type='single'

-- 5. Count the total number of tracks by each artist.

select artist, count(*) as total_tracks from spotify
group by artist 


/* --Data Analysis - Medium Questions--
6. Calculate the average danceability of tracks in each album.
7. Find the top 5 tracks with the highest energy values.
8. List all tracks along with their views and likes where official_video = TRUE.
9. For each album, calculate the total views of all associated tracks.
10. Retrieve the track names that have been streamed on Spotify more than YouTube.
*/

-- 6. Calculate the average danceability of tracks in each album.

select album, avg(danceability) as avg_danceability from spotify
group by album 
order by avg_danceability desc


-- 7. Find the top 5 tracks with the highest energy values.

select track, max(energy) as energy from spotify
group by track 
order by energy desc
limit 5


-- 8. List all tracks along with their views and likes where official_video = TRUE.

select distinct track from spotify
where official_video = 'true'


-- 9. For each album, calculate the total views of all associated tracks.

select album, track, sum(views) as total_views from spotify
group by album, track 
order by total_views desc


-- 10. Retrieve the track names that have been streamed on Spotify more than YouTube.

select * from
(select track, 
	coalesce(sum(case when most_played_on='Youtube' then stream end), 0) as streamed_on_youtube,
	coalesce(sum(case when most_played_on='Spotify' then stream end), 0) as streamed_on_spotify
from spotify 
group by track
) as t1
where
	streamed_on_spotify > streamed_on_youtube
	and
	streamed_on_youtube <> 0



/* --Data Analysis - Advanced Questions--
11. Find the top 3 most-viewed tracks for each artist using window functions.
12. Write a query to find tracks where the liveness score is above the average.
13. Use a WITH clause to calculate the difference between the highest and lowest energy values for tracks in each album.
14. Find tracks where the energy-to-liveness ratio is greater than 1.2.
15. Calculate the cumulative sum of likes for tracks ordered by the number of views, using window functions.
*/

-- 11. Find the top 3 most-viewed tracks for each artist using window functions.

with ranking_artist
as 
(select 
	artist, track, sum(views) as total_views,
	dense_rank() over(partition by artist order by sum(views) desc) as rank
from spotify
group by artist, track 
order by artist, 3 desc
)
select * from ranking_artist
where rank <= 3


-- 12. Write a query to find tracks where the liveness score is above the average.

select track, artist, liveness from spotify
where liveness > (select avg(liveness) from spotify)


-- 13. Use a WITH clause to calculate the difference between the highest and lowest energy values for tracks in each album.

with cte
as 
(select	album,
	max(energy) as highest_energy,
	min(energy) as lowest_energery
from spotify
group by album
)
select 
	album,
	highest_energy - lowest_energery as energy_diff
from cte
order by energy_diff desc


-- 14. Find tracks where the energy-to-liveness ratio is greater than 1.2.

select track, artist, energy, liveness,
  (energy / nullif(liveness, 0)) as energy_to_liveness_ratio
from spotify
where (energy / nullif(liveness, 0)) > 1.2
order by energy_to_liveness_ratio desc


-- 15. Calculate the cumulative sum of likes for tracks ordered by the number of views, using window functions.

select track, artist, views, likes,
  sum(likes) over (order  by views) as cumulative_likes
from spotify
order by views desc
