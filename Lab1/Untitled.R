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
  filter(!splitted %in% splitted_stop_words)
counts_tidy <- tidy_text %>% count(splitted, sort = TRUE)

tidy_discrm <- tidy_text %>% filter(tidy_text$label=="discrim")
counts_discrm <- tidy_discrm %>% count(splitted, sort = TRUE)

tidy_neutr <- tidy_text %>% filter(tidy_text$label=="neutral")
counts_neutr <- tidy_neutr %>% count(splitted, sort = TRUE)

counts_tidy <- merge(counts_discrm, counts_tidy, by = "splitted", all = TRUE)
colnames(counts_tidy)[colnames(counts_tidy) == "n.x"] <- "n_discrm"
colnames(counts_tidy)[colnames(counts_tidy) == "n.y"] <- "n_overall"
counts_tidy <- merge(counts_neutr, counts_tidy, by = "splitted", all = TRUE)
colnames(counts_tidy)[colnames(counts_tidy) == "n"] <- "n_neutr"
