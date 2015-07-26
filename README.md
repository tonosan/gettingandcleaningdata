# Course projecto of Getting and cleaning  data 
This repo contains the final products of the course.
The run analysis script assume you had downloaded and unzipped the UCI HAR data set in your work directory.
First set the work directory, second read the data of test and train data sets and concatenat it in one dataframe (test.train),after this, reads the subject id's and activities to add it on the data frame. This covers the step 1 of the project.
In my logic, the steps 3 and 4 were before step 2 so by factorizing the activity column its cover the step 3 and using the answer of http://stackoverflow.com/questions/28549045/dplyr-select-error-found-duplicated-column-name gave adequate names to variables (step 4).
Using select() function of dplyr I extracted the variables corresponding to means and standards deviation (step 2).
Then with reshape2's melt() function make a long format dataframe and grouping the data by subject's id, activity and measure compute the mean for each variable, activity and subject. This was performed with dplyr's group_by() and summarise() functions.
At last I saved the dataframe in a text file.
