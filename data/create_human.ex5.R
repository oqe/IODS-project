# Oskari Timonen
# 2021-12-05
# RStudio Exercise 5: Data wrangling

##########################################################################
# 0. Load data and check structure & dimension, describe dataset briefly #
##########################################################################

human <- read.csv(file = "http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human1.txt",)
str(human)
names(human)

# Read: http://hdr.undp.org/sites/default/files/hdr2015_technical_notes.pdf
# "The  Gender  Inequality  Index  (GII)  ref lects  gender-based  
# disadvantage in three dimensions—reproductive health, 
# empowerment and the labour market—for as many countries 
# as data of reasonable quality allow. It shows the loss in potential 
# human development due to inequality between female and male 
# achievements in these dimensions. It ranges between 0, where 
# women and men fare equally, and 1, where one gender fares as 
# poorly as possible in all measured dimensions."

# "The Human Development Index (HDI) is a summary measure 
# of achievements in key dimensions of human development: a 
# long and healthy life, access to knowledge and a decent standard 
# of living. The HDI is the geometric mean of normalized indices 
# for each of the three dimensions. This technical note describes 
# the data sources for the HDI, steps to calculating the HDI and 
# the methodology used to estimate missing values."

# Variables:
#############
# "HDI.Rank" = rank between countries in HDI
# "HDI" = s a summary measure of achievements in key dimensions of human
#   development: a  long and healthy life, access to knowledge and a decent
#   standard  of living. The HDI is the geometric mean of normalized indices
#   for each of the three dimensions.
# "Edu.Mean" = Education  mean years of schooling
# 
# "GNI.Minus.Rank" = ?
# "GII.Rank" = rank between countries in GII
# "GII" = Gender Inequality Index
# 
# The following explanations from:
# https://raw.githubusercontent.com/TuomoNieminen/Helsinki-Open-Data-Science/master/datasets/human_meta.txt
# ##################################
# # The data combines several indicators from most countries in the world
# 
# "Country" = Country name
# 
# # Health and knowledge
# 
# "GNI" = Gross National Income per capita
# "Life.Exp" = Life expectancy at birth
# "Edu.Exp" = Expected years of schooling
# "Mat.Mor" = Maternal mortality ratio
# "Ado.Birth" = Adolescent birth rate
# 
# Empowerment
# 
# "Parli.F" = Percetange of female representatives in parliament
# "Edu2.F" = Proportion of females with at least secondary education
# "Edu2.M" = Proportion of males with at least secondary education
# "Labo.F" = Proportion of females in the labour force
# "Labo.M" " Proportion of males in the labour force
# 
# "Edu2.FM" = Edu2.F / Edu2.M
# "Labo.FM" = Labo2.F / Labo2.M

####################
# 1. Mutating data #
####################
library(tidyr)

# remove , from GNI and make it numeric
human <- mutate(human, GNI = as.numeric(gsub(",", "", GNI)))
# Check
str(human)

########################
# 2. Exclude variables #
########################

keep_columns <- c("Country", "Edu2.FM", "Labo.FM", "Edu.Exp", "Life.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F")
human <- select(human, one_of(keep_columns))
# check
str(human)

######################################
# 3. Remove rows with missing values #
######################################

complete.cases(human)

human <- filter(human, complete.cases(human))

############################################
# 4. Remove regions that are not countries #
############################################

#install.packages("countrycode")
#library(countrycode)

#list_of_countries <- codelist$country.name.en
#human$Country[which(human$Country %in% list_of_countries)]

human_tmp <- human[which(human$Country %in% list_of_countries),]
dim(human_tmp)
# TOO MANY REMOVED!
# check what "are not countries"
human$Country[-which(human$Country %in% list_of_countries)]

# Okay... well this is lame. Check Datacamp exercises...
tail(human, 10)
# ...so just remove last 7 entries from human datafram
last <- nrow(human) - 7

human <- human[1:last,]
# check
dim(human)

################################################
# 5. Country to rowname, remove Country column #
################################################

rownames(human) <- human$Country
human <- human[,-1]

dim(human) # OK!

# Save human
write.csv(human, file = "data/human.csv", row.names = TRUE)

# check
# tmp <- read.table("data/human.csv", sep = ",", header = TRUE, row.names = 1)
# head(tmp)
# str(tmp)
