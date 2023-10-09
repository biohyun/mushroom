#rvest package is used to scrape data from the website
install.packages("rvest")
library(rvest)

#Get the data from the website
url="https://www.wildfooduk.com/mushroom-guide/?mushroom_orderby=common_name&mushroom_order=ASC"
wabpage <- read_html(url)
table <- html_nodes(wabpage, "table")
df_table <- html_table(table)[[1]]

#Get the common names and scientific names from the table
common_names <- df_table$`Sort by common name : \nCommon Name`
scientific_names <- df_table$`Sort by scientific name : \nScientific Name`

#Preprocess the names
gsub("-", " ", common_names)->common_names
gsub("[.]", "", common_names)->common_names
tolower(gsub(" ", "_" ,common_names))->common_names

gsub(" / ", "/", scientific_names)->scientific_names
tolower(gsub(" ", "_", scientific_names))->scientific_names

#Create a dataframe with the names
names_df <- data.frame(Common=common_names, Scientific=scientific_names)

#Get actuall classes
data_name <- scan(file="mushrooms.txt", what="character", quote=NULL)
labels <- data.frame(Common=data_name, Edible=NA, Poisonous=NA)

#Merge the dataframes
merged_df <- merge(names_df, labels, all.y=TRUE)

#Save the data
write.csv(merged_df, file="labeled.csv", row.names=FALSE)
