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
library(reshape)
threats_data <- reshape(data_threats, idvar = c("region_abbr","index_abbr"), timevar = "year", direction = "wide")
head(threats_data)

# missing value
sum(is.na(threats_data))
library(zoo)
missing_approx <- function(x) {
  return (na.approx(x,na.rm = F))
}

missing_spline <- function(x) {
  return (na.spline(x, na.rm = F))
}

data <- threats_data
for( i in 3:ncol(data)){ 
  m <- missing_approx(data[,i])
  data[,i] <- missing_spline(m)
}
head(data)
sum(is.na(data))
colnames(data)[3: NCOL(data)] <- 2005:2016
library(tidyr)
data =  gather(data, year, values, 3:14 , factor_key = FALSE)
head(data)
sum(is.na(data))
data_cast <- cast(data, region_abbr + year ~ index_abbr)
head(data_cast)
sum(is.na(data_cast))
data_cast <- data_cast[, -which(colMeans(is.na(data_cast)) > 0.5)]
sum(is.na(data_cast))
data <- data_cast
# Random sampling
samplesize = 0.60 * nrow(data)
set.seed(80)
index = sample( seq_len ( nrow ( data ) ), size = samplesize )
# Create training and test set
datatrain = data[ index, ]
datatest = data[ -index, ]



