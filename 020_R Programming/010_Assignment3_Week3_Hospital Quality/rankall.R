rankall <- function(outcome, num = "best") {
        source('rankhospital.R')
        # Read data and filter by outcome
        data <- getDataByOutcome(outcome)
        # extract state column and remove deplicates
        states <- data[!duplicated(data['State']),][,'State']
        # order alphabetically
        states <- states[order(states)]
        ## For each state, find the hospital of the given rank
        hospitals <- sapply(states, function(state) {
                # filter again by state
                dataByOutcomeByState <- getDataByState(data, state)
                # get ranking
                dataRanking <- getRanking(dataByOutcomeByState, num)
                # add hospital name
                dataRanking[[1, 1]]
        })
        # create a data frame containing hospitals and states
        data.frame(hospital=hospitals, state=states)
}