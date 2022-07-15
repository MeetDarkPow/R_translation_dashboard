# library
library(tidyverse)

# Reading "message_status.csv" and "metadata.csv"
msg_status_df <- read.csv("message_status.csv")
meta_data_df <- read.csv("metadata.csv")

# Value Boxes
total_lang <- length(unique(msg_status_df$language))
total_trans_msg <- length(msg_status_df$translated[msg_status_df$translated==TRUE])
total_untrans_msg <- length(msg_status_df$translated[msg_status_df$translated==FALSE])
total_fuzzy_msg <- length(msg_status_df$fuzzy[msg_status_df$fuzzy==TRUE])

# Languages dependent graphs for translated/untranslated messages
lang_df <- msg_status_df %>%
  select(package, language, translated)
stats_df <- lang_df %>%
  group_by(package, language, translated) %>%
  summarise(Count = n())
trans_df <- subset(stats_df, translated==TRUE)
untrans_df <- subset(stats_df, translated==FALSE)
final_df <- merge(trans_df, untrans_df, by = c("package", "language"), all = TRUE)
final_df <- final_df %>%
  rename(translated_count = Count.x, untranslated_count = Count.y)
final_df <- final_df %>%
  mutate(translated_count = coalesce(translated_count, 0), untranslated_count = coalesce(untranslated_count, 0))
final_df <- subset(final_df, select = -c(translated.x, translated.y))

# Fully Translated Packages with respective languages associated

complete_trans_df <- subset(final_df, untranslated_count == 0)

# Untranslated Packages with respective languages associated

complete_untrans_df <- subset(final_df, translated_count == 0)

