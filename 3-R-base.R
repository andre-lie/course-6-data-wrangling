# filename is defined in the previous video
# read.csv converts strings to factors

filename <- "murders.csv"
dat2 <- read.csv(filename)
class(dat2$abb)
class(dat2$region)
dat3 <- read.csv(filename,stringsAsFactors = TRUE)
class(dat3$abb)
