# مشروع تنقية بيانات النشاط البشري

## الهدف
إعداد بيانات منظمة لتحليل أنشطة بشرية مقاسة بواسطة هواتف ذكية.

## خطوات التنفيذ

### 1. تنزيل البيانات
- البيانات الأصلية: [رابط التنزيل](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
- أنشئ مجلدًا باسم `UCI HAR Dataset` في دليل العمل الحالي.
- ضع الملفات المُنَزَّلة داخل هذا المجلد.

### 2. تثبيت الحزم المطلوبة
```r
install.packages("dplyr")
install.packages("tidyr")
```

### 3. تشغيل البرنامج النصي
- احفظ البرنامج النصي [`run_analysis.R`](run_analysis.R) في نفس الدليل.
- قم بتشغيل البرنامج في R:
```r
source("run_analysis.R")
```

### 4. الملفات الناتجة
- `tidy_data.txt`: البيانات النهائية المنظمة (يمكن قراءتها في R باستخدام `read.table("tidy_data.txt", header = TRUE)`).

## هيكل الملفات
```
├── UCI HAR Dataset/  # البيانات الأصلية
├── run_analysis.R    # البرنامج النصي الرئيسي
├── tidy_data.txt     # المخرجات النهائية
├── README.md         # هذا الملف
└── Codebook.md       # وصف المتغيرات والتحويلات
```

## الاعتمادات
- البيانات من [UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).