-- BIKE ANALYSIS
--Number of bikes by type currently in rotation. 
Select bike_type, Count(Distinct bike_id) As num_bikes
From metro_trips
Group by bike_type
Order by num_bikes DESC

--Number of trips taken by bike type
Select bike_type, Count(distinct trip_id) As num_trips_taken
From metro_trips
Group by bike_type
Order by num_trips_taken DESC

 --Number of trips taken by individual bike and max durations used
Select bike_id, 
	bike_type, 
	Max(duration), 
	Count(trip_id) As num_of_trips
From metro_trips
Group by bike_id, bike_type
Order by num_of_trips DESC



--Most frequented stations by the most ridden bike(bike_id 16837)
Select station_name, Count(trip_id) As num_visits
From metro_trips As mt
Join metro_stations As ms
On mt.end_station = ms.station_id
Where bike_id = 16837
Group by station_name
Order by num_visits DESC

--Which passholder type uses bike 16837 the most
Select pass_holder, Count(pass_holder) As num_of_uses
From metro_trips
Where bike_id = 16837
Group by pass_holder 
Order by num_of_uses

-- STATION ANALYSIS

--Number of stations per region
Select region, Count(Distinct station_name) As num_stations
From metro_stations
Where status= 'Active'
Group by region


--Top 10 most popular stations that riders traveled to (exluded virtual stations)
Select Distinct ms.station_name, 
	region, 
	Count(trip_id) As trips_traveled
From metro_trips As mt
Join metro_stations As ms
On mt.end_station = ms.station_id
Where (station_name <> 'Virtual Station') AND status ='Active'
Group by ms.station_name, region
Order by trips_traveled DESC
Limit 10

--- 10 most popular start stations 
Select Distinct ms.station_name, 
	region, 
	Count(trip_id) As trips_traveled
From metro_trips As mt
Join metro_stations As ms
On mt.start_station = ms.station_id
Where station_name <> 'Virtual Station'
Group by ms.station_name, region
Order by trips_traveled DESC
Limit 10

-- USER ANALYSIS

-- Number of users per type of user
Select pass_holder, 
	Count(pass_holder) As num_users
From metro_trips
Group by pass_holder
Order by num_users

-- Number and average duartion of trips by pass holder type
Select pass_holder, 
	Count(Distinct trip_id) As pass_holder_trips,
	Avg(duration) avg_duration
From metro_trips
Group by pass_holder
Order by pass_holder_trips
