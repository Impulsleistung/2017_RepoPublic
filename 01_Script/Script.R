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

# Subsetting data with brackets
# Also, recall that you can use square brackets to subset a data frame as follows:

my_df[1:5, ] # First 5 rows of my_df
my_df[, 4]   # Fourth column of my_df

# Alternatively, you can remove rows and columns using negative indices. For example:

my_df[-(1:5), ] # Omit first 5 rows of my_df
my_df[, -4]     # Omit fourth column of my_df

###########################

## sales5 is pre-loaded
# convert all columns with dates to Date by using lubridate

# Load stringr
library(stringr)

# Find columns of sales5 containing "dt": date_cols
date_cols<-str_detect( names(sales5), "dt")

# Load lubridate
library(lubridate)

# Coerce date columns into Date objects
sales5[, date_cols] <- lapply(sales5[,date_cols] , ymd)

###########################

# Remove rows 1, 7, and 11 of mbta: mbta2
mbta2<-mbta[-c(1,7,11),]

# Remove the first column of mbta2: mbta3
mbta3<-mbta2[,-1]

###########################

# Pre-Analysis of big DataSet
# Load dplyr
library(dplyr)

# View a glimpse of food
glimpse(food)

# View column names of food
names(food)

###########################

# Two ways of applying a function to a subset of data
# Change columns to numeric using dplyr (don't change)
library(dplyr)
example <- mutate_each(att5, funs(as.numeric), -state)

# Define vector containing numerical columns: cols
cols<-c(2:5)

# Use sapply to coerce cols to numeric
att5[, cols] <- sapply(att5[, cols],as.numeric)

###########################

# Create a list n containing the values: 5, 10, and 20
n<-list(5,10,20)

# Call map() on n with rnorm() to simulate three samples
map(.x = n,.f = rnorm)

###########################



# Passing two lists into a function with two parameters, this looks a little unsafe...
# rnorm(n, mean = 0, sd = 1)

# Initialize n
n <- list(5, 10, 20)

# Create a list mu containing the values: 1, 5, and 10
mu<-list(1,5,10)

# Edit to call map2() on n and mu with rnorm() to simulate three samples
map2(.x = n,.y = mu,.f = rnorm)

###########################

# Putting more than two arguments into a function requires pmap()
# The list must match the order of the target function
# Initialize n and mu
n <- list(5, 10, 20)
mu <- list(1, 5, 10)

# Create a sd list with the values: 0.1, 1 and 0.1
sd <- list(0.1,1,0.1)

# Edit this call to pmap() to iterate over the sd list as well
pmap(list(n, mu, sd), rnorm)

###########################

# That's the safe variant of using pmap. Don't use "" for the function arguments
# Name the elements of the argument list
pmap(list(mean = mu, n = n, sd = sd), rnorm)

###########################

# Calling a list of functions with a list of parameters in one line
# Define list of functions
f <- list("rnorm", "runif", "rexp")

# Parameter list for rnorm()
rnorm_params <- list(mean = 10)

# Add a min element with value 0 and max element with value 5
runif_params <- list(min = 0, max = 5)

# Add a rate element with value 5
rexp_params <- list(rate = 5)

# Define params for each function
params <- list(
  rnorm_params,
  runif_params,
  rexp_params
)

# Call invoke_map() on f supplying params as the second argument
# Since every function has the "n" parameter, it is defined in a common way
invoke_map(.f = f, .x = params, n = 5)

###########################

# walk() operates just like map() except it's designed for functions that don't return anything.
# You use walk() for functions with side effects like printing, plotting or saving.
# Define list of functions
f <- list(Normal = "rnorm", Uniform = "runif", Exp = "rexp")

# Define params
params <- list(
  Normal = list(mean = 10),
  Uniform = list(min = 0, max = 5),
  Exp = list(rate = 5)
)

# Assign the simulated samples to sims
sims<-invoke_map(f, params, n = 50)

# Use walk() to make a histogram of each element in sims
walk(sims, hist)

str(sims)
# List of 3
#  $ Normal : num [1:50] 9.14 11.15 12.2 11.65 9.19 ...
#  $ Uniform: num [1:50] 2.39 1.02 1.29 3.99 2.03 ...
#  $ Exp    : num [1:50] 0.203 0.805 0.771 0.103 0.27 ...

###########################

# Safe iteration, using a for-loop to iterate over colums
# Replace the 1:ncol(df) sequence
for (i in seq_along(df)) {
  print(median(df[[i]]))
}

# Change the value of df
df<- data.frame(NULL)

# Repeat for loop to verify there is no error
# Replace the 1:ncol(df) sequence
for (i in seq_along(df)) {
  print(median(df[[i]]))
}

##########

# Fast and save iteration by memory pre-allocation
# [[ - Brackets for generalisation
# Create new double vector: output
output<-vector(mode = "double", length = ncol(df))

# Alter the loop
for (i in seq_along(df)) {
  # Change code to store result in output
  output[[i]]<-median(df[[i]])
}

# Print output
output

#########

# Normalize a vector using range()
# Define example vector x
x <- 1:10

# Define rng
rng<-range(x,na.rm = TRUE)

# Rewrite this snippet to refer to the elements of rng
(x - rng[1]) /  (rng[2] - rng[1])

############

# Calculating the confidence interval and catch errors
# Alter the mean_ci function
mean_ci <- function(x, level = 0.95) {
  if(length(x)==0) {
    warning("'x' was empty",call. = FALSE)
    return(c(-Inf,Inf)  )
  }
  se <- sd(x) / sqrt(length(x))
  alpha <- 1 - level
  mean(x) + se * qnorm(c(alpha / 2, 1 - alpha / 2))
}

#############

# Create col_mean() function to find column means
col_mean <- function(df) {
  output <- numeric(length(df))
  for (i in seq_along(df)) {
    output[[i]] <- mean(df[[i]])
  }
  output
}

#############

# All the map functions in purrr take a vector, .x, as the first argument, then return .f applied to each element of # .x. The type of object that is returned is determined by function suffix (the part after _):
# map() returns a list or data frame
# map_lgl() returns a logical vector
# map_int() returns a integer vector
# map_dbl() returns a double vector
# map_chr() returns a character vector

# Load the purrr package
library(purrr)

# Use map_dbl() to find column means
map_dbl(.x = df, .f = mean)

# Use map_dbl() to column medians
map_dbl(.x = df, .f = median)

# Use map_dbl() to find column standard deviations
map_dbl(.x = df, .f = sd)

#############

# Find the mean of each column
map_dbl(planes,mean)

# Find the mean of each column, excluding missing values
map_dbl(.x = planes, .f = mean, na.rm=TRUE)

# Find the 5th percentile of each column, excluding missing values
map_dbl(.x = planes, .f = quantile,  probs = 0.05, na.rm=TRUE)

#############

# Functions on columns by using the map() - function
# Find the columns that are numeric
map_lgl(df3,is.numeric)

# Find the type of each column
map_chr(df3, typeof)

# Find a summary of each column
map(df3,summary)

#############

# Anonymous function for linear regression
# Rewrite to call an anonymous function
map(cyl, function(df) lm(mpg ~ wt, data = df))

## The short form by purrr - package is:
map(cyl, ~ lm(.$mpg ~ .$wt))

## Example
# One way to do this would be to use an anonymous function:
map_dbl(cyl, function(df) mean(df$disp))

# To perform the same operation using the formula shortcut, we replace the function definition (function(df)) with the ~, then when we need to refer to the element of cyl the function operates on (in this case df), we use a ..

map_dbl(cyl, ~ mean(.$disp))

#############

# Extract the second element from each vector in coefs using the numeric shortcut and map_dbl()
coefs <- map(models, coef)

# use map_dbl with the numeric shortcut to pull out the second element
map_dbl(coefs,2)

#############

# Pipes in R %>%, the data input for the next function is automatically connected
# Take a look at our code to get our list of models:

cyl <- split(mtcars, mtcars$cyl) 
map(cyl, ~ lm(mpg ~ wt, data = .))

# We split the data frame mtcars and save it as the variable cyl. We then pass cyl as the first argument to map to fit the models. We could rewrite this using the pipe operator as:

split(mtcars, mtcars$cyl) %>% 
  map(~ lm(mpg ~ wt, data = .))

# Define models (don't change)
models <- mtcars %>% 
  split(mtcars$cyl) %>%
  map(~ lm(mpg ~ wt, data = .))

# Rewrite to be a single command using pipes 
# Single variables can also be piped
models %>%
  map(summary) %>%
  map_dbl("r.squared")
  
#############

# Try...catch by using safe() override
# Create safe_readLines() by passing readLines() to safely()
safe_readLines<-safely(readLines)

# Call safe_readLines() on "http://example.org"
safe_readLines("http://example.org")

# Call safe_readLines() on 
safe_readLines("http://asdfasdasdkfjlda")

# Define safe_readLines()
safe_readLines <- safely(readLines)

# Use the safe_readLines() function with map(): html
html<-map(urls,safe_readLines)

# Call str() on html
str(html)

# Extract the result from one of the successful elements
html[[1]]

# Extract the error from the element that was unsuccessful
html[[3]]

#############

# Inverting lists of pair into one pair of lists by transpose()

str(html)
# List of 3
 # $ example:List of 2
  # ..$ result: chr [1:50] "<!doctype html>" "<html>" "<head>" "    <title>Example Domain</title>" ...
  # ..$ error : NULL
 # $ rproj  :List of 2
  # ..$ result: chr [1:121] "<!DOCTYPE html>" "<html lang=\"en\">" "  <head>" "    <meta charset=\"utf-8\">" ...
  # ..$ error : NULL
 # $ asdf   :List of 2
  # ..$ result: NULL
  # ..$ error :List of 2
  # .. ..$ message: chr "cannot open the connection to 'http://asdfasdasdkfjlda'"
  # .. ..$ call   : language file(con, "r")
  # .. ..- attr(*, "class")= chr [1:3] "simpleError" "error" "condition"

str(transpose(html))
# List of 2
 # $ result:List of 3
  # ..$ example: chr [1:50] "<!doctype html>" "<html>" "<head>" "    <title>Example Domain</title>" ...
  # ..$ rproj  : chr [1:121] "<!DOCTYPE html>" "<html lang=\"en\">" "  <head>" "    <meta charset=\"utf-8\">" ...
  # ..$ asdf   : NULL
 # $ error :List of 3
  # ..$ example: NULL
  # ..$ rproj  : NULL
  # ..$ asdf   :List of 2
  # .. ..$ message: chr "cannot open the connection to 'http://asdfasdasdkfjlda'"
  # .. ..$ call   : language file(con, "r")
  # .. ..- attr(*, "class")= chr [1:3] "simpleError" "error" "condition"
  
# Define save_readLines() and html
safe_readLines <- safely(readLines)
html <- map(urls, safe_readLines)

# The safely() function generates a list with "result" and "error" for each request on each element that was requested
# Examine the structure of transpose(html)
str(transpose(html))

# Extract the results: res
res  <-transpose(html)[["result"]]

# Extract the errors: errs
errs <-transpose(html)[["error"]]

#############

# These two should be used on the result of safely()
res <- transpose(XXXX)[["result"]]
errs <- transpose(XXXX)[["error"]]

#############

# Handle results of safely()
# Initialize some objects
safe_readLines <- safely(readLines)
html <- map(urls, safe_readLines)
res <- transpose(html)[["result"]]
errs <- transpose(html)[["error"]]

# Create a logical vector is_ok
is_ok<-map_lgl(errs, is.null)

# Extract the successful results
res[is_ok]

# Extract the input from the unsuccessful results
urls[!is_ok]

#############

# Using walk2 - Walk is an alternative to map that you use when you want to call a function for its side effects
# Replace "Sturges" with reasonable breaks for each sample
breaks_list <- list(
  Normal = seq(6, 16, 0.5),
  Uniform = seq(0, 5, 0.25),
  Exp = seq(0, 1.5, 0.1)
)

# Use walk2() to make histograms with the right breaks
# Definition: walk2(.x, .y, .f, ...)
# Definition: hist(x, ...) # Default S3 method: hist(x, breaks = "Sturges", ... )
walk2(.x = sims, .y = breaks_list, .f = hist)


#############

# Increase sample size to 1000
sims <- invoke_map(f, params, n = 1000)

# Compute nice_breaks (don't change this)
nice_breaks <- map(sims, find_breaks)

# Create a vector nice_titles
nice_titles<-c("Normal(10, 1)", "Uniform(0, 5)", "Exp(5)")

# Use pwalk() instead of walk2()
pwalk(.l =  list(x=sims, breaks=nice_breaks,main=nice_titles), .f = hist, xlab="")

str(f)
# List of 3
 # $ Normal : chr "rnorm"
 # $ Uniform: chr "runif"
 # $ Exp    : chr "rexp"
 
> str(params)
# List of 3
 # $ Normal :List of 1
  # ..$ mean: num 10
 # $ Uniform:List of 2
  # ..$ min: num 0
  # ..$ max: num 5
 # $ Exp    :List of 1
  # ..$ rate: num 5
  
#############

# One of the nice things about the walk() functions is that they return the object you passed to them. This means they can easily be used in pipelines (a pipeline is just a short way of saying "a statement with lots of pipes").

# Pipe this along to map(), using summary() as .f
sims %>%
  walk(hist) %>%
  map(summary)
  
str(sims)
# List of 3
 # $ Normal : num [1:50] 9.17 9.39 11.01 9.79 9.07 ...
 # $ Uniform: num [1:50] 4.28 1.741 4.32 0.361 3.628 ...
 # $ Exp    : num [1:50] 0.11546 0.0546 0.00364 0.43626 0.11729 ...

#############
 
# HowTo halt on unplausible inputs
# Define troublesome x and y
x <- c(NA, NA, NA)
y <- c( 1, NA, NA, NA)

both_na <- function(x, y) {
  # Add stopifnot() to check length of x and y
  stopifnot(length(x)==length(y))
  
  sum(is.na(x) & is.na(y))
}

# Call both_na() on x and y
both_na(x, y)

#############

# HowTo throw an error in the correct way
# Define troublesome x and y
x <- c(NA, NA, NA)
y <- c( 1, NA, NA, NA)

both_na <- function(x, y) {
  # Replace condition with logical
  if (length(x)!=length(y)) {
    # Replace "Error" with better message
    stop("x and y must have the same length", call. = FALSE)
  }  
  
  sum(is.na(x) & is.na(y))
}

# Call both_na() 
both_na(x, y)

#############