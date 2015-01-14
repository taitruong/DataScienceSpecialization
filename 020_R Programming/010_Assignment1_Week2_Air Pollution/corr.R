corr <- function(directory, threshold = 0) {
        ## 'directory' is a character vector of length 1 indicating
        ## the location of the CSV files
        
        ## 'threshold' is a numeric vector of length 1 indicating the
        ## number of completely observed observations (on all
        ## variables) required to compute the correlation between
        ## nitrate and sulfate; the default is 0
        
        ## Return a numeric vector of correlations
        
        result <- vector()
        row <- 1
        for (name in 1:332) {
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
                if (row_number >= threshold) {
                        corValue = cor(cleaned$sulfate, cleaned$nitrate)
                        if (!is.na(corValue)) result <- c(result, corValue)
                }
        }
        result
}