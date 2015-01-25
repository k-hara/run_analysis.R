## run_analysis.R
Getting and Cleaning Data Course Project

#How the script works?
  This script executes all process from obtaining the data from UCI database to outputing the new tidy dataset in a text file.

#Codebook
<variables><br>
fileUrl: "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip" the URL from which the data to be downloaded.<br>
colNames: A single column table created from the text file 'features.txt'.<br>
subject_train: A single column table with the column 'subject', created from the text file 'subject_train.txt'.<br>
subject_test: A single column table with the column 'subject',  created from the text file 'subject_test.txt'.<br>
y_test: A single column table with the column 'activity', created from the text file 'y_test.txt'. <br>
y_train: A single column table with the column 'activity', created from the text file 'y_train.txt'. <br>
subject: subject_train+subject_test<br>
activity: y_train+y_test<br>
features: a character vector made from colNames.<br>
features1: a character vetor 'features' modified to make it correct syntaxically.<br>
x_train: A table with columns named by 'features1', created from the text file 'x_train.txt'. <br>
x_test: A table with columns named by 'features1', created from the text file 'x_test.txt'. <br>
x_all: x_train+x_test<br>
x_mean_std: Extracted columns from 'x_all'. All column names contain  character substrings "mean" and "std".<br>
dfStep4: 'x_mean_std' merged with single column tables 'subject' and 'activity'.<br>
by_subject_activity: dfStep4 grouped by 'subject' and 'activity'.<br>
tidydf: The second, independent tidy dataset with the average of each variable for each activity and each subject.

