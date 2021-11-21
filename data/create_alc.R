# Oskari Timonen
# 2021-11-21
# Introduction to Open Data Science 2021 - RStudio Exercise 3: Data Wrangling

######
# 3. #
############

# student-mat.csv and student-por.csv saved an unzipped to IODS-project/data folder
# Set working directory
setwd("data")
# check working directory
getwd()

# Read student-por.csv and student-mat.csv file
por <- read.csv(file = "student-por.csv", header = TRUE)
mat <- read.csv(file = "student-mat.csv", header = TRUE)

# check files are read corretly
head(por)
head(mat)

# Nope... try again
por <- read.csv(file = "student-por.csv", header = TRUE, sep = ";")
head(por)
mat <- read.csv(file = "student-mat.csv", header = TRUE, sep = ";")
head(mat)
# OK

# Explore dimensions and structure
dim(por)
dim(mat)

str(por)
str(mat)

######
# 4. #
############

# load dplyr library
library(dplyr)

cols_por <- colnames(por)
cols_mat <- colnames(mat)

# column set not to be included
col_set_without <- c("failures", "paid", "absences", "G1", "G2", "G3")
# negate col_set_without values from column names and save list of column names
# ...to col_set_with
col_set_with <- cols_por[-which(cols_por %in% col_set_without)]
# check
col_set_with

####################
# taking a look at:
# https://raw.githubusercontent.com/rsund/IODS-project/master/data/create_alc.R

# what in the!? the task instruction in this is just atrocious
###################

mat_por <-  inner_join(mat, por, by = col_set_with, suffix = c(".mat", ".por"))

str(mat_por)

######
# 5. #
##############

#alc <- select(mat_por, one_of(col_set_with))
alc <- mat_por

# for every column name not used for joining...
for(column_name in col_set_without) {
  # select two columns from 'math_por' with the same original name
  two_columns <- select(mat_por, starts_with(column_name))
  # select the first column vector of those two columns
  first_column <- select(two_columns, 1)[[1]]
  
  # if that first column vector is numeric...
  if(is.numeric(first_column)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[column_name] <- round(rowMeans(two_columns))
  } else { # else if it's not numeric...
    # add the first column vector to the alc data frame
    alc[column_name] <- first_column
  }
}

######
# 6. #
######

alc[, "alc_use"] <- (alc$Dalc + alc$Walc) / 2
alc[, "high_use"] <- alc$alc_use > 2

head(alc)

######
# 7. #
######

glimpse(alc)
# I don't know if this is any good
# ..let's compare alc and dataset from analysis
alc2 <- read.csv("https://github.com/rsund/IODS-project/raw/master/data/alc.csv", header = TRUE, sep = ",")

setequal(alc, alc2)
# not identifcal
glimpse(alc2)
# what colnames are unique in alc
setdiff(colnames(alc), colnames(alc2))
# what colnames are unique in alc2
setdiff(colnames(alc2), colnames(alc))
# okay so n, id.p, id.m and cid are actually the what's extra variables in alc2
# meh...

write.csv(alc, file = "ex3_alc_data-wrangling.csv")
#View(read.csv(file = "ex3_alc_data-wrangling.csv"))
