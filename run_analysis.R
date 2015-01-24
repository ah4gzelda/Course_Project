## before running script, the UCI HAR Dataset must be imported and unzipped into 
## the working directory.  It can be obtained here:
## https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

##load packages dplyr and tidyr
library(dplyr)
library(tidyr)

##read in data 
##activity_labels.text - a two column table that decodes the data for the _y tables.
##features.txt - for the column names of the _X tables

activities <- read.table("./UCI HAR Dataset/activity_labels.txt", header=FALSE, col.names=c("act_code","activity"))
features <- read.table("./UCI HAR Dataset/features.txt")

##correct the "features" list so it can be use as poper variable names - remove all punctuation

fix.features <- gsub("[[:punct:]]", "",features[,2],)


## Note: there are duplicate names in "features" because of missing X,Y, & Z indicators
## the corrections made are as follows
## [303:316]addX, [317:330]addY, [331:344]addZ; [382:395]addX, [396:409]addY,
## [410:423]addZ; [461:474]addX; [475:488]addY; [489:502]addZ

fix.features[c(303:316, 382:395, 461:474)] <-gsub("Energy", "EnergyX", fix.features[c(303:316, 382:395, 461:474)])
fix.features[c(317:330, 396:409, 475:488)] <-gsub("Energy", "EnergyY", fix.features[c(317:330, 396:409, 475:488)])
fix.features[c(331:344, 410:423, 489:502)] <-gsub("Energy", "EnergyZ", fix.features[c(331:344, 410:423, 489:502)])


## read in the Test file data
## test_X that contains the individual measurse for each activity.
## subject_test.txt - the subjects (participants) of the study,  and y_test.txt - the activities performed by the subjects
## No primary key exists in the separate tables; each table is of equal length and will be join vertically 
## preserving their original order.

test_X <-read.table("./UCI HAR Dataset/test/X_test.txt",header=FALSE, col.names=fix.features)
test_sub <-read.table("./UCI HAR Dataset/test/subject_test.txt",header=FALSE, col.names="subject")
test_y <-read.table("./UCI HAR Dataset/test/y_test.txt",header=FALSE, col.names="act_code")

##combine the three data.frames; subject and activity first and add a variable 
## to identify it as "test" data; then add the features

sub_act <-bind_cols(test_sub, test_y)
sub_act <- mutate(sub_act, from_set="test")
sub_act_feat <-bind_cols(sub_act, test_X)

##convert data.frames to tbl_df; 2947 obs. of 564 variables
test_data <-tbl_df(sub_act_feat)


## repeat for training data
## X_train.txt - the raw data and reuse fix.features for col.names
## subject_train.txt - the subjects of the study and y_train.txt - the activity performed by the subjects
## No primary key exists in the separate tables; 

train_X <-read.table("./UCI HAR Dataset/train/X_train.txt",header=FALSE, col.names=fix.features)
train_sub <-read.table("./UCI HAR Dataset/train/subject_train.txt",header=FALSE, col.names="subject")
train_y <-read.table("./UCI HAR Dataset/train/y_train.txt",header=FALSE, col.names="act_code")

##combine data.frames

tr_sub_act <-bind_cols(train_sub, train_y)
tr_sub_act <- mutate(tr_sub_act, from_set="train")
tr_sub_act_feat <-bind_cols(tr_sub_act, train_X)

##convert data.frames to tbl_df;  7352 obs. of 564 variables
train_data <-tbl_df(tr_sub_act_feat)


## combine the test and training tbl_df
all_data <-bind_rows(test_data, train_data)

## add activity description which will add one variable; 10299 obs. of 565 variables
desc_data <-left_join(all_data, activities, by="act_code")

##subset & group the data to include only features with std() and mean() and
##group by subject and activity; 10299 obs. of 90 variables

subset <- desc_data  %>% 
        select(subject, act_code, activity, from_set, matches("std"), matches("mean")) %>% 
        group_by(subject, activity) 

##### Create second independent data set that gives the mean and export to text
new_data <- subset %>% 
        select(-c(act_code, from_set))  %>% 
        group_by(subject, activity) %>% 
        arrange(subject, activity) %>%
        summarise_each(funs(mean))

##create a tab-delimited text file, without row names and write it to the working directory
write.table(new_data, file="tidy_data_set.txt",row.name=FALSE, sep='\t', quote=FALSE)