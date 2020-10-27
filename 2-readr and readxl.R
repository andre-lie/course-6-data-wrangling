library(dslabs)
library(tidyverse)  # includes readr
library(readxl)

# inspect the first 3 lines
read_lines("murders.csv",n_max=3)

# read file in CSV format
filename <- "murders.csv"
dat <- read_csv(filename)

#read using full path
path <- getwd()
fullpath <- file.path(path,filename)
dat <- read_csv(fullpath)
head(dat)

#Ex：
path <- system.file("extdata", package="dslabs")
files <- list.files(path)
files

filename <- "murders.csv"
filename1 <- "life-expectancy-and-fertility-two-countries-example.csv"
filename2 <- "fertility-two-countries-example.csv"
dat=read_csv(file.path(path,filename))
dat1=read_csv(file.path(path,filename1))
dat2=read_csv(file.path(path,filename2))

# read excel
dat_excel <- read_excel("arbuthnot.xlsx")
