# Type consistent return by using map
col_classes <- function(df) {
  # Assign list output to class_list
  class_list<-map(df, class)
  
  # Use map_chr() to extract first element in class_list
  map_chr(.x = class_list, 1)
}

# Check that our new function is type consistent
df %>% col_classes() %>% str()
df[3:4] %>% col_classes() %>% str()
df[1:2] %>% col_classes() %>% str()

##############################################

# Filter a column to a value
function(df, threshold) {
  dplyr::filter(df, x > threshold)
}

##############################################

# NSE functions need a pre-check on critical names
big_x <- function(df, threshold) {
  # Write a check for x not being in df
  if(!"x" %in% names(df)) {
    stop("df must contain variable called x", call. = FALSE)
  }

  # Write a check for threshold being in df
  if("threshold" %in% names(df)) {
    stop("df must not contain variable called threshold", call. = FALSE)
  }  
  
  dplyr::filter(df, x > threshold)
}

##############################################

# tibbles are more advanced than data frames, almost similar to glimpse, they
# can provide a nice view in the console
# Convert the hflights data.frame into a hflights tbl
hflights <- tbl_df(hflights)

# Display the hflights tbl
hflights

##############################################

# Use a LUT look-up-table

two <- c("AA", "AS")
lut <- c("AA" = "American", 
         "AS" = "Alaska", 
         "B6" = "JetBlue")
two <- lut[two]
two

##############################################

# Both the dplyr and hflights packages are loaded into workspace
lut <- c("AA" = "American", "AS" = "Alaska", "B6" = "JetBlue", "CO" = "Continental", 
         "DL" = "Delta", "OO" = "SkyWest", "UA" = "United", "US" = "US_Airways", 
         "WN" = "Southwest", "EV" = "Atlantic_Southeast", "F9" = "Frontier", 
         "FL" = "AirTran", "MQ" = "American_Eagle", "XE" = "ExpressJet", "YV" = "Mesa")

# Add the Carrier column to hflights
hflights$Carrier <- lut[hflights$UniqueCarrier]

# Glimpse at hflights
glimpse(hflights)

##############################################

# The lookup table
lut <- c("A" = "carrier", "B" = "weather", "C" = "FFA", "D" = "security", "E" = "not cancelled")

# Add the Code column
hflights$Code <- lut[hflights$CancellationCode]

# Glimpse at hflights
glimpse(hflights)

##############################################

# dplyr basics
# - select and mutate work on variables
# - filter and arrange work on observations
# - summarize works on groups

# The dplyr package contains five key data manipulation functions, also called verbs:
	# select(), which returns a subset of the columns,
	# filter(), that is able to return a subset of the rows,
	# arrange(), that reorders the rows according to single or multiple variables,
	# mutate(), used to add columns from existing data,
	# summarise(), which reduces each group to a single row by calculating aggregate measures.

# dplyr comes with a set of helper functions that can help you select groups of variables inside a select() call:
	# starts_with("X"): every name that starts with "X",
	# ends_with("X"): every name that ends with "X",
	# contains("X"): every name that contains "X",
	# matches("X"): every name that matches "X", where "X" can be a regular expression,
	# num_range("x", 1:5): the variables named x01, x02, x03, x04 and x05,
	# one_of(x): every name that appears in x, which should be a character vector.

##############################################
	
# mutate() even allows you to use a new variable while creating a next variable in the same call. In this example, the new variable x is directly reused to create the new variable y:
mutate(my_df, x = a + b, y = x + c)

# Add a second variable loss_ratio to the dataset: m1
m1 <- mutate(hflights, loss = ArrDelay - DepDelay, 
                loss_ratio = loss / DepDelay)

# Add the three variables as described in the third instruction: m2
m2 <- mutate(hflights, TotalTaxi = TaxiIn + TaxiOut,
                ActualGroundTime = ActualElapsedTime - AirTime,
                Diff = TotalTaxi - ActualGroundTime)
				
##############################################

# Using the filter() function
# All flights that traveled 3000 miles or more
filter(hflights, Distance > 3000)

# All flights flown by one of JetBlue, Southwest, or Delta
filter(hflights, UniqueCarrier %in% c("JetBlue", "Southwest", "Delta"))

# All flights where taxiing took longer than flying
filter(hflights, TaxiIn + TaxiOut > AirTime)

##############################################

# Select the flights that had JFK as their destination: c1
c1 <- filter(hflights, Dest == "JFK")

# Combine the Year, Month and DayofMonth variables to create a Date column: c2
c2 <- mutate(c1, Date = paste(Year, Month, DayofMonth,sep = "-"))

# Print out a selection of columns of c2
select(c2, Date, DepTime, ArrTime, TailNum)

#################################

# arrange() function for sorting rows
# Definition of dtc
dtc <- filter(hflights, Cancelled == 1, !is.na(DepDelay))

# Arrange dtc by departure delays
arrange(dtc, DepDelay)

# Arrange dtc so that cancellation reasons are grouped
arrange(dtc, CancellationCode)

# Arrange dtc according to carrier and departure delays
arrange(dtc, UniqueCarrier, DepDelay)

#################################

# dplyr and the hflights tbl are available

# Arrange according to carrier and decreasing departure delays
arrange(hflights, UniqueCarrier, desc(DepDelay))

# Arrange flights by total delay (normal order).
arrange(hflights, ArrDelay+DepDelay)

#################################

# hflights and dplyr are loaded in the workspace

# Print out a summary with variables min_dist and max_dist
summarise(hflights, min_dist= min(Distance), max_dist=max(Distance) )

# Print out a summary with variable max_div
# Quick and dirty, but required
summarise(filter(hflights, Diverted != 0), max_div= max(Distance) )

#################################

# hflights is available
# How to use complete.cases to filter NA 
# Remove rows that have NA ArrDelay: temp1
temp1 <- filter(hflights, complete.cases(ArrDelay))

# Generate summary about ArrDelay column of temp1
summarise(temp1, earliest = min(ArrDelay), average = mean(ArrDelay) ,
                latest = max(ArrDelay), sd = sd(ArrDelay)   )

# Keep rows that have no NA TaxiIn and no NA TaxiOut: temp2
temp2 <- filter(hflights, complete.cases(TaxiIn, TaxiOut) )

# Print the maximum taxiing difference of temp2 with summarise()
summarise(temp2, max_taxi_diff= max(abs(TaxiIn-TaxiOut)))

#################################

# dplyr provides several helpful aggregate functions of its own, in addition to the ones that are already defined in R. These include:

    # first(x) - The first element of vector x.
    # last(x) - The last element of vector x.
    # nth(x, n) - The nth element of vector x.
    # n() - The number of rows in the data.frame or group of observations that summarise() describes.
    # n_distinct(x) - The number of unique values in vector x.

# hflights is available with full names for the carriers

# Generate summarizing statistics for hflights
summarise(hflights,
          n_obs = n(),
          n_carrier = n_distinct(UniqueCarrier),
          n_dest = n_distinct(Dest) )

# All American Airline flights
aa <- filter(hflights, UniqueCarrier == "American")

# Generate summarizing statistics for aa 
summarise(aa, n_flights=n(), n_canc=sum(Cancelled!=0), 
                   avg_delay=mean(ArrDelay, na.rm=TRUE) )
				   
#################################

# Use dplyr functions and the pipe operator to transform the following English sentences into R code:

    # Take the hflights data set and then ...
    # Add a variable named diff that is the result of subtracting TaxiIn from TaxiOut, and then ...
    # Pick all of the rows whose diff value does not equal NA, and then ...
    # Summarise the data set with a value named avg that is the mean diff value.
	
# Write the 'piped' version of the English sentences.
hflights %>% mutate(diff = TaxiOut - TaxiIn) %>% 
  filter(complete.cases(diff)) %>% summarise(avg=mean(diff))
  
#################################


    # mutate() the hflights dataset and add two variables:
        # RealTime: the actual elapsed time plus 100 minutes (for the overhead that flying involves) and
        # mph: calculated as Distance / RealTime * 60, then
    # filter() to keep observations that have an mph that is not NA and that is below 70, finally
    # summarise() the result by creating four summary variables:
        # n_less, the number of observations,
        # n_dest, the number of destinations,
        # min_dist, the minimum distance and
        # max_dist, the maximum distance.
		
# Chain together mutate(), filter() and summarise()
hflights %>%
  mutate(RealTime = ActualElapsedTime+100, mph=Distance/RealTime*60) %>%
  filter(complete.cases(mph), mph < 70 ) %>%
  summarise(n_less=n(), n_dest= n_distinct(Dest), min_dist=min(Distance), max_dist=max(Distance) )

#################################


    # filter() the hflights tbl to keep only observations whose DepTime is not NA, whose ArrTime is not NA and for which DepTime exceeds ArrTime.
    # Pipe the result into a summarise() call to create a single summary variable: num, that simply counts the number of observations.
# Count the number of overnight flights
hflights %>%
  filter(complete.cases(DepTime, ArrTime) & DepTime>ArrTime  ) %>%
  summarise(num=n())
  
#################################

# group_by() lets you define groups within your data set. Its influence becomes clear when calling summarise() on a grouped dataset: summarising statistics are calculated for the different groups separately.

# In this exercise, you are going to create an ordered per-carrier summary of hflights by combining group_by(), summarise() and arrange().
# Instructions

    # Use group_by() to group hflights by UniqueCarrier.
    # summarise() the grouped tbl with two summary variables:
        # p_canc, the percentage of cancelled flights
        # avg_delay, the average arrival delay of flights whose delay does not equal NA.
    # Finally, order the carriers in the summary from low to high by their average arrival delay. Use percentage of flights cancelled to break any ties.

# Make an ordered per-carrier summary of hflights
hflights %>%
  group_by(UniqueCarrier) %>%
  summarise(p_canc = mean(Cancelled==1)*100,
            avg_delay = mean(ArrDelay,na.rm=TRUE)) %>%
  arrange(avg_delay, p_canc)
  
#################################

    # filter() the hflights tbl to only keep observations for which ArrDelay is not NA and positive.
    # Use group_by() on the result to group by UniqueCarrier.
    # Next, use summarise() to calculate the average ArrDelay per carrier. Call this summary variable avg.
    # Feed the result into a mutate() call: create a new variable, rank, calculated as rank(avg).
    # Finally, arrange by this new rank variable

# Ordered overview of average arrival delays per carrier
hflights %>%
  filter(complete.cases(ArrDelay), ArrDelay>0 ) %>%
  group_by(UniqueCarrier) %>%
  summarise(avg=mean(ArrDelay) ) %>%
  mutate(rank=rank(avg) ) %>%
  arrange(rank)
  
#################################

# TODO !!!
    # How many airplanes flew to only one destination? The tbl you print out should have a single column, named nplanes and a single row.
    # Find the most visited destination for each carrier. The tbl you print out should contain four columns:
        # UniqueCarrier and Dest,
        # n, how often a carrier visited a particular destination,
        # rank, how each destination ranks per carrier. rank should be 1 for every row, as you want to find the most visited destination for each carrier.

# How many airplanes only flew to one destination?
hflights %>%
  group_by(TailNum) %>%
  summarise(ndest = n_distinct(Dest)) %>%
  filter(ndest == 1) %>%
  summarise(nplanes = n())

# Find the most visited destination for each carrier
hflights %>% 
  group_by(UniqueCarrier, Dest) %>%
  summarise(n = n()) %>%
  mutate(rank = rank(desc(n))) %>%
  filter(rank == 1)
  
#################################

# Join tables by multiple keys
# Fix the code to recreate bands2
left_join(bands, artists, by = c("first", "last"))

# left_join() is equivalent to right_join() with the order of the datasets reversed. Notice that each used the same by argument
# Finish the code below to recreate bands3 with a right join
bands2 <- left_join(bands, artists, by = c("first", "last"))
bands3 <- right_join(artists, bands, by = c("first", "last"))

# Check that bands3 is equal to bands2
setequal(bands2,bands3)

#################################

# Using pipelines on join command
# Find guitarists in bands dataset (don't change)
temp <- left_join(bands, artists, by = c("first", "last"))
temp <- filter(temp, instrument == "Guitar")
select(temp, first, last, band)

# Reproduce code above using pipes
bands %>% 
  left_join(artists, by = c("first", "last")) %>%
  filter(instrument == "Guitar") %>%
  select(first, last, band)
  
#################################

