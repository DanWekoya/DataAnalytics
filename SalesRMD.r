---
title: "Deluxe Retail Sales EDA"
author: "Dan"
date: "2023-09-11"
output: html_document
---


##### Hi all, I'm new to this. Would appreciate some comments. Ok, here we go.

#Lets load the good old tidyverse !

library(tidyverse)

## data.table too

library (data.table)

## Lets preview the dataframe

glimpse (Sales)

head (Sales)

## Ok, lets get some insights. 1. How does Deluxe's sales compare among different countries?

setDT (Sales) 

Sales[ ,list(TotalSales=sum(order_value_EUR)), by=country]

## Great, we have the sales volume for 15 countries, lets see how the managers performed

Sales [,list(TotalSales = sum(order_value_EUR)), by = sales_manager]

## Wait a minute, 15 countries and 15 Sales Managers? is every manager in charge of the operations of a single country, lets see how many managers had sales in Sweden.

Sales %>%
filter (country == "Sweden") %>%
select (sales_manager)

## Aha! got you Maxie Marrow, was about to do this 14 more times but I luckily got a combination of codes that made it way easier.

Sales %>%
group_by (country) %>%
distinct (sales_manager) %>%
print (n = 15)

## I'd love to see how much worth of each product category was sold

Sales [,list (TotalSales = sum(order_value_EUR)), by = category]

## Ok, I'll now get some plots  1. How much sales of each category did Deluxe have in every country ?

ggplot(Sales, aes(x=category, y=order_value_EUR, fill =category, label = order_value_EUR)) + 
  geom_bar(stat = "identity") +
  facet_wrap(~country)
