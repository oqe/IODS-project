# Oskari Timonen
# 2021-11-14
# IODS-project chapter 2 - RStudio Exercise 2: Data Wrangling
## Data source : http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt
## Meta: https://www.mv.helsinki.fi/home/kvehkala/JYTmooc/JYTOPKYS3-meta.txt
## http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS2-meta.txt

# Data wrangling
#################

######
# 2. #
######

# Read data to variable
lrn14 <- read.table(
  file = "http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", 
  sep = "\t", 
  header = TRUE)

# Check data visually as a table in RStudio
View(lrn14)
## NOTE! RStudio may show limited amount of columns etc.
##    as described under this window

# Check structure
str(lrn14)
# what type of data object "df" is
# how many rows (obs. = observations) 183
# how many columns / variables we have 60
# column / variable name, type of values, first few values

# Check summaries
summary(lrn14)
# for every variable smallest value (if numeric) min., 1st quarter, Median, Mean, 3rd Quarter, Max value

#install.packages("tidyverse")
library(tidyverse)
glimpse(lrn14)
# pretty much same as str() slightly different form

######
# 3. #
######
# Create an analysis dataset with the variables 
## gender, age, attitude, deep, stra, surf and points by combining questions
## in the learning2014 data, as defined in the datacamp exercises and also on
## the bottom part of the following page (only the top part of the page is in Finnish). 
## http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS2-meta.txt. 
## Scale all combination variables to the original scales (by taking the mean). 
## Exclude observations where the exam points variable is zero. 
## (The data should then have 166 observations and 7 variables) 

# NOTE! It is unclear whether to include original "Attitude" variable or scaled (divided by 10) as in DataCamp exercises

# questions related to deep, surface and strategic learning
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

# select the columns related to deep learning and create column 'deep' by averaging
deep_columns <- select(lrn14, one_of(deep_questions))
lrn14$deep <- rowMeans(deep_columns)

# select the columns related to surface learning and create column 'surf' by averaging
surface_columns <- select(lrn14, one_of(surface_questions))
lrn14$surf <- rowMeans(surface_columns)

# select the columns related to strategic learning and create column 'stra' by averaging
strategic_columns <- select(lrn14, one_of(strategic_questions))
lrn14$stra <- rowMeans(strategic_columns)

# library(dplyr)
## ^ dplyr is already loaded by tidyverse
# select rows where points is greater than zero
lrn14 <- filter(lrn14, Points > 0)

# choose a handful of columns to keep
keep_columns <- c("gender","Age","Attitude", "deep", "stra", "surf", "Points")

# select the 'keep_columns' to create a new dataset
learning2014 <- select(lrn14, one_of(keep_columns))

# check column names
colnames(learning2014)

# change column names
colnames(learning2014)[1:3] <- c("gender", "age", "attitude")
colnames(learning2014)[7] <- c("points")

# check column names
colnames(learning2014)

# see the stucture of the new dataset
str(learning2014)

# 166 obs. of 7 variables, OK

######
# 4. #
######

# Set working directory in RStudio
## From right side in Files tab, 
## click data folder so you are in data folder (IODS-project/data), 
## click "More" (from Files tab), choose "Set As Working directory"
## check working directory
getwd()

# check data before writing to file
head(learning2014)

# save data to file
?write.csv()

write.table(
  learning2014,
  file = "learning2014.txt",
  sep = "\t")


# read saved file to check it
check_lrn14 <- read.table(file = "learning2014.txt", sep = "\t", header = TRUE)
head(check_lrn14)
str(check_lrn14)
