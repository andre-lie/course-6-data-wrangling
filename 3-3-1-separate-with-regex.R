# first example - normally formatted heights
library(tidyverse)

s <- c("5'10","6'1")
tab <- data.frame(x=s)

# the separate and extract functions behave similarly
tab %>% separate(x,c("feet","inches"),sep="'")
tab %>% extract(x,c("feet","inches"),regex="(\\d)'(\\d{1,2})")

# second example - some heights with unusual formats
s <- c("5'10","6'1\"","5'8inches")
tab <- data.frame(x=s)

# separate fails because it leaves in extra characters, but extract keeps only the digits because of regex groups
tab %>% separate(x,c("feet","inches"),sep="'",fill="right")
tab %>% extract(x,c("feet","inches"),regex="(\\d)'(\\d{1,2})")
