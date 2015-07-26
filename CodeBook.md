
run_analysis()
This function is the entry point function in the script and calls different sub functions to get the tidy data set in the end

merge_dataset()
This function is the first function called by the run_analysis() function. It merges the train and test data set and write the final merged dataset in a file called final_merge.txt
It reads the features.txt files and transpose the rows into columns, adds two more columns called subject and activity. Once done, writes them to file final_merge.txt. These will form the column names of this file.

Then it reads and merge the train data and keeps that in train_merge variable. Then write this to the final_merge.txt file.

Same way, test data is read and merged and written to the final_merge.txt file. It returns the name of this file so that the next function can use this file to work on that.


select_mean_std_cols(filename)
This function subsets the merged data with only column names which have mean or std in their names

filename is the name of the merged file from the routine merge_dataset()
df reads the merged data file, filename
sub_mean reads all the columns having column names "mean" in them
sub_std reads all the columns having column names "std"" in them
S reads the columns subject and activity
sub combines (cbind) the sub_mean, sub_std and s data into one and finally overwrites the merged file. 
Now this file has only those columns which have "mean" or "std" in their names


describe_activity_names(filename)
This function adds descriptive activity names to the column activity

filename is the final merged file which should be read by this function
df contains the data from the filename
activity contains the activity names from the file activity_labels.txt
l is the length of the row "activity"
it runs a loop for each row in the activity column and replace the numeric value from the equivalent numeric value in the same row of the activity column in df.
returns the final file written to called function for next step processing

