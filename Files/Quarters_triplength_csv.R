##########****Quarters df by quarter saved in csv Files folder with total trip length in minutes########
##Q1 and Q4 trips
Q1_trips<- read.csv("C:/Users/mvvb8/Documents/GitHub/Bike-Share-case-study/Files/Q1_trips.csv")
Q4_trips<- read.csv("C:/Users/mvvb8/Documents/GitHub/Bike-Share-case-study/Files/Q4_trips.csv")

## Q2 trips: April, May, June
april<-read.csv("C:/Users/mvvb8/Documents/GitHub/Bike-Share-case-study/Files/April_trips.csv") 
may<-read.csv("C:/Users/mvvb8/Documents/GitHub/Bike-Share-case-study/Files/May_trips.csv")
june<- read.csv("C:/Users/mvvb8/Documents/GitHub/Bike-Share-case-study/Files/June_trips.csv")

##Q3 trips: July, Aug, Sept
july<- read.csv("C:/Users/mvvb8/Documents/GitHub/Bike-Share-case-study/Files/July_trips.csv")
aug<- read.csv("C:/Users/mvvb8/Documents/GitHub/Bike-Share-case-study/Files/Aug_trips.csv")
sept<- read.csv("C:/Users/mvvb8/Documents/GitHub/Bike-Share-case-study/Files/Sept_trips.csv")

#merge with rbind Q2 and Q3 
Q2_trips<- rbind(april, may, june)
Q3_trips<- rbind(july, aug, sept)
write.csv(Q2_trips, "C:/Users/mvvb8/Documents/GitHub/Bike-Share-case-study/Files/Q2_trips.csv") #Missing data too large for spreadsheet
write.csv(Q3_trips, "C:/Users/mvvb8/Documents/GitHub/Bike-Share-case-study/Files/Q3_trips.csv")

count(Q2_trips$member_casual)
Q2_trips %>%
  count(member_casual)

count4<- april %>%
  count(member_casual)

count5<- may %>%
  count(member_casual)

count6<- june %>%
  count(member_casual)

totalcountsQ2<- rbind(count4, count5, count6)

totalmember_casual<- totalcountsQ2 %>%
  group_by(member_casual) %>%
  summarise(total=sum(n))

            