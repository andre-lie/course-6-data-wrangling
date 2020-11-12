# load stringr through tidyverse
library(tidyverse)
library(dslabs)
library(stringr)
library(htmlwidgets)
data("reported_heights")

# detect whether a comma is present
pattern <- ","
str_detect(murders_raw$total,pattern)

# show the subset of strings including "cm"
str_subset(reported_heights$height,"cm")

# use the "or" symbol inside a regex (|)
yes <- c("180 cm","70 inches")
no <- c("180", "70''")
s <- c(yes,no)
str_detect(s,"cm") | str_detect(s, "inches")
str_detect(s,"cm|inches")

yes <- c("5","6","5'10","5 feet","4'11")
no <- c("",".","Five","six")
s <- c(yes,no)
pattern <- "\\d"
str_detect(s,pattern)

# highlight the first occurrence of a pattern
str_view(s,pattern)

# highlight all instances of a pattern
str_view_all(s,pattern)
