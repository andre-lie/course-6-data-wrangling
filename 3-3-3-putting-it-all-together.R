library(dslabs)
library(english)
data("reported_heights")

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

convert_format <- function(s){
  s %>%
    str_replace("feet|foot|ft", "'") %>% #convert feet symbols to '
    str_replace_all("inches|in|''|\"|cm|and", "") %>%  #remove inches and other symbols
    str_replace("^([4-7])\\s*[,\\.\\s+]\\s*(\\d*)$", "\\1'\\2") %>% #change x.y, x,y x y
    str_replace("^([56])'?$", "\\1'0") %>% #add 0 when to 5 or 6
    str_replace("^([12])\\s*,\\s*(\\d*)$", "\\1\\.\\2") %>% #change european decimal
    str_trim() #remove extra space
}

not_inches <- function(x, smallest=50, tallest=84) {
  inches <- suppressWarnings(as.numeric(x))
  ind <- is.na(inches) | inches < smallest | inches > tallest
  ind
}

pattern <- "^([4-7])\\s*'\\s*(\\d+\\.?\\d*)$"

smallest <- 50
tallest <- 84

new_heights <- reported_heights %>%
  mutate(original=height,
         height=words_to_numbers(height) %>% convert_format()) %>%
  extract(height,c("feet","inches"),regex=pattern, remove = FALSE) %>%
  mutate_at(c("height","feet","inches"), as.numeric) %>%
  mutate(guess=12*feet+inches) %>%
  mutate(height=case_when(
    !is.na(height) & between(height,smallest,tallest) ~ height,  # inches
    !is.na(height) & between(height/2.54,smallest,tallest) ~ height/2.54,  # centimeters
    !is.na(height) & between(height*100/2.54,smallest,tallest) ~ height*100/2.54,  # meters
    !is.na(guess) & inches < 12 & between(guess,smallest,tallest) ~ guess,  # feet'inches
    TRUE ~ as.numeric(NA)
  )) %>% 
  select(-guess)

# We can check all the entries we converted using the following code
new_heights %>%
  filter(not_inches(original)) %>%
  select(original,height) %>%
  arrange(height) %>%
  View()

# Let's take a look at the shortest students in our dataset using the following code
new_heights %>% arrange(height) %>% head(n=10)
