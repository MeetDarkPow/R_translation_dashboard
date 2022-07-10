# Reading "message_status.csv" and "metadata.csv"
msg_status_df <- read.csv("message_status.csv")
meta_data_df <- read.csv("metadata.csv")

# Value Boxes
total_lang <- length(unique(msg_status_df$language))
total_trans_msg <- length(msg_status_df$translated[msg_status_df$translated==TRUE])
total_untrans_msg <- length(msg_status_df$translated[msg_status_df$translated==FALSE])
total_fuzzy_msg <- length(msg_status_df$fuzzy[msg_status_df$fuzzy==TRUE])
