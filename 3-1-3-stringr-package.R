# murders_raw defined in web scrapping video

# direct conversion to numeric fails because of commas
murders_raw$population[1:3]
as.numeric(murders_raw$population[1:3])

library(tidyverse)   # includes stringr
library(stringr)
