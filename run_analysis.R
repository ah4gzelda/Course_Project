#read file "./test/subject_test.txt"
#read file "./test/X_test.txt"
#read file "./test/y_test.txt"
#read files "./test/Inertial Signals/body_acc_x_test.txt; body_acc_y_test.txt;
#body_gyro_x_test.txt; body_gyro_y_test.txt; body_gyro_z_test.txt; total_accy_x_test.txt;
#total_acc_y_test.txt' total_acc_z_test.txt"

#read file "./train/subject_test.txt"
#read file "./train/X_test.txt"
#read file "./train/y_test.txt"
#read files "./train/Inertial Signals/body_acc_x_test.txt; body_acc_y_test.txt;
#body_gyro_x_test.txt; body_gyro_y_test.txt; body_gyro_z_test.txt; total_accy_x_test.txt;
#total_acc_y_test.txt' total_acc_z_test.txt"
#
#
# for script - point to file in working directory "./filename"
# create a README.md that describes the script and the code book of variables


# 1. Merge Training data set with Test data set to create one data set
# 2. Extract variables that are mean() and stdev() for each measurment
# 3. rename variables with descriptive names
# 4. rename the data set files with descriptive names
# 5. From final data set, create a new, independent tidy data set that groups the original by activity and subject
# and calculates the mean for each variable - group_by

#Upload a textfile of the tidy data set created in step 5; created by write.table() row.names=FALSE

#submit a link to a Github repo with the code for performing analysis (run_analysis.R) referencing the files in local directory
#with tidy data set as output