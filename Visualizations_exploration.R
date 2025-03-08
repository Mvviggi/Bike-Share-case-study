##testing visualizations
##Examination: Visualizations for median trip_lengths
monthlytrips<- Month_median_trips %>%
  ggplot(aes(x=month, y= trip_length)) +
  geom_boxplot() +
  facet_grid(member_casual ~ .)

#Visualize median trips length for day of the week
ggplot(Month_median_trips, aes(x = month, y = trip_length, color = weekday, group = weekday)) +
  geom_line(size=1) +
  facet_wrap(~ member_casual) +
  theme_minimal() +
  labs(title = "Trip Length by Month Faceted by Membership Type",
       x = "Month",
       y = "Trip Length") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) 

# Pie chart for casual users
casual_pie <- ggplot(casual_data, aes(x = "", y = weekday_medianTrips, fill = weekday)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar(theta = "y") +
  labs(title = "Casual Users - Median Trips by Weekday") +
  theme_void()

# Pie chart for member users
member_pie <- ggplot(member_data, aes(x = "", y = weekday_medianTrips, fill = weekday)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar(theta = "y") +
  labs(title = "Member Users - Median Trips by Weekday") +
  theme_void()

# Print plots
print(casual_pie)
print(member_pie)

##Trip range analysis
{
  #load dataframe for trip duration count ranges in minutes from directory
  triprange<- read.csv("C:/Users/mvvb8/Documents/GitHub/Bike-Share-case-study/Files/2023_triprange.csv")
  str(triprange)
  #create functions for months, weekdays 
  days_of_the_week <- c("Sunday", "Monday", "Tuesday", "Wednesday", 
                        "Thursday", "Friday", "Saturday")
  
  months_of_year<- c('January', 'February', 'March', 'April', 'May',
                     'June', 'July', 'August', 'September', 'October', 'November', 'December')
  
  range_level<-c("under 10", "10 to 30", "30 to 60", "over 60")
  
  # Convert categorical variables to factors with specified levels
  triprange$weekday <- factor(triprange$weekday, levels = days_of_the_week)
  triprange$month <- factor(triprange$month, levels = months_of_year)
  triprange$trip_range <- factor(triprange$trip_range, levels = range_level)
  
  #Convert count_range into numeric
  triprange$count_range<- as.numeric(triprange$count_range)
  
  #Check for missing values NA
  sum(is.na(triprange))
  
}                        
#Visualization  Median count rides ranges per month
{
  triprange %>%
    group_by(month, member_casual, trip_range) %>%
    summarise(monthlyCountrange= median(count_range,na.rm = TRUE)) %>%   # Ensuring NA values are handled
    ggplot()+ 
    labs(title= "Median count length trips ranges by month",
         x= "Months",
         y = "Median count rides ranges")+
    scale_fill_brewer(palette = "Set2") +
    geom_bar(aes(x= month, y=monthlyCountrange, fill= trip_range), stat ="identity", position="dodge", width = 0.7) +
    facet_wrap(~member_casual, scales="fixed") +
    theme_minimal() +
    theme(
      strip.text = element_text(size = 14, face = "bold"),
      axis.text.x = element_text(size = 12, angle = 45, hjust = 1),
      plot.title= element_text(size = 16, hjust= 0.5))
}
{
  #Enhanced visualization from above:
  triprange %>%
    group_by(month, member_casual, trip_range) %>%
    summarise(monthlyCountrange = median(count_range, na.rm = TRUE)) %>%
    ggplot(aes(x = month, y = monthlyCountrange, fill = trip_range)) + 
    geom_bar(stat = "identity", position = "dodge", width = 0.7) +
    geom_text(aes(label = round(monthlyCountrange, 0)), 
              position = position_dodge(width = 0.7), 
              vjust = -0.3, size = 3) +
    labs(
      title = "Median Duration Trip Counts by Month",
      subtitle = "Comparing counts of trip duration ranges (min) for casual vs. member riders",
      x = "Month",
      y = "Median Trip Count"
    ) +
    scale_fill_brewer(palette = "Set2") +
    facet_grid(member_casual ~ .) +  # Facet by rows, removing duplicated months
    theme_minimal() +
    theme(
      plot.title = element_text(size = 16, face = "bold", hjust = 0.5),
      plot.subtitle = element_text(size = 12, hjust = 0.5),
      strip.text.y = element_text(size = 14, face = "bold"),  # Style for row facets
      axis.text.x = element_text(size = 10, angle = 45, hjust = 1),
      axis.title = element_text(size = 12),
      legend.title = element_text(size = 12),
      legend.text = element_text(size = 10)
    )
}

#Visualization of median trip counts by weekday 
weekday_plot<-triprange %>%
  group_by(weekday, trip_range, member_casual) %>%
  summarise(medianWeekdaycounts= median(count_range,na.rm = TRUE)) %>%
  ggplot(aes(x= weekday, y= medianWeekdaycounts, fill= trip_range))+
  geom_bar(stat = "identity", position = "dodge", width =0.7) +
  geom_text(aes(label = round(medianWeekdaycounts, 0)), 
            position = position_dodge(width = 0.7), 
            vjust = -0.3, size = 3) +
  labs(title= "Median Ride Counts of duration trip ranges by weekday",
       subtitle= "Comparing median ride counts of trip ranges (min) for casual vs member riders ",
       x= "Day of the Week",
       y= "Median count rides by weekday") +
  scale_fill_brewer(palette = "Set2") +
  facet_grid(member_casual ~ .) +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 16, face = "bold", hjust = 0.5),
    plot.subtitle = element_text(size = 12, hjust = 0.5),
    strip.text.y = element_text(size = 14, face = "bold"),  # Style for row facets
    axis.text.x = element_text(size = 10, angle = 45, hjust = 1),
    axis.title = element_text(size = 12),
    legend.title = element_text(size = 12),
    legend.text = element_text(size = 10)
  )
weekday_plot 
ggsave("weekday_plot.png",bg = "white")

#create a df with the count per week for member and for casual users in trip ranges
casual_counts<- triprange %>% group_by(weekday)%>% filter(member_casual == "casual")%>% 
  summarise(totalcounts= sum(count_range,na.rm = TRUE)) %>%
  mutate(percentage=round(100*totalcounts/sum(totalcounts)))
member_counts<- triprange %>% filter(member_casual == "member")%>% group_by(weekday)%>% 
  summarise(totalcounts= sum(count_range,na.rm = TRUE)) %>%
  mutate(percentage=round(100*totalcounts/sum(totalcounts)))

casual_pie_count <- ggplot(casual_counts, aes(x = "", y = percentage, fill = weekday)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar(theta = "y") +
  geom_text(aes(label= percentage),position = position_stack(vjust = 0.5))+
  labs(title = "Casual Users - Trip counts by range per Weekday") +
  theme_void()

# Pie chart for member users
member_pie_count <- ggplot(member_counts, aes(x = "",  y = percentage, fill = weekday)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar(theta = "y") +
  geom_text(aes(label= percentage),position = position_stack(vjust = 0.5))+
  labs(title = "Member Users - Trip counts by range per Weekday") +
  theme_void()

# Print plots
print(casual_pie_count)
print(member_pie_count)


