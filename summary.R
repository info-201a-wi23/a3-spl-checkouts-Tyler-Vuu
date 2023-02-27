library("dplyr")
library("ggplot2")

library_df <- read.csv("2017-2023-10-Checkouts-SPL-Data.csv")
#- What is the average number of checkouts for each item every year
#- What is the most popular media type checked out
#- Who is the most popular author being checked out every year
#- How has the number of print book checkouts changed over time?
#- What is the most popular genre for each year

average_checkouts <- library_df %>% 
  group_by(CheckoutYear) %>% 
  summarise(Checkouts = mean(Checkouts, na.rm = TRUE)) %>% 
  pull(Checkouts)

popular_media <- library_df %>% 
  group_by(MaterialType) %>% 
  summarise(Checkouts = sum(Checkouts, na.rm = TRUE)) %>% 
  arrange(desc(Checkouts)) %>% 
  slice(2:6) %>% 
  pull(MaterialType)

popular_author <- library_df %>% 
  group_by(Creator) %>% 
  summarise(Checkouts = sum(Checkouts, na.rm = TRUE)) %>% 
  arrange(desc(Checkouts)) %>% 
  slice(2:6) %>% 
  pull(Creator)

print_books <- library_df %>% 
  filter(MaterialType == "BOOK") %>% 
  group_by(CheckoutYear) %>% 
  summarise(Checkouts = sum(Checkouts, na.rm = TRUE)) %>% 
  pull(Checkouts)

digital_books <- library_df %>% 
  filter(MaterialType == "EBOOK") %>% 
  group_by(CheckoutYear) %>% 
  summarise(Checkouts = sum(Checkouts, na.rm = TRUE)) %>% 
  pull(Checkouts)

print("The average checkouts every year are:")
paste(average_checkouts)
print("The top 5 most popular media types are:")
paste(popular_media)
print("The top 5 most popular authors are:")
paste(popular_author)
print("The number of physical checkouts every year is:")
paste(print_books)
print("The number of digital checkouts every year is:")
paste(digital_books)