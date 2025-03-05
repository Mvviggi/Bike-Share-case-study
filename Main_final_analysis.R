#set work directory
getwd()
setwd("https://github.com/Mvviggi/Bike-Share-case-study.git")

#load packages
library(tidyverse)
library(ggplot2)
library(dplyr)

# STEP 4: CONDUCT DESCRIPTIVE ANALYSIS
#=====================================
# Descriptive analysis on ride_length (all figures in seconds)

triplength2023<- rbind(Q1_trips, Q2_trips, Q3_trips, Q4_trips)
str(triplength2023)
summary(triplength2023$total_trip.minutes)
##summary(triplength2023$total_trip.minutes)
# Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
# 1.00     5.78     9.93    19.09    17.48 98489.07 


mean(triplength2023$total_trip.minutes) #straight average (total ride length / rides)
median(triplength2023$total_trip.minutes) #midpoint number in the ascending array of ride lengths
max(triplength2023$total_trip.minutes) #longest ride
min(triplength2023$total_trip.minutes) #shortest ride

#histogram
hist(triplength2023$total_trip.minutes, 
     main = "Histogram of Total Trip Minutes", 
     xlab = "Total Trip Minutes", 
     col = "lightblue", 
     border = "black")

#adjusting skewness
hist(triplength2023$total_trip.minutes[triplength2023$total_trip.minutes < 100], 
     main = "Histogram of Total Trip Minutes (Filtered)", 
     xlab = "Total Trip Minutes", 
     col = "lightblue", 
     border = "black")

#Filtered dataframe to trips that lasted 100 minutes or less
filtered_trip_length<- triplength2023 %>%
  filter(total_trip.minutes <= c(100))

# Compare members and casual users
aggregate(triplength2023$total_trip.minutes ~ triplength2023$member_casual, FUN = mean)
aggregate(triplength2023$total_trip.minutes ~ triplength2023$member_casual, FUN = median)
aggregate(triplength2023$total_trip.minutes ~ triplength2023$member_casual, FUN = max)
aggregate(triplength2023$total_trip.minutes ~ triplength2023$member_casual, FUN = min)


#import files combined from SQL
avg_triplength_wd<- read.csv("C:/Users/mvvb8/Documents/GitHub/Bike-Share-case-study/Files/AVG_trip_duration_weekday.csv")
totalCount_bikes<- read.csv("C:/Users/mvvb8/Documents/GitHub/Bike-Share-case-study/Files/total_count_bikeType.csv")
month_rides<- read.csv("C:/Users/mvvb8/Documents/GitHub/Bike-Share-case-study/Files/total_rides_month.csv")
# Convert categorical variables to factors with specified levels
avg_triplength_wd$weekday <- factor(avg_triplength_wd$weekday, levels = days_of_the_week)
month_rides$month <- factor(month_rides$month, levels = months_of_year)


#plot average trip duration by day of the week
{mean_trip_wekday <- avg_triplength_wd %>%
  ggplot(aes(x= weekday, y=average_trip_length, fill = member_casual)) +
  geom_bar(stat = "identity", position = "dodge", width = 0.7) +
  geom_text(aes(label = round(average_trip_length, 0)), 
            position = position_dodge(width = 0.7), 
            vjust = -0.3, size = 4) +
  labs(
    title = "Mean trip duration by day of the week",
    subtitle = "Comparing trip duration(min) for casual vs. member riders",
    x = "Day of the Week",
    y = "Mean Trip Length") +
  scale_fill_brewer(palette = "Set2") +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 16, face = "bold", hjust = 0.5),
    plot.subtitle = element_text(size = 12, hjust = 0.5),
    strip.text.y = element_text(size = 14, face = "bold"),  # Style for row facets
    axis.text.x = element_text(size = 12, angle = 45, hjust = 1),
    axis.title = element_text(size = 12),
    legend.title = element_text(size = 12),
    legend.text = element_text(size = 12)
  )
mean_trip_wekday
ggsave("mean_trip_wekday.png",bg = "white")
}
#plot total_count_bikeType
biketypes<- totalCount_bikes %>%
  ggplot(aes(y=rideable_type, x=total_trips, fill= member_casual)) +
  geom_bar(stat = "identity", position = "stack", width = 0.7)

#Plot total monthly rides
monthly_rides<- month_rides %>%
  ggplot(aes(x=month, y=total_trips, fill= member_casual)) +
  geom_bar(stat = "identity", position = "stack", width = 0.7)
