--Validate each quarter database has no missing values
SELECT COUNT(*) ,
COUNT(rideable_type) rideable_type,
COUNT(member_casual) member_casual,
COUNT(month) month,
COUNT(weekday) weekday,
COUNT(total_trip_minutes) total_trip_minutes,
COUNT(quarter) quarter
FROM Q1_trips;

--In ExcelPowerQuery the Q2_trips and Q3_trips exceed the number of rows to create a csv file.
--need to add tables by month and then union by quarter.
--create tables per month for Q2--april, may and june. and Q3- july, aug, sept
CREATE TABLE Q2_trips (
	rideable_type nvarchar(50),
	member_casual nvarchar(50),
	month nvarchar(50), 
	weekday nvarchar(50), 
	total_trip_minutes numeric(18,0),
	quarter tinyint);
--Insert data into new table union all
INSERT INTO Q2_trips (rideable_type, member_casual, month, weekday, total_trip_minutes, quarter)
SELECT rideable_type, member_casual, month, weekday, total_trip_minutes, quarter FROM April_trips
UNION ALL
SELECT rideable_type, member_casual, month, weekday, total_trip_minutes, quarter FROM May_trips
UNION ALL
SELECT rideable_type, member_casual, month, weekday, total_trip_minutes, quarter FROM June_trips;

--validate table Q2_trips
SELECT COUNT(*)
FROM Q2_trips;

SELECT COUNT(*) ,
COUNT(rideable_type) rideable_type,
COUNT(member_casual) member_casual,
COUNT(month) month,
COUNT(weekday) weekday,
COUNT(total_trip_minutes) total_trip_minutes,
COUNT(quarter) quarter
FROM Q2_trips;

CREATE TABLE Q3_trips (
	rideable_type nvarchar(50),
	member_casual nvarchar(50),
	month nvarchar(50), 
	weekday nvarchar(50), 
	total_trip_minutes numeric(18,0),
	quarter tinyint);
--Insert data into new table union all
INSERT INTO Q3_trips (rideable_type, member_casual, month, weekday, total_trip_minutes, quarter)
SELECT rideable_type, member_casual, month, weekday, total_trip_minutes, quarter FROM July_trips
UNION ALL
SELECT rideable_type, member_casual, month, weekday, total_trip_minutes, quarter FROM Aug_trips
UNION ALL
SELECT rideable_type, member_casual, month, weekday, total_trip_minutes, quarter FROM Sept_trips;

SELECT *
FROM Q3_trips;

SELECT COUNT(*) ,
COUNT(rideable_type) rideable_type,
COUNT(member_casual) member_casual,
COUNT(month) month,
COUNT(weekday) weekday,
COUNT(total_trip_minutes) total_trip_minutes,
COUNT(quarter) quarter
FROM Q3_trips;

SELECT COUNT(*) ,
COUNT(rideable_type) rideable_type,
COUNT(member_casual) member_casual,
COUNT(month) month,
COUNT(weekday) weekday,
COUNT(total_trip_minutes) total_trip_minutes,
COUNT(quarter) quarter
FROM Q4_trips;

--Create TABLE for all rides_2023
CREATE TABLE rides_2023 (
	rideable_type nvarchar(50),
	member_casual nvarchar(50),
	month nvarchar(50), 
	weekday nvarchar(50), 
	total_trip_minutes numeric(18,0),
	quarter tinyint);
--Insert data into new table union all
INSERT INTO rides_2023 (rideable_type, member_casual, month, weekday, total_trip_minutes, quarter)
SELECT rideable_type, member_casual, month, weekday, total_trip_minutes, quarter FROM Q1_trips
UNION ALL
SELECT rideable_type, member_casual, month, weekday, total_trip_minutes, quarter FROM Q2_trips
UNION ALL
SELECT rideable_type, member_casual, month, weekday, total_trip_minutes, quarter FROM Q3_trips
UNION ALL
SELECT rideable_type, member_casual, month, weekday, total_trip_minutes, quarter FROM Q4_trips;

--Total trips of >=1 minute duration are 5,259,284
SELECT *
FROM rides_2023;



--Find the total rides per user by each bike type
SELECT member_casual, rideable_type,
COUNT(*) as total_rides
FROM rides_2023
GROUP BY member_casual, rideable_type
ORDER  BY member_casual, total_rides DESC;

--Find total rides per month
SELECT member_casual, month,
COUNT(*) as total_rides_month
FROM rides_2023
GROUP BY member_casual, month
ORDER BY member_casual, month DESC;

--Find total rides by weekday
SELECT member_casual, weekday,
COUNT(*) as total_rides_weekday
FROM rides_2023
GROUP BY member_casual, weekday
ORDER BY member_casual, weekday DESC;

--Find the average trip duration per weekday
SELECT member_casual, weekday, 
AVG(total_trip_minutes) as avg_trip_duration
FROM rides_2023
GROUP BY member_casual, weekday
ORDER BY member_casual, weekday DESC;

--Find the average trip duration per month
SELECT member_casual, month, 
AVG(total_trip_minutes) as avg_trip_duration
FROM rides_2023
GROUP BY member_casual, month
ORDER BY member_casual, month DESC;


