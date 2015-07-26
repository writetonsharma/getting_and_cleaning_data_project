
merge_dataset <- function()
{
  message("Step1 - Mergin dataset...")
  
  # read feature list, transpose all rows into columns
  # write feature names into final merge file
  features <- read.table("UCI HAR Dataset\\features.txt")
  features <- as.data.frame(t(features))
  features <- features[2,]
  features <- cbind(features, "subject", "activity")
  write.table(x=features,file="final_merge.txt", col.names=F, row.names=F)
  
  # merge train data and write in final merge file
  train_merge <- cbind(read.table("UCI HAR Dataset\\train\\X_train.txt"),
                       read.table("UCI HAR Dataset\\train\\subject_train.txt"),
                       read.table("UCI HAR Dataset\\train\\y_train.txt"));
  write.table(x=train_merge,file="final_merge.txt", append=T, col.names=F, row.names=F)
  
  # merge test data and write in final merge file
  test_merge <- cbind(read.table("UCI HAR Dataset\\test\\X_test.txt"),
                      read.table("UCI HAR Dataset\\test\\subject_test.txt"),
                      read.table("UCI HAR Dataset\\test\\y_test.txt"));
  write.table(x=test_merge,file="final_merge.txt", append=T, col.names=F, row.names=F)
  

  # we have the final merge data in file named - "final_merge.txt"
  # return this file name
  filename <- "final_merge.txt"
  filename
}

select_mean_std_cols <- function(filename)
{
  # read the final merged file
  df <- read.table(file=filename, header=T, check.names=F)
  
  # read all the columns which have mean or std in col names
  sub_mean <- df[,grep("mean()", colnames(df))]
  sub_std <- df[,grep("std()", colnames(df))]
  s <- subset(df, select=c("subject","activity"))
  sub <- cbind(sub_mean, sub_std,s)
  
  # overwrite the final merged file with only mean/std cols
  write.table(x=sub,file="final_merge.txt", col.names=T, row.names=F)
  
  filename <- "final_merge.txt"
  filename
}

describe_activity_names <- function(filename)
{
  df <- read.table(file=filename, header=T, check.names=F)
  activity <- read.table(file="UCI HAR Dataset\\activity_labels.txt")
  
  l <- length(df$activity)
  for(i in 1:l)
  {
    df$activity[i] <- as.character(activity[,2][as.numeric(df$activity[i])])
    i <- i+1
  }
  write.table(x=df,file="final_merge.txt", col.names=T, row.names=F)
  
  filename <- "final_merge.txt"
  filename 
}

run_analysis <- function()
{
  merge_file <- merge_dataset()
  message(c("dataset merged into file ", merge_file))

  merge_file <- select_mean_std_cols(merge_file)
  
  describe_activity_names("final_merge.txt")
  
  
}