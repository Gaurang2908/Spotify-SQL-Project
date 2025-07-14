# Spotify-SQL-Project

# 🎵 Spotify Data Analysis Using SQL

Link to dataset:
[Link to dataset](https://www.kaggle.com/datasets/sanjanchaudhari/spotify-dataset)
![Spotify logo](https://github.com/Gaurang2908/Spotify-SQL-Project/blob/main/spotify%20logo.jpg)
This project examines key performance metrics across over 600 global music tracks using structured SQL queries on a cleaned dataset that contains streaming data from Spotify and YouTube. The goal was to simulate real-world data analysis tasks commonly performed by product, analytics, and marketing teams.

---

##  Dataset Overview

The dataset includes:
- 20,000+ records of songs, artists, albums, and metadata
- Streaming counts across platforms (Spotify, YouTube)
- Track-level features: energy, liveness, danceability, likes, views, comments, official video status, licensing, etc.

---

##  Key Objectives

- Analyse artist performance and top content
- Compare streaming behaviour across Spotify vs YouTube
- Derive KPIs like danceability, energy variability, and engagement
- Practice advanced SQL skills (window functions, CTEs, conditional logic)

---

##  Practice Questions (15 Queries)

###  Easy Level
1. Retrieve tracks with more than 1B streams  
2. List all albums with respective artists  
3. Total comments on licensed tracks  
4. Find all tracks from single-type albums  
5. Count total tracks per artist  

###  Medium Level
6. Average danceability per album  
7. Top 5 tracks by energy  
8. Views & likes for official videos  
9. Total views per album  
10. Tracks streamed more on Spotify than YouTube  

###  Advanced Level
11. **Top 3 viewed tracks per artist** (Window Function)  
12. **Tracks with liveness above average**  
13. **Energy range per album** (CTE)  
14. **Tracks where energy-to-liveness ratio > 1.2**  
15. **Cumulative likes by view count** (Window Function)

---

##  Sample KPIs Discovered

- Identified **50+ high-performing singles** with **1B+ Spotify streams**  
- Found official videos with **10M+ YouTube views**  
- Measured **average danceability** and **energy ranges** across albums  
- Calculated **cumulative likes** across **500M+ total views**  
- Compared **platform dominance** between Spotify and YouTube  
- Ranked **top 3 tracks for 30+ artists** based on views

---

##  Technology Stack
- **Database**: PostgreSQL
- **SQL Queries**: DDL, DML, Aggregations, Joins, Subqueries, Window Functions
- **Tools**: pgAdmin 4 (or any SQL editor), PostgreSQL (via Homebrew, Docker, or direct installation)
