## Course_Project
###Coursera: Getting and Cleaning Data (Jan. 5, 2015)

The purpose of the class project is to take a set of data that had been split 
apart for analysis into six parts and combine it into a single table. Using dplyr and tidyr tools. The original data __UCI HAR Dataset__ is located here 


https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip


and is comprised of measures collected from 30 subjects performing six different activities.  It is split into "test" and "train" groups.  The two files (test and train) each have three text files, with the same three tables.  Additionally the __UCI HAR Dataset__ provides two text files containing variable names (features.txt) and a code table (activity_labels).

There is no primary_key for the tables in the test and train folder, but the length of the tables in each folder are equal: # of obs. for test; # of obs. for train.

The X_ files contains the derived measurements from the readings of accelerometers, the features.txt file contains the column names for this file. (561 variables)

The subject_ files contains the id for each participant (9 in test; 21 in train)

The y_ files contains the code for the activity being recorded in the order it was performed. (6 unique activities, each performed about 30 times)

With the __HAN UCI Dataset__ file unzipped into the working directory, The script does the following:

### Step 1
####read all the "test" file data into the working directory as follows:

+ activity_labels.txt storing it as "activities" using col.names =c("act_code","activity")
+ features.txt as "features"
+ create a character vector (fix.features) from features[,2]; the vector elements contain punctuation marks that must be removed and duplicate names that must be altered, using gsub(), so they can act as column names
+ X_test.txt as "test_X" (using col.names = fix.features)
+ subject_test.txt as "sub_test" using col.names="subjects"
+ y_test.txt as "test_y" using col.names="act_code"

###Step 2 
####combine "sub_test" and "test_y" using bind_cols
Includes addind a variable 'from_set' = "test" to identify the source file; combine with "test_X" using bind_cols. Each of the three objects are of equal length.

###Step 3
####Convert the resulting __test_data__ object from a data.frame to a tbl_df 

###Step 4
####Repeat this procedure for the "train" file data
The "fix.features" object is reused for col.names.  The resulting object is called __train_data__ and has a new variable, 'from_set'="train"

###Step 5
####Use bind_rows to combine __test_data__ and __train_data__ 
With 2947 obs. 564 variables and 7352 obs 564 variables, respectively, for a total of 10,299 observation for 564 variables.

###Step 6 Add descriptive names for the __act_code__ 
Using a left_join() with 'activities'

#####*This completes the the recombination of the HAN UCI Dataset into a data.frame 'desc_data'*.


###Step 7 
####subset and group the data.
Using subject, act_code, activity_desc, from_set and all measurment variables with names containing the string 'std' or 'mean'; sort and group the data by subject and activity.

#####*This completes the second data.frame 'subset'*.

###Step 8 
#### Create a separate dataset 
It contains a summary of the data for each activity for each subject; calculating the mean() for each measure.

#####The resulting data.frame 'new_data' is a tidy dataset and returns the data as instructed.

###Step 9.  
####Export the resulting table as a text file.
Finally, the resulting summarized table is written to the working directory as a tab delimited text file.  It is called __tidy_data_set.txt__.