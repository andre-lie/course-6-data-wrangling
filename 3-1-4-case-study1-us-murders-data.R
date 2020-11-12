# murders_raw was defined in the web scraping section
library(tidyverse)   # includes stringr
library(rvest)
library(stringr)

url <- "https://en.wikipedia.org/wiki/Murder_in_the_United_States_by_state"
h <- read_html(url)

tab <- h %>% html_nodes("table")
tab <- tab[[2]] %>% html_table

murders_raw <- tab %>% setNames(c("state","population","total","murders","gun_murders",
                          "gun_ownership","total_rate","murder_rate",
                          "gun_murder_rate"))
head(murders_raw)

# detect whether there are commas
commas <- function(x) any(str_detect(x,","))
murders_raw %>% summarize_all(funs(commas))

# replace commas with the empty string and convert to numeric
test_1 <- str_replace_all(murders_raw$population, "," ,"") 
test_1 <- str_replace_all(murders_raw$population, "\\[5|,|\\]" ,"") 
test_1 <- as.numeric(test_1)

# parse_number also removes commas and converts to numeric
test_2 <- parse_number(murders_raw$population)
identical(test_1,test_2)

murders_new <- murders_raw %>% mutate_at(2:3, parse_number)
murders_new %>% head
