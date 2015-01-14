# Quiz
https://class.coursera.org/rprog-010/quiz

## Programming questions Q11 until Q20

Q11 - In the dataset provided for this Quiz, what are the column names of the dataset?

data <- read.csv("hw1_data.csv")
colnames(data)

Q12 - Extract the first 2 rows of the data frame and print them to the console. What does the output look like?

data[1:2,]


Q13 - How many observations (i.e. rows) are in this data frame?

nrow(data)

Q14 - Extract the last 2 rows of the data frame and print them to the console. What does the output look like?

data[(nrow(data)-1):nrow(data),]


Q14 - What is the value of Ozone in the 47th row? 

data[47, "Ozone"]


Q16 - How many missing values are in the Ozone column of this data frame?

ozondata <- data[, "Ozone"]
good <- complete.cases(ozondata)
length(ozondata[!good])

Q17 - What is the mean of the Ozone column in this dataset? Exclude missing values (coded as NA) from this calculation.

mean(ozondata[good])

Q18 - Extract the subset of rows of the data frame where Ozone values are above 31 and Temp values are above 90. What is the mean of Solar.R in this subset?

mean(subset(data, Ozone > 31 & Temp >90)[,"Solar.R"])

In case data is a matrix use which() function since it is 10x faster: http://stackoverflow.com/a/7260214

Q19 - What is the mean of "Temp" when "Month" is equal to 6? 

mean(subset(data, Month == 6)[, 'Temp'])

Q20 - What was the maximum ozone value in the month of May (i.e. Month = 5)?

ozondata_may <- subset(data, Month == 5)[, 'Ozone']
good <- complete.cases(ozondata_may)
max(ozondata_may[good])


