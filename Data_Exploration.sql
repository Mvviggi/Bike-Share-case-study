SELECT COUNT(*) - COUNT(rideable_type) rideable_type,
 COUNT(*) - COUNT(start_station_name) start_station_name, 
 COUNT(*) - COUNT(end_station_name) end_station_name,
 COUNT(*) - COUNT(start_lat) start_lat,
 COUNT(*) - COUNT(start_lng) start_lng,
 COUNT(*) - COUNT(end_lat) end_lat,
 COUNT(*) - COUNT(end_lng) end_lng,
 COUNT(*) - COUNT(member_casual) member_casual,
 COUNT(*) - COUNT(started_date) started_date,
 COUNT(*) - COUNT(ended_date) ended_date
FROM minutesbikeride
