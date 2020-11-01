# import data
library(tidyverse)
path <- system.file("extdata",package="dslabs")
filename <- file.path(path, "life-expectancy-and-fertility-two-countries-example.csv")
raw_dat <- read_csv(filename)
select(raw_dat,1:5)

# gather all columns except country
dat <- raw_dat %>% gather(key,value, -country)
head(dat)
dat$key[1:5]

# separate on underscores
dat %>% separate(key, c("year","variable_name"),"_")
dat %>% separate(key, c("year","variable_name"))

# split on all underscores, pad empty cells with NA
dat %>% separate(key, c("year","first_variable_name","second_variable_name"),
                fill="right")

# split on first underscore but keep life_expectancy merged
dat %>% separate(key, c("year","variable_name"), sep="_", extra = "merge")

# separate then spread
dat %>% separate(key, c("year","variable_name"), sep="_", extra = "merge") %>%  
  spread(variable_name, value)

# separate then unite
dat %>%
  separate(key, c("year","first_variable_name","second_variable_name"), 
           fill="right") %>%
  unite(variable_name, first_variable_name, second_variable_name, sep="_")

# full code for tidying data
dat %>%
  separate(key, c("year","first_variable_name","second_variable_name"), 
           fill="right") %>%
  unite(variable_name, first_variable_name, second_variable_name, sep="_") %>%  
  spread(variable_name, value) %>%
  rename(fertility=fertility_NA)
