# run_analysis.R

# الخطوة 1: تحميل الحزم المطلوبة
library(dplyr)
library(tidyr)

# الخطوة 2: قراءة البيانات وتحميلها
# قراءة أسماء الميزات وأنشطة التسميات
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("id", "name"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("id", "activity"))

# قراءة بيانات التدريب
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
X_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$name)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "activity")

# قراءة بيانات الاختبار
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
X_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$name)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "activity")

# الخطوة 3: دمج مجموعات البيانات
# دمج البيانات الأفقية لكل من التدريب والاختبار
train_data <- cbind(subject_train, y_train, X_train)
test_data <- cbind(subject_test, y_test, X_test)

# دمج البيانات العمودية للتدريب والاختبار
merged_data <- rbind(train_data, test_data)

# الخطوة 4: استخراج المتوسط والانحراف المعياري
selected_cols <- grep("mean\\(\\)|std\\(\\)", features$name)
extracted_data <- merged_data %>% select(subject, activity, all_of(selected_cols + 2))

# الخطوة 5: تسمية الأنشطة الوصفية
extracted_data$activity <- factor(extracted_data$activity, 
                                  levels = activities$id, 
                                  labels = activities$activity)

# الخطوة 6: تسمية المتغيرات بشكل وصفي
names(extracted_data) <- gsub("^t", "Time", names(extracted_data))
names(extracted_data) <- gsub("^f", "Frequency", names(extracted_data))
names(extracted_data) <- gsub("Acc", "Accelerometer", names(extracted_data))
names(extracted_data) <- gsub("Gyro", "Gyroscope", names(extracted_data))
names(extracted_data) <- gsub("Mag", "Magnitude", names(extracted_data))
names(extracted_data) <- gsub("\\.mean\\.\\.", "Mean", names(extracted_data))
names(extracted_data) <- gsub("\\.std\\.\\.", "Std", names(extracted_data))
names(extracted_data) <- gsub("\\.", "", names(extracted_data))

# الخطوة 7: إنشاء مجموعة البيانات التلخيصية
tidy_data <- extracted_data %>%
  group_by(subject, activity) %>%
  summarise(across(everything(), mean), .groups = "drop")

# حفظ البيانات المنظمة
write.table(tidy_data, "tidy_data.txt", row.names = FALSE)