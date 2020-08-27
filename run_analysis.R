# Load libraries
library(dplyr)
library(readr)

# Appropriately label the data set with descriptive variable names
# Take a vector of variables and make it more readable
clean_vars <- function(file){
  vars <- scan(file, character(), sep="\n")
  # Remove the numbers in front
  vars <- sub("^[0-9]{1,} ", "", vars)
  # Make them more readable
  vars <- sub("^t(.*)", "time\\1", vars)
  vars <- sub("^f(.*)", "frequency\\1", vars)
  vars <- sub("(-[XYZ])", "_\\1_axis", vars)
  # # Remove the end parentheses
  vars <- sub("\\(\\)", "", vars)

  vars <- tolower(vars)

  vars <- sub("body", "_body", vars)
  # WARNING: We assumed BodyBody was a mistake in the features labels
  vars <- sub("bodybody", "_body", vars) # Remove this line if we were wrong
  vars <- sub("acc", "_acceleration", vars)
  vars <- sub("gyro", "_gyroscope", vars)
  vars <- sub("gravity", "_gravity", vars)
  vars <- sub("jerk", "_jerk", vars)
  vars <- sub("mag", "_magnitude", vars)

  vars <- sub("std", "_standard_deviation", vars)
  vars <- sub("mad", "_median_absolute_deviation", vars)
  vars <- sub("sma", "_signal_magnitude_area", vars)
  vars <- sub("iqr", "_interquartile_range", vars)
  vars <- sub("arcoeff", "_autorregresion_coefficients", vars)
  vars <- sub("maxinds", "_max_magnitude_index", vars)
  vars <- sub("meanfreq", "_mean_frequency", vars)
  vars <- sub("bandsenergy", "_energy_bands", vars)

  # last cleanups
  vars <- gsub("-", "_", vars)
  vars <- gsub("__", "_", vars)
}

# Get the variable names for column names
variables <- clean_vars("data/features.txt")

# Get the activities key for future labelling
# c("WALKING", ...)
activities_key <- scan("data/activity_labels.txt", character(), sep="\n")
activities_key <- gsub("[0-9]{1,} ", "", activities_key)

clean_dataset <- function(file){
  # Get the activities
  activities_file <- gsub("X","y", file)
  activities <- scan(activities_file, numeric(), sep="\n")
  # We use the activities key to get the correct labels
  activities <- activities_key[activities]

  subject_file <- gsub("X", "subject", file)
  subject_ids <- scan(subject_file, numeric(), sep="\n")

  # Now we read the data file
  data <- read_table(file, col_names = variables) %>%
    # We add the activities column
    mutate(activity = activities) %>%
    mutate(subject = subject_ids) %>%
    # We extract only the mean and standard deviation measurements
    select(contains("mean"), contains("standard_deviation"), activity, subject, -contains("angle"))
}

# Get the clean datasets
train <- clean_dataset("data/train/X_train.txt")
test  <- clean_dataset("data/test/X_test.txt")

# Merge the training and the test sets to create one data set
merged <- full_join(train, test) %>%
  group_by(activity, subject)

# averages <- summarise(merged)
averages <- aggregate(merged, list(activity = merged$activity, subject = merged$subject), mean)
# We remove the last two columns as they are redundant
averages <- averages[1:(length(averages)-2)]
# From the data set in step 4, creates a second,
# independent tidy data set with the average of
# each variable for each activity and each subject

write.table(averages, file = "tidy_dataset.csv")

View(read.table("tidy_dataset.csv"))
