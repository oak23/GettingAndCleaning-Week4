# Getting and Cleaning Data - Programming Assignment

The R script, `run_analysis.R`, does the following:

1. Download and unzip the data
2. Load the activity and feature vectors
3. Load the training and test datasets each into one datasets
4. Create a subset with variables with means and standard deviations only
5. Combine columns to one comprehensive dataset
6. Explicitely convert the `subject` column into a factor
7. Create a tidy dataset that consists of the average (mean) value of each
   variable for each subject and activity pair

The end result is shown in the file `avg.txt`.