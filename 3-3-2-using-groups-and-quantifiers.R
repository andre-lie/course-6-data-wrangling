# Case 1
# Many students measuring exactly 5 or 6 feet did not enter any inches. 
# For example, 6' - our pattern requires that inches be included.

# For case 1, if we add a '0 to, for example, convert all 6 to 6'0, 
# then our pattern will match. 
# This can be done using groups using the following code
yes <- c("5","6","5")
no <- c("5'","5''","5'4")
s <- c(yes,no)
str_replace(s,"^([4-7])$","\\1'0")

# Case 2, 4
#2 Some students measuring exactly 5 or 6 feet entered just that number.
#4 Some entires have spaces at the end, for example 5 ' 9

# To handle case 2, we want to permit the 5 or 6 to be followed by no or one 
# symbol for feet. So we can simply add '{0,1} after the ' to do this. 
# We can also use the none or once special character ?
str_replace(s,"^([5-6])'?$","\\1'0")

# Case 3
# Some of the inches were entered with decimal points. For example 5'7.5''

# We need allow the second group to include decimals and not just digits. 
# This means we must permit zero or one period . followed by zero or more digits. 
# So we will use both ? and *

# we can adapt our pattern, currently ^[4-7]\\s*'\\s*\\d{1,2}$, 
# to permit a decimal at the end:
pattern <- "^[4-7]\\s*'\\s*(\\d+\\.?\\d*)$"

# Case 5
# Some entries are in meters and some of these use European decimals: 1.6, 1,7

# meters using commas, we can approach similarly to how we converted the x.y to x'y. 
# A difference is that we require that the first digit is 1 or 2
yes <- c("1,7","1, 8","2, ")
no <- c("5,8","5,3,2","1.7")
s <- c(yes,no)
str_replace(s, "^([12])\\s*,\\s*(\\d*)$","\\1\\.\\2")

# Trimming
s <- "Hi "
cat(s)
identical(s,"Hi")

str_trim("5 ' 9 ")

# To upper and to lower case
s <- c("Five feet eight inches")
str_to_lower(s)

convert_format <- function(s){
  s %>%
    str_replace("feet|foot|ft", "'") %>% #convert feet symbols to '
    str_replace_all("inches|in|''|\"|cm|and", "") %>%  #remove inches and other symbols
    str_replace("^([4-7])\\s*[,\\.\\s+]\\s*(\\d*)$", "\\1'\\2") %>% #change x.y, x,y x y
    str_replace("^([56])'?$", "\\1'0") %>% #add 0 when to 5 or 6
    str_replace("^([12])\\s*,\\s*(\\d*)$", "\\1\\.\\2") %>% #change european decimal
    str_trim() #remove extra space
}

words_to_numbers <- function(s){
  str_to_lower(s) %>%  
    str_replace_all("zero", "0") %>%
    str_replace_all("one", "1") %>%
    str_replace_all("two", "2") %>%
    str_replace_all("three", "3") %>%
    str_replace_all("four", "4") %>%
    str_replace_all("five", "5") %>%
    str_replace_all("six", "6") %>%
    str_replace_all("seven", "7") %>%
    str_replace_all("eight", "8") %>%
    str_replace_all("nine", "9") %>%
    str_replace_all("ten", "10") %>%
    str_replace_all("eleven", "11")
}

not_inches_or_cm <- function(x, smallest=50, tallest=84){
  inches <- suppressWarnings(as.numeric(x))
  ind <- !is.na(inches) &
    ((inches >= smallest & inches <= tallest) |
       (inches/2.54 >= smallest & inches/2.54 <= tallest))
  !ind
}

converted <- problems %>% words_to_numbers %>% convert_format
remaining_problems <- converted[not_inches_or_cm(converted)]
pattern <- "^[4-7]\\s*'\\s*\\d+\\.?\\d*$"
index <- str_detect(remaining_problems, pattern)
remaining_problems[!index]
