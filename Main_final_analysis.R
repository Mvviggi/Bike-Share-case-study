# STEP 1: WORKING DIRECTORY
#===============================
#set work directory
getwd()
setwd("C:/Users/mvvb8/Documents/GitHub/Bike-Share-case-study")


# STEP 2: LOAD PACKAGES 
#===============================
#load packages
library(tidyverse) #to load dplyr and ggplot2 packages
library(ggplot2) #data visualization
library(dplyr) #data manipulation
library(knitr) #for Rmarkdown ReadMe file


# STEP 3: IMPORT DATAFRAMES
#===============================
# Import spreadsheets cleaned from Power Query and combined from queries from SQL 
avg_triplength_wd<- read.csv("https://github.com/Mvviggi/Bike-Share-case-study/blob/e7d1f31158701ba9f0d6f20e29601d3882a68bac/Files/AVG_trip_duration_weekday.csv") #used SQL to query average trip duration per user by weekday
avg_month_triplength<- read.csv("https://github.com/Mvviggi/Bike-Share-case-study/blob/e7d1f31158701ba9f0d6f20e29601d3882a68bac/Files/AVG_trip_duration_month.csv") #used SQL to query average trip duration per user by month
totalCount_bikes<- read.csv("https://github.com/Mvviggi/Bike-Share-case-study/blob/e7d1f31158701ba9f0d6f20e29601d3882a68bac/Files/total_count_bikeType.csv")#used SQL to query count of bike type used by user
month_rides<- read.csv("https://github.com/Mvviggi/Bike-Share-case-study/blob/e7d1f31158701ba9f0d6f20e29601d3882a68bac/Files/total_rides_month.csv") #used SQL to query total number of rides per month 
triprange<- read.csv("https://github.com/Mvviggi/Bike-Share-case-study/blob/e7d1f31158701ba9f0d6f20e29601d3882a68bac/Files/2023_triprange.csv") #used Power Query to create column grouped by trip duration ranges category

# Import datasets by quarter from Files folder into R to rbind all as one single dataframe
#triplength2023<- rbind(Q1_trips, Q2_trips, Q3_trips, Q4_trips) -- Used SQL to combined the 2023 trips table


# STEP 4: CREATE FUNCTIONS & CONVERT COLUMNS INTO FACTOR VARIABLE
#===============================
# Months, weekdays and trip range functions to set these columns as factor variables.

days_of_the_week <- c("Sunday", "Monday", "Tuesday", "Wednesday", 
                      "Thursday", "Friday", "Saturday")

months_of_year<- c('January', 'February', 'March', 'April', 'May',
                   'June', 'July', 'August', 'September', 'October', 'November', 'December')

#range_level<-c("under 10", "10 to 30", "30 to 60", "over 60") -- Used Tableau to create visualizations of this dataframe.


# Convert categorical variables to factors with function levels

avg_triplength_wd$weekday <- factor(avg_triplength_wd$weekday, levels = days_of_the_week)
month_rides$month <- factor(month_rides$month, levels = months_of_year)
avg_month_triplength$month<- factor(avg_month_triplength$month, levels = months_of_year)

# STEP 5: CONDUCT DESCRIPTIVE ANALYSIS
#=====================================
# Descriptive analysis on ride_length (all figures in minutes)

#Validate data structure of dataframe for entire database of 2023.
str(triplength2023)
str(avg_triplength_wd)
mean(triplength2023$total_trip.minutes) #straight average (total ride length / rides)
median(triplength2023$total_trip.minutes) #midpoint number in the ascending array of ride lengths
max(triplength2023$total_trip.minutes) #longest ride
min(triplength2023$total_trip.minutes) #shortest ride


# Compare summary table for members and casual users
desc_stats<- triplength2023%>% 
  group_by(member_casual)%>%
  summarise(
    mean = mean(total_trip.minutes, na.rm = TRUE),
    median = median(total_trip.minutes, na.rm = TRUE),
    max = max(total_trip.minutes, na.rm = TRUE),
    min = min(total_trip.minutes, na.rm = TRUE)
  )
desc_stats<- write.csv(desc_stats, "C:/Users/mvvb8/Documents/GitHub/Bike-Share-case-study/desc_stats.csv")
  


# STEP 6: DATA VISUALIZATION
#=====================================
# plotting multiple results

#plot average trip duration by day of the week
{mean_trip_wekday <- avg_triplength_wd %>%
  ggplot(aes(x= weekday, y=avg_trip_length, fill = member_casual)) +
  geom_bar(stat = "identity", position = "dodge", width = 0.7) +
  geom_text(aes(label = round(avg_trip_length, 0)), 
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
    axis.text.y = element_text(size = 12),
    axis.title = element_text(size = 12),
    legend.title = element_text(size = 12),
    legend.text = element_text(size = 12)
  )
mean_trip_wekday
ggsave("mean_trip_wekday.png",bg = "white")
}

#plot average trip duration by month
{mean_trip_month<- avg_month_triplength %>%
  ggplot(aes(x= month, y=avg_trip_length, fill = member_casual)) +
  geom_bar(stat = "identity", position = "dodge", width = 0.7) +
  geom_text(aes(label = round(avg_trip_length, 0)), 
            position = position_dodge(width = 0.7), 
            vjust = -0.3, size = 4) +
  labs(
    title = "Mean trip duration by month",
    subtitle = "Comparing trip duration(min) for casual vs. member riders",
    x = "Month",
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
}
mean_trip_month
ggsave("mean_trip_month.png", bg= "white")
  
#Plot total_count_bikeType
{biketypes<- totalCount_bikes %>%
  ggplot(aes(x=member_casual, y=count, fill= ride_type)) +
  geom_bar(stat = "identity", position = "stack", width = 0.7) +
    geom_text(aes(label = paste0(round(count / sum(count) * 100, 0), "%")), 
              position = position_stack(vjust = 0.5), 
              vjust = 0.5, hjust = 0.3, size = 4, col = "black") +
  labs(title = "Count of rideable type used by members vs casual",
       subtitle= "Showing percentage of total count for each ride type",
       x= "Membership Type",
       y=" Bike Type Count") +
  scale_fill_brewer(palette = "Set2") +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 16, face = "bold", hjust = 0.5),
    plot.subtitle = element_text(size = 12, hjust = 0.5),
    strip.text.y = element_text(size = 14, face = "bold"),  # Style for row facets
    axis.text.x = element_text(size = 12),
    axis.text.y = element_text(size = 12),
    axis.title = element_text(size = 12),
    legend.title = element_text(size = 12),
    legend.text = element_text(size = 12)
  )
} 
biketypes
ggsave("biketypes.png",bg = "white")

###Calculating Percentage of rides per month member vs casual
# Compute percentage of trips per month
month_rides_percent <- month_rides %>%
  group_by(month) %>%
  mutate(percentage = total_trips / sum(total_trips) * 100)

# Plot using ggplot
{monthly_rides_per <- month_rides_percent %>%
  ggplot(aes(x = month, y = percentage, fill = member_casual)) +
  geom_bar(stat = "identity", position = "dodge", width = 0.8) +
  geom_text(aes(label = paste0(round(percentage, 0), "%")),  # Format as percentage
            position = position_dodge(width = 0.7),
            vjust = -0.5, size = 4) +
  labs(
    title = "Total Count Percentage of Rides per Month",
    subtitle = "Comparing total ride percentages for casual vs. member users",
    x = "Month",
    y = "Percentage of Total Rides"
  ) +
  scale_fill_brewer(palette = "Set2") +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 16, face = "bold", hjust = 0.5),
    plot.subtitle = element_text(size = 12, hjust = 0.5),
    strip.text.y = element_text(size = 14, face = "bold"),
    axis.text.x = element_text(size = 12, angle = 45, hjust = 0.5),
    axis.text.y = element_text(size = 12, hjust = 1),
    axis.title = element_text(size = 12),
    legend.title = element_text(size = 12),
    legend.text = element_text(size = 12)
  )
}
# Print the plot
monthly_rides_per

ggsave("monthly_rides_per.png", bg ="white")

