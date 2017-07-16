# README - GCD Assyn1

The run_analysis.R script does the following:

1. It checks whether the appropriate file is already downloaded
2. It selects only features (columns) that includes mean or std in the name
3. It combines train and test datasets into one clean dataset with appropriate factor levels and colnames
4. It outputs a clean dataset with the mean of each measurement for each subject/activity combination
5. It writes the codebook which is a simple list of colnames in the resulting dataset

Note: Please note that the numerical levels for column “activity” correspond to the following:

| Level | Activity |
| 1 | WALKING
| 2 | WALKING_UPSTAIRS
| 3 | WALKING_DOWNSTAIRS
| 4 | SITTING
| 5 | STANDING
| 6 | LAYING