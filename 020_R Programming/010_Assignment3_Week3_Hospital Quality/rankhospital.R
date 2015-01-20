rankhospital <- function(state, outcome, num = "best") {
        source('best.R')
        # Read data and filter by outcome
        data <- getDataByOutcome(outcome)
        # filter again by state
        data <- getDataByState(data, state)
        # filter finally based on ranking/num
        data <- getRanking(data, num)
        ## Return hospital name in that state with the given rank
        ## 30-day death rate
        data[[1, 1]]
}

getRanking <- function(data, num = "best") {
        rows <- nrow(data)
        # get death rate (column 2) based on num
        deathRate <-
                # if num is numeric then get the data value
                # in row=??? and column=2 (death rate)
                if (is.numeric(num)) {
                        # if num within data rows...
                        if (num > 0 & num <= rows)
                                #set death rate for row=num
                                data[num,2]
                        # else num is greater/outside data rows
                        else
                                NA
                # if num is 'best' then get data from first row
                } else if (num == 'best')
                        # lowest death rate is in row 1
                        data[1,2]
        # if num is worst then...
        else if (num == 'worst')
                # highest death rate is in last row
                data[rows,2]
        # else stop with message 'invalid num'
        else
                stop('invalid num')
        # filter by death rate
        data <- data[data[,2] == deathRate,]
        # sort hospital names (column 1) in alphabetical order
        # tip: sort in descending order with a '-' sign: -order(md[,1])
        data[order(data[,1]),]        
}