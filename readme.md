
## Getting and Cleaning Data final Assignment

This is the final assigment in the Getting and Cleaning Data course from coursera. The `run_analisys.R` script performs the next steps:

1. Install needed packages `dplyr`, `tidyr` and `tibble`.

2. Name the zip file and then look if the file exist. If not, the file is downloaded and then unziped.

3. Read the `features.txt` file and paste number and name columns for having uniques names.

4. Read the files of test data:
  - `X_test.txt`
  - `subject_test.txt`
  - `y_test.txt`
  
  Then, sets the variable names stored before in `nombres` variable and bind by column with cbind the three datasets.
  
5. Read the files of train data:
  - `X_train.txt`
  - `subject_train.txt`
  - `y_train.txt`
  
  Sets the variable names stored before in `nombres` variable and bind by column with cbind the three datasets.
  
6. Now that we have one complete dataset for test and anothe for train, we bind this two with rbind and call the result `testtrain`.

7. Search the columns that have the word mean or sd with `grep` command.

8. Filter with `select` command the variables searched in the last step and `subject` and `activity`. 

9. Read and assign the activity names to the `testtrain` dataset

10. Make understandable the names of the variables by making all lowercase and replacing the simbols o duplicated words. Then, assign this names to the `testtrain` dataset.

11. Remove with `rm` command all the objects that has been created and are not more longer needed.

12. Create the new tidydataset by calculating the mean for each `activity` and `subject`. The new tidy data is call `testtraintidydata`.

13. Write and saving the new tidydataset.
  

