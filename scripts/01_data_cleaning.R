install.packages("readr")
install.packages("dplyr")
library(readr)   # for reading CSV files
library(dplyr)   # for data manipulation

#setting working directory
setwd("C:/Users/yasha/OneDrive/Desktop/Air-Pollution-Disease-Analysis")

#loading the dataset
data <- read_csv("data/raw/pollution_us_2000_2016.csv")

#Quick look at the dataset
head(data)      #shows first 6 rows
str(data)       #Structure: types, columns
summary(data)   #Summary stats for numeric columns

#Data Cleaning
#checking for missing values
cat("Checking for mising values for each column: \n")
print(colSums(is.na(data)))

#Drop columns with too many missing values
#SO2 AQI and CO AQI have over 50% missing values
data <- data %>% select(-c('SO2 AQI', 'CO AQI'))
cat("\nDropped 'SO2 SQI and CO AQI. Remaining columns: \n")
print(colnames(data))

#Check for duplicates
num_duplicates <- sum(duplicated(data))
cat("\nNumber of duplicate rows:", num_duplicates, "\n")
if(num_duplicates >0){
  data <- data %>% distinct()
  cat("Duplicates removed. Total rows now:", nrow(data), "\n")
}

#Check data types
cat("\nData structure after cleaning:\n")
str(data)

#save the cleaned dataset 
write.csv(data, "data/cleaned_pollution.csv", row.names = FALSE)
cat("\nCleaned dataset saved as 'data/cleaned_pollution.csv'\n")