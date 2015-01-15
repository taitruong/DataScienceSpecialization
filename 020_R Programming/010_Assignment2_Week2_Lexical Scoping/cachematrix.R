## This matrix implementation is similar to the vector approach as described here:
## https://github.com/AlienSource/ProgrammingAssignment2/blob/master/README.md
## There are two functions:
## - makeCacheMatrix(x): creates and returns a special matrix based on matrix x
## - cacheSolve(x): returns an inversed matrix based on the special matrix x
## Also have a look at the test function testMatrix() below. This function
## creates a matrix and does various calls and tests on:
## makeCacheMatrix() and cacheSolve()

## For executing use this two lines in your R console:
## > source('cachematrix.R')
## > testMatrix()

## The returned special matrix has the following operations:
## - x$set(x): sets a new matrix
## - x$get(): returns the matrix
## - x$setinverse(newinverse): sets/caches a new inversed matrix
## - x$getinverse(): returns the inversed/cached matrix
##
makeCacheMatrix <- function(x = matrix()) {
        inversematrix <- NULL
        ## getter and setter for matrix
        # define set function
        set <- function(newmatrix) {
                x <<- newmatrix
                #reset inversed matrix
                inversematrix <<- NULL
        }
        # define get function
        get <- function() x
        
        ## getter and setter for inverse matrix
        # define setinverse function
        setinverse <- function(newinverse) {
                inversematrix <<- newinverse
        }
        # define getinverse function
        getinverse <- function() inversematrix
        
        # return special matrix object with the defined functions
        list(set = set, get = get, setinverse = setinverse, getinverse=getinverse)
}

## Input argument x is a special matrix.
## To create a special matrix just call makeCacheMatrix(anymatrix)
## Output/returned value is an inversed matrix based on the special matrix x
cacheSolve <- function(x, ...) {
        ## Return a matrix that is the inverse of 'x'
        
        # first check whether there is already a cached inversed matrix?
        inversematrix <- x$getinverse()
        # no? inverse and cache matrix then
        if (is.null(inversematrix)) {
                message("solving and return inversed matrix")
                inversematrix <- solve(x$get(), ...)
                x$setinverse(inversematrix)
        } else {
                message("returning cached inversed matrix")
        }
        # return the result
        inversematrix
}

## Tests a simple matrix:
##       [,1]  [,2]
## [1,]  1.00 -0.25
## [2,] -0.25  1.00
testMatrix <- function() {
        matrix <- rbind(c(1, -1/4), c(-1/4, 1))
        print("Testing matrix:")
        print(matrix)
        test(matrix)
}

## main test function
test <- function(x) {
        if (is.null(x)) {
                message("matrix cannot be null: ", x)
                return()
        }
        specialMatrix <- makeCacheMatrix(x)
        ## testing get function contains same matrix x?
        if (!all(specialMatrix$get() == x)) {
                message("Error in get(): cached matrix ", specialMatrix$get(), " != ", x)
                return()
        }
        ## testing set function
        specialMatrix$set(x)
        if (!all(specialMatrix$get() == x)) {
                message("Error in set(): cached matrix ", specialMatrix$get(), " != ", x)
                return()
        }
        
        ## testing getinverse function
        if (!is.null(specialMatrix$getinverse())) {
                message("getinverse() is initially not empty: ", specialMatrix$getinverse())
        }
        
        ## implicitly testing setinverse() function by using cacheSolve() function
        ## calling cacheSolve() the first time sets/caches the inversed matrix
        inversematrix <- cacheSolve(specialMatrix)
        if (is.null(specialMatrix$getinverse())) {
                message("Error in cacheSolve(): cached inversed matrix is null: ",
                        specialMatrix$getinverse())
                return()
        }
        if (!all(specialMatrix$getinverse() == inversematrix)) {
                message("Error in cacheSolve(): cached inversed matrix ",
                        specialMatrix$getinverse(), " != ", inversematrix)
                return()
        }
        
        ## finally test whether the inversed matrix is correct compared to solve(x)
        if (!all(solve(x) == inversematrix)) {
                message("Inversed matrix is not correct! Expected: ",
                        inversematrix, " actual: ", specialMatrix$getinverse())
                return()
        }
        
        # test caching by calling cacheSolve() again
        inversematrix2 <- cacheSolve(specialMatrix)
        if (!identical(inversematrix, inversematrix2)) {
                message("Inversed matrix is not cached since the object is not identical!")
        }
}