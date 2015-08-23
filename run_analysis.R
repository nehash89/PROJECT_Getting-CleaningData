#Project Script

#X_test <- read.table("X_test.txt")
#X_train <- read.table("X_train.txt")
features <- read.table("features.txt", stringsAsFactors = FALSE)

#PART 1 (Merges the training and the test sets to create one data set)
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

final_df <- cbind(x,y, subject, body_acc_x, body_acc_y, body_acc_z, body_gyro_x, body_gyro_y, body_gyro_z, total_acc_x, total_acc_y, total_acc_z)

# PART 4 (Appropriately labels the data set with descriptive variable names)

featnames <- features[,2]
names(final_df) <- featnames

# PART 2 (Extracts only the measurements on the mean and standard deviation for each measurement)

mean_vect <- grep("mean",featnames)
std_vect <- grep("std",featnames)
meanstd <- c(mean_vect, std_vect) 
meanstd_df <- data.frame(meanstd)
meanstd_arg <- arrange(meanstd_df, meanstd)
meanstd_list <- as.list(meanstd_arg)
final_mod <- final_df[,c(meanstd_list$meanstd,562,563)] #SUBSET part 2

# PART 3 (Uses descriptive activity names to name the activities in the data set)

names(final_mod)[80] <- "V1"
names(final_mod)[81] <- "Subject"

final_mod2 <- arrange(join(final_mod,activity_labels),V1) #Add Activity Labels

# PART 5 (From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject)
names(final_mod2)[82] <- "Activity"

FINAL_CLEAN_DATA <- final_mod2 %>% group_by(Activity, Subject) %>% summarise_each(funs(mean))

print(FINAL_CLEAN_DATA)
