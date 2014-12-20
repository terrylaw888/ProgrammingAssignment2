test_df <- read.table("./UCI HAR Dataset/test/X_test.txt")
train_df <- read.table("./UCI HAR Dataset/train/X_train.txt")
test_labels <- read.table("./UCI HAR Dataset/test/y_test.txt")
train_labels <- read.table("./UCI HAR Dataset/train/y_train.txt")
labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
test_sub <- read.table("./UCI HAR Dataset/test/subject_test.txt")
train_sub <- read.table("./UCI HAR Dataset/train/subject_train.txt")

train_labels <- merge(train_labels, labels, by.x = "V1", by.y = "V1", sort = FALSE)
test_labels <- merge(test_labels, labels, by.x = "V1", by.y = "V1", sort = FALSE)
test_labels$V3 <- test_sub$V1
train_labels$V3 <- train_sub$V1
comb_labels <- rbind(test_labels,train_labels)

comb_df <- rbind(test_df,train_df)
temp1 <- read.table("./UCI HAR Dataset/features.txt")
temp1 <- temp1[,2]
colnames(comb_df) <- temp1

comb_df$subject <- comb_labels$V3
comb_df$activity_name <- comb_labels$V2

z <- grep("mean()", fixed = TRUE, colnames(comb_df))
j <- grep("std()", fixed = TRUE, colnames(comb_df))
n <- grep("activity_name", fixed = TRUE, colnames(comb_df))
s <- grep("subject", fixed = TRUE, colnames(comb_df))
comb_df2 <- comb_df[,sort(c(z,j,n,s))]

comb_df3 <- aggregate(comb_df2[,1:(ncol(comb_df2)-2)], by = list(subject=comb_df2$subject, activity_name=comb_df2$activity_name), mean)

write.table(comb_df3, file = "./Project.txt", row.names = FALSE)