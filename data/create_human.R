# Oskari Timonen
# 2021-11-29
# Introduction to Open Data Science 2021 - RStudio Exercise 4: Data Wrangling

library(dplyr)

setwd("data")
# check working directory
getwd()


# 2. Read the “Human development” and “Gender inequality” datas into R. Here are the links to the datasets: 

hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

# 3. Explore the datasets: see the structure and dimensions of the data. Create summaries of the variables.

str(hd)
str(gii)

summary(hd)
summary(gii)

# Column Gross.National.Income..GNI..per.Capita should probably be changed to numeric

# 4.

# Maternal mortality ratio (MMR), 
# Adolescent birth rate (ABR), 
# Share of parliamentary seats held by each sex (PR)
# Attaiment at secondary and higher education (SE) levels:
# Labour market participation rate (LFPR)

names(hd) <- c("HDIrank", "Country", "HDI", "LEaB", "Exp_edu", "Mean_edu", "GNIpc", "GNIpc_rm_HDIrank")
names(gii) <- c("GIIrank", "Country", "GII", "MMR", "ABR", "PR", "SE_f", "SE_m", "LFPR_f", "LFPR_m")

# 5. 

gii <- gii %>%
  mutate(rat_f2m_SE = SE_f/SE_m)

gii <- gii %>%
  mutate(rat_f2m_LFPR = LFPR_f/LFPR_m)

# 6.

human <- inner_join(x = hd, y = gii, by = "Country")
head(human)
str(human)

write.table(human, "human.tsv", sep = "\t", row.names = FALSE, col.names = TRUE)
# check
# hm2 <- read.table("human.tsv", sep = "\t", header = TRUE)
# head(hm2)
# str(hm2)
