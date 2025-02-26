---
title: "README.md"
author: "Maria Viggiano"
date: "2025-02-11"
output: html_document
---


# **Case Study for bike-share fictional company**

<p>This repository is shared to publish the capstone project completed for the Google Data Analytics Professional course. 
In this project the goal is to show the process of data analysis learned from the course to: 
<ins>ask, prepare, process, analyze, share and act. <ins> <p>



# Scenario
You are a junior data analyst working on the marketing analyst team at Cyclistic, a bike-share
company in Chicago. The director of marketing believes the company’s future success
depends on maximizing the number of annual memberships. Therefore, your team wants to
understand how casual riders and annual members use Cyclistic bikes differently. From these
insights, your team will design a new marketing strategy to convert casual riders into annual
members. But first, Cyclistic executives must approve your recommendations, so they must be
backed up with compelling data insights and professional data visualizations.

# About the company
In 2016, Cyclistic launched a successful bike-share offering. Since then, the program has grown
to a fleet of 5,824 bicycles that are geotracked and locked into a network of 692 stations
across Chicago. The bikes can be unlocked from one station and returned to any other station
in the system anytime.
Until now, Cyclistic’s marketing strategy relied on building general awareness and appealing to
broad consumer segments. One approach that helped make these things possible was the
flexibility of its pricing plans: single-ride passes, full-day passes, and annual memberships.
Customers who purchase single-ride or full-day passes are referred to as casual riders.
Customers who purchase annual memberships are Cyclistic members.
Cyclistic’s finance analysts have concluded that annual members are much more profitable
than casual riders. Although the pricing flexibility helps Cyclistic attract more customers,
the director of Marketing, Lily Moreno, believes that maximizing the number of annual members will be key to future growth.
Rather than creating a marketing campaign that targets all-new customers, Moreno believes
there is a solid opportunity to convert casual riders into members. She notes that casual riders
are already aware of the Cyclistic program and have chosen Cyclistic for their mobility needs.


## Steps
#### 1. Ask
**Business Task:** Design marketing strategies aimed at converting casual riders into
annual members. In order to do that, however, the team needs to better understand: <br>
1. How do annual members and casual riders use Cyclistic bikes differently? <br>
2. Why would casual riders buy Cyclistic annual memberships? <br>
3. How can Cyclistic use digital media to influence casual riders to become members? <br>


#### 2. Prepare
**Data Source:** [divvy-tripdata](https://divvy-tripdata.s3.amazonaws.com/index.html)<br>
[Note that the data has been made available by Motivate International Inc. under this [<ins>license</ins>](https://www.divvybikes.com/data-license-agreement).]

**Tools:** <br>
- Data cleaning: Excel Power Query and Pivot Tables<br>
- Data Exploration: SQL and Rstudio <br>
- Data visualization - Rstudio and Tableau






Load R packages
```
library(tidyverse)
library(dplyr)
library(ggplot2)
```



