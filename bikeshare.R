#set work directory
getwd()
setwd("https://github.com/Mvviggi/Bike-Share-case-study.git")

#load packages
library(tidyverse)
library(ggplot2)
library(dplyr)




 

{
#median values by quarter
Q1_monthly<- Q1_trips%>%
  group_by(month, weekday, member_casual) %>%
  summarize(trip_length= median(total_trip.minutes)) %>%
  mutate(quarter=as.factor("1"))

Q2_monthly<- Q2_trips%>%
  group_by(month, weekday, member_casual) %>%
  summarize(trip_length= median(total_trip.minutes)) %>%
  mutate(quarter=as.factor("2"))

Q3_monthly<- Q3_trips%>%
  group_by(month, weekday, member_casual) %>%
  summarize(trip_length= median(total_trip.minutes)) %>%
  mutate(quarter=as.factor("3"))

Q4_monthly<- Q4_trips%>%
  group_by(month, weekday, member_casual) %>%
  summarize(trip_length= median(total_trip.minutes)) %>%
  mutate(quarter=as.factor("4"))

#rbind Quarters monthly dfs

Month_median_trips<- rbind(Q1_monthly, Q2_monthly, Q3_monthly, Q4_monthly)
#Convert to factors month and weekday
Month_median_trips$weekday <- factor(Month_median_trips$weekday, levels = days_of_the_week)
Month_median_trips$month <- factor(Month_median_trips$month, levels = months_of_year)
write.csv(Month_median_trips, "C:/Users/mvvb8/Documents/GitHub/Bike-Share-case-study/Files/monthly_median_triplength.csv")
summary(Month_median_trips)
}
#create a df with the median of day of the week for member and for casual users
casual_data<- weekday_median_df %>% filter(member_casual == "casual")
member_data<- weekday_median_df %>% filter(member_casual == "member")





summary(Q1_trips$total_trip.minutes)
  
  
  
  
  

  
  
  
  


