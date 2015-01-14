complete <- function(directory, id = 1:332) {
        ## 'directory' is a character vector of length 1 indicating
        ## the location of the CSV files
        
        ## 'id' is an integer vector indicating the monitor ID numbers
        ## to be used
        
        ## Return a data frame of the form:
        ## id nobs
        ## 1  117
        ## 2  1041
        ## ...
        ## where 'id' is the monitor ID number and 'nobs' is the
        ## number of complete cases
        
        result <- data.frame(id=numeric(), nobs=integer())
        row <- 1
        for (name in id) {
                # create filename
                path <- if (name < 10) {
                                paste(directory, '/', '00', name, '.csv', sep = '')
                        } else if (name < 100) {
                                paste(directory, '/', '0', name, '.csv', sep = '')
                        } else {
                                paste(directory, '/', name, '.csv', sep = '')
                        }
                # read file
                data <- read.csv(path)
                # remove all rows with empty/NA values
                cleaned <- data[complete.cases(data),]
                # add new row containing id and row number
                row_number <- nrow(cleaned)
                result[row, ] <- c(name, row_number)
                row <- row + 1
        }
        result
}