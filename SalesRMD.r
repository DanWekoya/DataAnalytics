##### With R studio already installed, save the CSV to a folder of your choice and then load it using the read.csv command

## I use the tidyverse and data.table libraries in the analysis, loaded as follows

library(tidyverse)
library (data.table)

## After loading the libraries I preview the dataset with glimpse() and head() functions.
## - This helps to gain an initial overview of the number of columns and the data contained in each column.

glimpse (Sales)
head (Sales)

## To get insights regarding the sales of the clothing among different countries

setDT (Sales) 
Sales[ ,list(TotalSales=sum(order_value_EUR)), by=country]

## The code above returns output showing fifteen countries and the companies sales in each of them 
## the code below derives insisghts on the performance of each manager

Sales [,list(TotalSales = sum(order_value_EUR)), by = sales_manager]

## The output shows fifteen managers with their respective sales
## Could it be that every manager is assigned a specific country or do the managers operate in multiple countyries?
## To check how many managers recorded sales in Sweden

Sales %>%
filter (country == "Sweden") %>%
select (sales_manager)

## The code shows that only one manager recorded sales in Sweden,
## The code below extracts the full list of managers and their country of operation

Sales %>%
group_by (country) %>%
distinct (sales_manager) %>%
print (n = 15)

## The code below extracts the amount of sales recorded for each category of clothes

Sales [,list (TotalSales = sum(order_value_EUR)), by = category]

## The following code uses ggplot2 to generate a bar graph for each product category among all the countries?

ggplot(Sales, aes(x=category, y=order_value_EUR, fill =category, label = order_value_EUR)) + 
  geom_bar(stat = "identity") +
  facet_wrap(~country)
