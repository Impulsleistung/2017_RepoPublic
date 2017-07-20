# Load the readxl and gdata package
library(readxl)
library(gdata)

# Specification of url: url_xls
url_xls <- "http://s3.amazonaws.com/assets.datacamp.com/production/course_1478/datasets/latitude.xls"

# Import the .xls file with gdata: excel_gdata
excel_gdata<-read.xls(xls = url_xls)

# Download file behind URL, name it local_latitude.xls
download.file(url = url_xls,"local_latitude.xls")

# Import the local .xls file with readxl: excel_readxl
excel_readxl<-read_excel(path = "local_latitude.xls")

###########################

# https URL to the wine RData file.
url_rdata <- "https://s3.amazonaws.com/assets.datacamp.com/production/course_1478/datasets/wine.RData"

# Download the wine file to your working directory
download.file(url_rdata,"wine_local.RData")

# Load the wine data into your workspace using load()
load("wine_local.RData")

# Print out the summary of the wine data
summary(wine)

###########################

# Load the httr package
library(httr)

# Get the url, save response to resp
url <- "http://www.example.com/"
resp<-GET(url)

# Print resp
resp

# Get the raw content of resp: raw_content
raw_content<-content(resp,as = "raw")

# Print the head of raw_content
head(raw_content)

###########################

# httr is already loaded

# Get the url
url <- "http://www.omdbapi.com/?apikey=ff21610b&t=Annie+Hall&y=&plot=short&r=json"
resp<-GET(url)

# Print resp
resp

# Print content of resp as text
content(x = resp,as = "text")

# Print content of resp
content(resp)

###########################

# Load the jsonlite package
library(jsonlite)

# wine_json is a JSON
wine_json <- '{"name":"Chateau Migraine", "year":1997, "alcohol_pct":12.4, "color":"red", "awarded":false}'

# Convert wine_json into a list: wine
wine<-fromJSON(wine_json)

# Print structure of wine
str(wine)

###########################

# jsonlite is preloaded

# Definition of quandl_url
quandl_url <- "http://www.quandl.com/api/v1/datasets/IWS/INTERNET_INDIA.json?auth_token=i83asDsiWUUyfoypkgMz"

# Import Quandl data: quandl_data
quandl_data<-fromJSON(quandl_url)

# Print structure of quandl_data
str(quandl_data)

###########################

# The package jsonlite is already loaded

# Definition of the URLs
url_sw4 <- "http://www.omdbapi.com/?apikey=ff21610b&i=tt0076759&r=json"
url_sw3 <- "http://www.omdbapi.com/?apikey=ff21610b&i=tt0121766&r=json"

# Import two URLs with fromJSON(): sw4 and sw3
sw4 <- fromJSON(url_sw4)
sw3 <- fromJSON(url_sw3)

# Print out the Title element of both lists
sw4$Title
sw3$Title

# Is the release year of sw4 later than sw3?
as.numeric(sw4$Year)>as.numeric(sw3$Year)

###########################

# jsonlite is already loaded

# Challenge 1
json1 <- '[[1, 2], [3, 4]]'
fromJSON(json1)

# Challenge 2
json2 <- '[{"a": 1, "b": 2}, {"a": 3, "b": 4},{"a": 5, "b": 6}]'
fromJSON(json2)

###########################

# jsonlite is already loaded

# URL pointing to the .csv file
url_csv <- "http://s3.amazonaws.com/assets.datacamp.com/production/course_1478/datasets/water.csv"

# Import the .csv file located at url_csv
water<-read.csv(url_csv, stringsAsFactors=FALSE)

# Convert the data file according to the requirements
water_json<-toJSON(water)

# Print out water_json
water_json

###########################

# Array of primitives 	["Amsterdam", "Rotterdam", "Utrecht", "Den Haag"] 	Atomic Vector 	simplifyVector
# Array of objects 	[{"name":"Erik", "age":43}, {"name":"Anna", "age":32}] 	Data Frame 	simplifyDataFrame
# Array of arrays 	[ [1, 2, 3], [4, 5, 6] ] 	Matrix 	simplifyMatrix

###########################

# Load the haven package
library("haven")

# Import sales.sas7bdat: sales
sales<-read_sas(data_file = "sales.sas7bdat")

# Display the structure of sales
str(sales)

###########################

# haven is already loaded

# Import the data from the URL: sugar
sugar<-read_dta(file = "http://assets.datacamp.com/production/course_1478/datasets/trade.dta")

# Structure of sugar
str(sugar)

# Convert values in Date column to dates
sugar$Date<-as.Date(as_factor(sugar$Date))

# Structure of sugar again
str(sugar)

###########################

# haven is already loaded

# Import person.sav: traits
traits<-read_sav(file = "person.sav")

# Summarize traits
summary(traits)

# Print out a subset
subset(x = traits, Agreeableness>40 & Extroversion>40)

###########################

# haven is already loaded

# Import SPSS data from the URL: work
work<-read_sav(file = "http://s3.amazonaws.com/assets.datacamp.com/production/course_1478/datasets/employee.sav")

# Display summary of work$GENDER
summary(work$GENDER)


# Convert work$GENDER to a factor
work$GENDER<-as_factor(work$GENDER)


# Display summary of work$GENDER again
summary(work$GENDER)

###########################

# foreign is already loaded

# Specify the file path using file.path(): path
path<-file.path("worldbank","edequality.dta")

# Create and print structure of edu_equal_1
edu_equal_1<-read.dta(file = path)
str(edu_equal_1)

# Create and print structure of edu_equal_2
edu_equal_2<-read.dta(file = path,convert.factors = FALSE)
str(edu_equal_2)

# Create and print structure of edu_equal_3
edu_equal_3<-read.dta(file = path,convert.underscore = TRUE)
str(edu_equal_3)

###########################

# foreign is already loaded

# Import international.sav as a data frame: demo
demo<-read.spss("international.sav",to.data.frame = TRUE)

# Create boxplot of gdp variable of demo
boxplot(demo$gdp)

###########################

# gather() 
# - generates key-value-pairs 
# - converts wide tables into long ones
# Syntax: gather(wide_df, my_key, my_val, -col)
# Apply gather() to bmi and save the result as bmi_long
bmi_long <- gather(bmi, year, bmi_val, -Country)

# View the first 20 rows of the result
head(bmi_long,n = 20)

###########################

# spred()
# - converts key-value-pairs into multiple cols
# - long tables become wide
# Syntax: spread(long_df, my_key, my_val)

# Apply spread() to bmi_long
bmi_wide <- spread(bmi_long, year, bmi_val)

# View the head of bmi_wide
head(bmi_wide)

###########################

head(treatments,n = 3)
  # patient treatment year_mo response
# 1       X         A 2010-10        1
# 2       Y         A 2010-10        4
# 3       X         B 2012-08        2

separate(treatments, year_mo, c("year", "month"))
  # patient treatment year month response
# 1       X         A 2010    10        1
# 2       Y         A 2010    10        4
# 3       X         B 2012    08        2

# Apply separate() to bmi_cc
bmi_cc_clean <- separate(bmi_cc, col = Country_ISO, into = c("Country", "ISO"), sep = "/")

# Print the head of the result
head(bmi_cc_clean)

###########################

head(treatments)
  # patient treatment year month response
# 1       X         A 2010    10        1
# 2       Y         A 2010    10        4
# 3       X         B 2012    08        2

unite(treatments, year_mo, year, month)
  # patient treatment year_mo response
# 1       X         A 2010_10        1
# 2       Y         A 2010_10        4
# 3       X         B 2012_08        2

# Apply unite() to bmi_cc_clean
bmi_cc <- unite(bmi_cc_clean, Country_ISO, Country, ISO, sep = "-")

# View the head of the result
head(bmi_cc)

###########################

# the arrange() function sorts data.frame according column

head(census2)
  # YEAR month amount
# 1 1992   JAN 146913
# 2 1993   JAN 157525
# 3 1994   JAN 167504

census2 <- arrange(census2, YEAR)
head(census2)
  # YEAR month amount
# 1 1992   JAN 146913
# 2 1992   FEB 147270
# 3 1992   MAR 146831

###########################

  # YEAR month type amount
# 1 1992   JAN  MED 146913
# 2 1992   FEB  MED 147270
# 3 1992   MAR  MED 146831
# 4 1992   APR  MED 148082
# 5 1992   MAY  MED 149015
# 6 1992   JUN  MED 149821

# spread() resolves the values in a colum into variable names
census_long2 <- spread(census_long,key = type,value = amount)
# head(census_long2)
  # YEAR month     HIGH      LOW    MED
# 1 1992   APR 157623.9 146174.1 148082
# 2 1992   AUG 152280.8 149368.9 151064
# 3 1992   DEC 162142.4 146701.6 155504
# 4 1992   FEB 150315.3 139097.8 147270
# 5 1992   JAN 148180.5 138283.1 146913
# 6 1992   JUL 160292.5 145347.8 150809 

###########################

# Preview students2 with str()
str(students2)

# Load the lubridate package
library(lubridate)

# Parse as date
dmy("17 Sep 2015") 

# Parse as date and time (with no seconds!)
mdy_hm("July 15, 2012 12:56") 

# Coerce dob to a date (with no time)
students2$dob <- ymd(students2$dob)

# Coerce nurse_visit to a date and time
students2$nurse_visit <- ymd_hms(students2$nurse_visit)
    
# Look at students2 once more with str()
str(students2)

###########################

# Load the stringr package
library(stringr)

# Trim all leading and trailing whitespace
str_trim( c("   Filip ", "Nick  ", " Jonathan") )

# Pad these strings with leading zeros
str_pad( c("23485W", "8823453Q", "994Z"), width=9, side="left", pad=0)

###########################

## stringr has been loaded for you

# Look at the head of students2
head(students2)

# Detect all dates of birth (dob) in 1997
str_detect(students2$dob,"1997")

# In the sex column, replace "F" with "Female"...
students2$sex <- str_replace( students2$sex,"F","Female")

# ...And "M" with "Male"
students2$sex <- str_replace( students2$sex,"M","Male")

# View the head of students2
head(students2)

###########################

## The stringr package is preloaded

# Replace all empty strings in status with NA
social_df$status[social_df$status == ""] <- NA

# Print social_df to the console
social_df

# Use complete.cases() to see which rows have no missing values
complete.cases(social_df)

# Use na.omit() to remove all rows with any missing values
na.omit(social_df)

###########################

# gather() - Key, Value - Multiple columns
head(weather)
  # X year month           measure X1 X2 X3 X4 X5 X6 X7 X8 X9 X10 X11 X12 X13 X14
# 1 1 2014    12  Max.TemperatureF 64 42 51 43 42 45 38 29 49  48  39  39  42  45
# 2 2 2014    12 Mean.TemperatureF 52 38 44 37 34 42 30 24 39  43  36  35  37  39
# 3 3 2014    12  Min.TemperatureF 39 33 37 30 26 38 21 18 29  38  32  31  32  33
# 4 4 2014    12    Max.Dew.PointF 46 40 49 24 37 45 36 28 49  45  37  28  28  29
# 5 5 2014    12    MeanDew.PointF 40 27 42 21 25 40 20 16 41  39  31  27  26  27
# 6 6 2014    12     Min.DewpointF 26 17 24 13 12 36 -3  3 28  37  27  25  24  25
  # X15 X16 X17 X18 X19 X20 X21 X22 X23 X24 X25 X26 X27 X28 X29 X30 X31
# 1  42  44  49  44  37  36  36  44  47  46  59  50  52  52  41  30  30
# 2  37  40  45  40  33  32  33  39  45  44  52  44  45  46  36  26  25
# 3  32  35  41  36  29  27  30  33  42  41  44  37  38  40  30  22  20
# 4  33  42  46  34  25  30  30  39  45  46  58  31  34  42  26  10   8
# 5  29  36  41  30  22  24  27  34  42  44  43  29  31  35  20   4   5
# 6  27  30  32  26  20  20  25  25  37  41  29  28  29  27  10  -6   1

# Load the tidyr package
library(tidyr)

# Gather the columns
# The key indicates the column name, the value is the focused measurement data
weather2 <- gather(weather, day, value, X1:X31, na.rm = TRUE)

head(weather2)
  # X year month           measure day value
# 1 1 2014    12  Max.TemperatureF  X1    64
# 2 2 2014    12 Mean.TemperatureF  X1    52
# 3 3 2014    12  Min.TemperatureF  X1    39
# 4 4 2014    12    Max.Dew.PointF  X1    46
# 5 5 2014    12    MeanDew.PointF  X1    40
# 6 6 2014    12     Min.DewpointF  X1    26

###########################

# Count missing values
sum(is.na(weather6))

# Find missing values
summary(weather6)

# Find indices of NAs in Max.Gust.SpeedMPH
ind <- which(is.na(weather6$Max.Gust.SpeedMPH ))

# Look at the full rows for records missing Max.Gust.SpeedMPH
weather6[ind, ]

###########################

# Review distributions for all variables
summary(weather6)

# Find row with Max.Humidity of 1000
ind <- which(weather6$Max.Humidity == 1000)

# Look at the data for that day
weather6[ind, ]

# Change 1000 to 100
weather6$Max.Humidity[ind] <- 100

###########################

# Clean up column names
names(weather6) <- new_colnames

# Replace empty cells in events column
weather6$events[weather6$events == ""] <- "None"
    
# Print the first 6 rows of weather6
head(weather6)

###########################

