library(tidytext)
library(readr)
library(dplyr)
library(ggplot2)

test_path <- "data/1-discrimination/test.csv"
train_path <- "data/1-discrimination/train.csv"

stop_words <- read_file("stop_words.txt")

splitted_stop_words <- strsplit(stop_words, split='\n')
splitted_stop_words <- splitted_stop_words[[1]]

train <-  read.csv(file = train_path, stringsAsFactors = FALSE)
test <-  read.csv(file = test_path, stringsAsFactors = FALSE)

tidy_text <- unnest_tokens(train, 'splitted', 'tweet', token="words") %>%
  filter(!splitted %in% stop_words)

tidy_text %>% count(splitted,sort=TRUE)
