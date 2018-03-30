getwd()
#folder path
setwd("/home/olha/dev/WDC/WDC/Neuralnet/")
#install.packages("readxl")
library(readxl)
library(plyr)
# creating the initial data
data_source_1 <- read_excel("gl2017_source.xlsx", 1)
data_source_2 <- read_excel("gl2017_calc.xlsx", 1)
data_threats <- rbind.fill(list(data_source_1, data_source_2))
str(data_threats)
sapply(data_threats, typeof)
head(data_threats)
names(data_threats)

# data sorting
data_threats <- data_threats[order(data_threats$year, data_threats$region_abbr, data_threats$index_abbr),]
data_threats <- subset(data_threats, data_threats$year >= '2005')
head(data_threats)




