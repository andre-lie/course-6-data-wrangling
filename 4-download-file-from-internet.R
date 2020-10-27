url <- "http://www.openintro.org/stat/data/nycflights.csv"
dat_nyc <- read_csv(url)
download.file(url,"nycflights.csv")
tempfile()
tmp_filename <- tempfile()
download.file(url,tmp_filename)
dat_nyc <- read_csv(tmp_filename)
file.remove(tmp_filename)
