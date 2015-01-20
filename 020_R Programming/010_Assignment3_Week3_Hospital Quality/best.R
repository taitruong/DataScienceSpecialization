getDataByOutcome <- function(outcome) {
        ## Read data from csv file
        data <- read.csv('outcome-of-care-measures.csv', colClasses = "character")
        # filter data containing 3 columns:
        # - hospital name,
        # - death rate based on outcome, and
        # - state (useful for rankall function)
        columns <- if (outcome == 'heart attack')
                columns <- c('Hospital.Name', 'Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack', 'State')
        else if (outcome == 'heart failure')
                columns <- c('Hospital.Name', 'Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure', 'State')
        else if (outcome == 'pneumonia')
                columns <- c('Hospital.Name', 'Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia', 'State')
        else
                # invalid outcome - column cannot be identified
                stop('invalid outcome')
        # re-assign data frame with only 3 columns
        data <- data[,columns]
        # convert death rate (column 2) to numeric
        data[,2] <- as.numeric(data[,2])
        # remove rows with NAs in column 2
        data <- data[complete.cases(data[,2]),]
        # stop on invalid state - no rows in data
        if (nrow(data) == 0)
                stop('invalid state')
        # return data
        data
}

getDataByState <- function(data, state) {
        # filter by state
        data <- data[data$State == state, ]
        # remove rows with NAs
        data <- data[complete.cases(data[,2]),]
        # stop on invalid state - no rows in data
        if (nrow(data) == 0)
                stop('invalid state')
        # sort on column 2 (death rate) to have lowest value on top
        data <- data[order(data[,2]),]
        ## Return all data based on state and outcome
        data
}

best <- function(state, outcome) {
        # Read data and filter by outcome
        data <- getDataByOutcome(outcome)
        data <- getDataByState(data, state)
        # take first/lowest value on row 1, column 2 (ordered death rate)
        lowestRate <- data[1,2]
        # based on this filter the data having only lowest rate
        data <- data[data[,2] == lowestRate, ]
        # sort hospital names (column 1) in alphabetical order
        # tip: sort in descending order with a '-' sign: -order(md[,1])
        data <- data[order(data[,1]),]
        ## Return hospital name in that state with lowest 30-day death
        ## rate
        data[[1, 1]]
}