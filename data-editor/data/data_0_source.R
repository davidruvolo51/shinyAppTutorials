#'//////////////////////////////////////////////////////////////////////////////
#' FILE: data_0_source.R
#' AUTHOR: David Ruvolo
#' CREATED: 21 November 2019
#' MODIFIED: 21 November 2019
#' PURPOSE: source data and pull 100 rows
#' PACKAGES: NA
#' STATUS: working
#' COMMENTS: download data from https://data.cityofnewyork.us/Health/NYC-Dog-Licensing-Dataset/nu7n-tubp. Adjust the file path to the location of the downloaded file
#'//////////////////////////////////////////////////////////////////////////////
#' GLOBAL OPTIONS:
options(stringsAsFactors = FALSE)


# ~ 0 ~
# set path and read
path <- "~/Downloads/NYC_Dog_Licensing_Dataset.csv"
df <- read.csv(path)


# ~ 1 ~
# randomly pull 100 rows
set.seed(12345)
ceiling <- NROW(df)
array <- sample(1:ceiling, size = 100)
subsetDF <- df[array,]

# ~ 2 ~
# save
write.csv(subsetDF, "data/nyc_dogs.csv", row.names = FALSE)
saveRDS(subsetDF, "data/nyc_dogs.RDS")
