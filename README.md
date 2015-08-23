# PROJECT_Getting-CleaningData
Project Submission for Getting &amp; Cleaning Data

As per Project Instructions, the code was constructed step by step. Please see below for explanation of each part.

features <- read.table("features.txt", stringsAsFactors = FALSE) 
THIS LINE READS THE FEATURES.TXT FILE WITH CONDITION STRINGSASFACTORS AS FALSE

x <- rbind(X_test, X_train) # 10299 x 561
y <- rbind(y_test, y_train) # 10299 x 1
subject <- rbind(subject_test,subject_train) # 10299 x 1
body_acc_x <- rbind(body_acc_x_test, body_acc_x_train) # 10299 x 128
body_acc_y <- rbind(body_acc_y_test, body_acc_y_train) # 10299 x 128
body_acc_z <- rbind(body_acc_z_test, body_acc_z_train) # 10299 x 128
body_gyro_x <- rbind(body_gyro_x_test, body_gyro_x_train) # 10299 x 128
body_gyro_y <- rbind(body_gyro_y_test, body_gyro_y_train) # 10299 x 128
body_gyro_z <- rbind(body_gyro_z_test, body_gyro_z_train) # 10299 x 128
total_acc_x <- rbind(total_acc_x_test, total_acc_x_train) # 10299 x 128
total_acc_y <- rbind(total_acc_y_test, total_acc_y_train) # 10299 x 128
total_acc_z <- rbind(total_acc_z_test, total_acc_z_train) # 10299 x 128
THE CODE LINES ABOVE COMBINE THE TEST AND TRAIN DATA INTO A SINGLE DATA SET FOR DIFFERENT VARIABLES

final_df <- cbind(x,y, subject, body_acc_x, body_acc_y, body_acc_z, body_gyro_x, body_gyro_y, body_gyro_z, total_acc_x, total_acc_y, total_acc_z)
THE CODE LINE ABOVE COMBINES ALL THE DIFFERENT DATA SETS INTO A SINGLE TABLE 
ANSWER FOR PART 1 OF PROJECT


featnames <- features[,2]
names(final_df) <- featnames
THE CODE ABOVE APPROPRIATELY NAMES VARIABLES BASED ON THE VARIABLE NAMES FROM FEATURES.TXT
ANSWER FOR PART 4 OF PROJECT

mean_vect <- grep("mean",featnames)
std_vect <- grep("std",featnames)
meanstd <- c(mean_vect, std_vect) 
meanstd_df <- data.frame(meanstd)
meanstd_arg <- arrange(meanstd_df, meanstd)
meanstd_list <- as.list(meanstd_arg)
final_mod <- final_df[,c(meanstd_list$meanstd,562,563)] #SUBSET part 2
THE CODE ABOVE IDENTIFIES AND STORES THE INDEXES OF VARIABLES WITH 'MEAN' AND 'STD' AS PART OF THEIR NAMES. THE INDEXES ARE COMBINED INTO A SINGLE DATA SET.
FINAL_MOD IS THE SUBSET AS PER PART 2 OF PROJECT

names(final_mod)[80] <- "V1"
names(final_mod)[81] <- "Subject"
final_mod2 <- arrange(join(final_mod,activity_labels),V1) #Add Activity Labels
THE CODE ABOVE COMBINES/ JOINS THE ACTIVITY LABELS AND FINAL_MOD TABLES BASED ON KEY: V1. DESCRIPTIVE NAMES ARE ADDED FOR EACH ROW.
ANSWER FOR PART 3 OF PROJECT

names(final_mod2)[82] <- "Activity"
FINAL_CLEAN_DATA <- final_mod2 %>% group_by(Activity, Subject) %>% summarise_each(funs(mean))
print(FINAL_CLEAN_DATA)

THE CODE ABOVE GROUPS THE DATA IN FINAL_MOD2 BY ACTIVITY AND SUBJECT AND SUMMARIZES THE MEAN OF EACH VARIABLE.
ANSWER FOR PART 5 OF PROJECT
