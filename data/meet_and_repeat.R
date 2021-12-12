# Oskari Timonen
# 2021-12-12
# RStudio Exercise 6: Data wrangling

# 1. Load data
###############
## check their variable names, view the data contents and structures, and create some brief summaries of the variables

BPRS <- read.table(file = "https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", header = TRUE, sep = " ")
head(BPRS)

RATS <- read.table(file = "https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", header = TRUE, sep = "\t")
head(RATS)

## BPRS
names(BPRS)
str(BPRS)
summary(BPRS)

## RATS
names(RATS)
str(RATS)
summary(RATS)

# 2. Convert the categorical variables of both data sets to factors
####################################################################
library(dplyr)

## BPRS
BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)
# check
glimpse(BPRS)

## RATS
RATS$ID <- factor(RATS$ID)
RATS$Group <- factor(RATS$Group)
# check
glimpse(RATS)

# 3. Convert the data sets to long form. 
#########################################
## Add a week variable to BPRS and a Time variable to RATS.

## BPRS
BPRS_long <-  BPRS %>% 
  gather(key = weeks, value = bprs, -treatment, -subject) %>% 
  mutate(week = as.integer(substr(weeks, 5,6)))

head(BPRS_long)

## RATS
RATS_long <- RATS %>%
  gather(key = WD, value = Weight, -ID, -Group) %>%
  mutate(Time = as.integer(substr(WD, 3,5))) 

head(RATS_long)

# 4. Compare long with their wide form versions
################################################

## BPRS
glimpse(BPRS)
glimpse(BPRS_long)

# check with single subject
# easiest way for me to internalize long vs wide
subset(BPRS, subject == 1)
subset(BPRS_long, subject == 1)

## RATS
glimpse(RATS)
glimpse(RATS_long)

# check with single subject
# easiest way for me to internalize long vs wide
subset(RATS, ID == 1)
subset(RATS_long, ID == 1)

# Write data files
###################

# setwd("~/Kurssit/2021/IODS_introduction-to-open-data-science/IODS-project/data")

write.table(BPRS_long, file = "BPRS_long.tsv", row.names = FALSE, sep = "\t")
write.table(RATS_long, file = "RATS_long.tsv", row.names = FALSE, sep = "\t")

# check 
# head(read.table(file = "BPRS_long.tsv", sep = "\t", header = TRUE))
# head(read.table(file = "RATS_long.tsv", sep = "\t", header = TRUE))

