# September 26 dplyr joins

# mutate joins - includes variables from both sides

# If not installed, install the package
if (!requireNamespace("dplyr", quietly = TRUE)) {
    install.packages("dplyr")
}

# Loads library
library(dplyr)

# get sample data
student_df <- read.csv("SEPT_26/STUDENT.csv", header = TRUE, na.strings = "")
grade_df <- read.csv("SEPT_26/GRADE.csv", header = TRUE, na.strings = "")
course_df <- read.csv("SEPT_26/COURSE.csv", header = TRUE, na.strings = "")

# mutate joins - includes variables from both sides
## stu_grades <- student_df %>% inner_join(grade_df) # nolint

# by default, joins by common field but field can be specified
# (with same field name)
stu_grades <- student_df %>% inner_join(grade_df, by = "ID")


# combining fields with different names
## all_grades <- stu_grades %>% inner_join(course_df, by = join_by("CourseNum" == "CourseNumber")) # nolint

# or
all_grades <- stu_grades %>% inner_join(course_df, c("CourseNum" = "CourseNumber"))

# left join - includes variables for ws from LHS and only rows
# that match from RHS
all_students <- student_df %>% left_join(grade_df, by = "ID")
# see also right_join and full_join

# filter joins returns LHS variables
# anti join returns LHS with no match on RHS
non_reg_students <- student_df %>% anti_join(grade_df, by = "ID")

#semi join returns LHS variable for rows that have match on RHS
reg_students <- student_df %>% semi_join()(grade_df, by = "ID")
