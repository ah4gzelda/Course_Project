##Course_Project Code Book##

###Data###
The data for the project can be found here:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

The .zip file contains two sets of data, training and test, that will be combined into a single dataset.
The file must be unzipped into the working directory.

The __run_analysis.R__ script creates three data.frames:

* __desc_data__
       + the rejoined test and train data;

* __subset__
       + a subset of that data including only those variables related to the mean() and std();

* __new_data__
       + a final table that calculates the mean of each of these variables for each activity performed by each subject.  The third file is then exported as a tab-delimited text file.

###Transformations & Combinations###
 1. made corrections to the feature names for use as variable names - removed punctuation and fixed duplicates 
 2. joined tables from the 'test' file adding column names for each variable; the feature.txt data was used as column names for the measures in X_test.txt file; the procedure was repeated for 'training' set
 3. combined the two resulting tables
 4. changed the Activity code to its description
 5. limited the measure variables to those related to mean() and std()
 6. grouped the data

###Variable Names and Definitions###

####desc_data
Combination of the __test__ and __train__ data

 * subject: an integer - values 1-30
 * act_code: an integer - values 1-6
 * activity - six activities corresponding to act_code
 
        + WALKING (1)
        + WALKING_UPSTAIRS (2)
        + WALKING_DOWNSTAIRS (3)
        + SITTING (4)
        + STANDING (5)
        + LAYING (6)
        
 * from_set - a new variable containing two values "test" and "train"; describes original source of an observation
 * measures - 561 features derived from accelerometer readings for each activity performed by each subject.  The units are normalized with values from -1 to 1.

   A full description of the measures and how they were derived can be found in the __UCI HAR Dataset__ folder:  _README.md_ and _features_info.txt_.  The complete list of features is in _features.txt_.

####subset####
Limits the data in __desc_data__ to the 86 measures of interest. Contains 10,299 observations of 90 variables 

 * subject - see: "desc_data"
 * act_code - see: "desc_data"
 * activity - see: "desc_data"
 * from_set - see: "desc_data"
 * measures - subset of 86 features in "desc_data" that describe a mean() or std()

####new_data####
Creates a new data.frame that summarizes the data in __subset__.  Contains 180 observations of 88 variables, 6 for each of 30 subjects.

The variables come from the  "subset" data.frame.  For each of the 86 features the mean() was calculated for each group of measures for an activity performed by a subject.

 * subject - see: "desc_data"
   grouped - 6 observations for each of 30 subjects

 * activity - see: "desc_data"; 1 observation for each of 6 activities for each subject

 * measures - same as in "subset"
   value is the mean of all observations of an activity for a single subject.
