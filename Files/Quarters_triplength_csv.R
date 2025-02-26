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
write.csv(Q2_trips, "C:/Users/mvvb8/Documents/GitHub/Bike-Share-case-study/Files/Q2_trips.csv")
write.csv(Q3_trips, "C:/Users/mvvb8/Documents/GitHub/Bike-Share-case-study/Files/Q3_trips.csv")