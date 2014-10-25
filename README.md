Getting-CleaningData Project
===========================
##How the script works

1. You should download the run_analysis.R in your working directory.
2. In my case I create a folder as working directory (Project Cleaning Data)
3. Inside of the folder it should be the unzip dataset (UCI HAR Dataset)
4. When you run the .R script the output is a .txt file with the tydy data.


##Code Book

1. For the activity labels, I use the variables that where described in UCI HAR Dataset/activity_labels.txt

WALKING
WALKING_UPSTAIRS
WALKING_DOWNSTAIRS
SITTING
STANDING
LAYING

2. For the features, I use the names that where described in UCI HAR Dataset/features.txt
3. However, there was a change in their names which contains character "-" it was replaced by "" 
