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

