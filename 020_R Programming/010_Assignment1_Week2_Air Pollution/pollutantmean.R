pollutantmean <- function(directory, pollutant, id = 1:332) {
        ## 'directory' is a character vector of length 1 indicating
        ## the location of the CSV files
        
        ## 'pollutant' is a character vector of length 1 indicating
        ## the name of the pollutant for which we will calculate the
        ## mean; either "sulfate" or "nitrate".
        
        ## 'id' is an integer vector indicating the monitor ID numbers
        ## to be used
        
        ## Return the mean of the pollutant across all monitors list
        ## in the 'id' vector (ignoring NA values)
        
        pollutants <- vector()
        for (name in id) {
                path <- if (name < 10) {
                                paste(directory, '/', '00', name, '.csv', sep = '')
                        } else if (name < 100) {
                                paste(directory, '/', '0', name, '.csv', sep = '')
                        } else {
                                paste(directory, '/', name, '.csv', sep = '')
                        }
                data <- read.csv(path)
                column_data <- data[, pollutant]
                pollutants <- c(pollutants, column_data)
        }
        mean(pollutants, na.rm = TRUE)
}