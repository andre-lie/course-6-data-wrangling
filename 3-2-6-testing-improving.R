# function to detect entries with problems
not_inches_or_cm <- function(x, smallest=50, tallest=84){
  inches <- suppressWarnings(as.numeric(x))
  ind <- !is.na(inches) &
    ((inches >= smallest & inches <= tallest) |
       (inches/2.54 >= smallest & inches/2.54 <= tallest))
  !ind
}

# identify entries with problems
problems <- reported_heights %>%
  filter(not_inches_or_cm(height)) %>%
  .$height
length(problems)

converted <- problems %>%
  str_replace("feet|foot|ft","'") %>% #convert feet symbols to '
  str_replace("inches|in|''|\"","") %>% #remove inches symbols
  str_replace("^([4-7])\\s*[,\\.\\s+](\\d*)$","\\1'\\2") ##change format

# find proportion of entries that fit the pattern after reformatting
pattern <- "^[4-7]\\s*'\\s*\\d{1,2}$"
index <- str_detect(converted, pattern)
mean(index)

converted[!index] # show problems

# Some students measuring exactly 5 or 6 feet entered just that number
yes <- c("5", "6", "5")
no <- c("5'", "5''", "5'4","5'7.5\"")
s <- c(yes, no)
str_replace(s, "^([4-7])$", "\\1'0") %>% cat

# Many students measuring exactly 5 or 6 feet did not enter any inches, for example 6', and our pattern requires that inches be included
str_replace(s, "^([56])'?$", "\\1'0")

# Some of the inches were entered with decimal points. For example 5'7.5''. Our pattern only looks for two digits
pattern <- "^[4-7]\\s*'\\s*(\\d+\\.?\\d*)$"
index <- str_detect(converted, pattern)
mean(index)
converted[!index] # show problems

# Some entries are in meters and some of these use European decimals: 1.6, 1,70
yes <- c("1,7", "1, 8", "2, " )
no <- c("5,8", "5,3,2", "1.7")
s <- c(yes, no)
str_replace(s, "^([12])\\s*,\\s*(\\d*)$", "\\1\\.\\2")
