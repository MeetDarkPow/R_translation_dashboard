# libraries
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



# kktt <- subset(final_df, language=="Spanish",)
# 
# fig <- plot_ly(kktt, x = ~package, y = ~translated_count, type = 'bar', name = 'Translated Messages')
# fig <- fig %>% add_trace(y = ~untranslated_count, name = 'Untranslated Messages')
# fig <- fig %>% layout(yaxis = list(title = 'Count'), barmode = 'group')



# 
# create_chart <- function(data, var){
#   
#   data %>%
#     filter(package == var) %>%
#     e_chart(x = package) %>%
#     e_bar(serie = translated_count, name = "Translated") %>%
#     e_bar(serie = untranslated_count, name = "Untranslated") %>%
#     e_tooltip()
# }
# 
# prepare_grid_chart <- function(data){
#   pkg <- unique(final_df$package)
#   for(i in 1:length(pkg)){
#     assign(paste0("e", i), create_chart(data, pkg[i]))
#   }
#   e_arrange(e1, e2, e3, e4, e5, e6, e7, e8, e9, e10, e11, e12, e13, rows = 4, cols = 4, title = "Translated and Untranslated R Messages")
# }
