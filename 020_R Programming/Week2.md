# Week 2 - Control Structures,
https://class.coursera.org/rprog-010/lecture

# if-else
https://class.coursera.org/rprog-010/lecture/95

> x <- 2
> y <- if (x < 2) 0 else 1
> y

> y <- if (x < 2) 0
> y
NULL

# for

> for (i in 1:3) print(i)
[1] 1
[1] 2
[1] 3

# for-loop with a vector
https://class.coursera.org/rprog-010/lecture/99

## seq_along creates an integer sequence
> x <- c('a', 'b', 'c', 'd')
> for (i in seq_along(x)) print(x[i])
[1] "a"
[1] "b"
[1] "c"
[1] "d"

analogous to:
> for (i in 1:4) print(x[i])
[1] "a"
[1] "b"
[1] "c"
[1] "d"


## assign elements to a new variable
> for (letter in x) print(letter)
[1] "a"
[1] "b"
[1] "c"
[1] "d"

letter is the index variable with the value of x[i]

## nested loops

> x <- matrix(1:6, 2, 3)
> for (i in seq_len(nrow(x))) {for (j in seq_len(ncol(x))) {print(x[i,j])}}
[1] 1
[1] 3
[1] 5
[1] 2
[1] 4
[1] 6

# while loops
https://class.coursera.org/rprog-010/lecture/101

loop can be infinite depending on condition

count <- 0
> while (count < 3) {print(count); count <- count + 1}
[1] 0
[1] 1
[1] 2

## 'flip coin example'
> z <- 5
> while (z >= 3 && z <= 10) {
+ print(z)
+ coin <- rbinom(1,1,0.5)
+ if (coin == 1) z <- z + 1 else z <- z - 1
+ }
[1] 5
[1] 6
[1] 5
[1] 4
[1] 3

binom() - binomial distribution
https://en.wikipedia.org/wiki/Binomial_distribution
https://de.wikipedia.org/wiki/Binomialverteilung

# repeat, next, break
https://class.coursera.org/rprog-010/lecture/97

## repeat, break

> x0 <- 1
> tol <- 1e-8
> repeat {
+   x1 <- computeEstimate() # function not defined yet
+   if (abs(x1 - x0) < tol) {
+     break
+   } else {
+     x0 <- x1
+   }
+ }

like while the repeat loop can be infinite. it is better to define a hard limit number of iterations


## next
used to skip an iteration of a loop

> for (i in 1:5) {
+   if (i<=3) {
+     next
+   }
+   print(i)
+ }
[1] 4
[1] 5

# R functions
https://class.coursera.org/rprog-010/lecture/79
creation, argument matching, lazy evaluation: 
https://d396qusza40orc.cloudfront.net/rprog/lecture_slides/functions.pdf
more on functions:
https://class.coursera.org/rprog-010/lecture/45

function adding two values:
> add2 <- function(x,y) {
+     x + y
+ }
> 
> add2(2,3)
[1] 5

function filtering values above 10:

> z <- c(1,12,3,10,20,40,5)
> above10 <- function(x) {
+     use <- x > 10
+     x[use]
+ }
> above10(z)
[1] 12 20 40

here use variable contains true/false values

it is similar if you say:
> a <- c(3,4)
> a[c(T,F)]
[1] 3

or:
> above10 <- function(x) {
+     x[x > 10]
+ }
> above10(z)
[1] 12 20 40

define default values (called 'named arguments'):
> above <- function(list, above=10) {
+     list[list > above]
+ }
> above(z)
[1] 12 20 40
> above(z,0)
[1]  1 12  3 10 20 40  5
> above(z,12)
[1] 20 40

## function with matrix, data frame

> columnmean <- function(y) {
+     nc <- ncol(y)
+     # create an empty vector
+     means <- numeric(nc)
+     for (i in 1:nc) {
+         means[i] <- mean(y[,i])
+     }
+     means
+ }
> airquality <- read.csv('hw1_data.csv')
    Ozone Solar.R Wind Temp Month Day
1      41     190  7.4   67     5   1
2      36     118  8.0   72     5   2
3      12     149 12.6   74     5   3
4      18     313 11.5   62     5   4
...
> columnmean(airquality)
[1]        NA        NA  9.957516 77.882353  6.993464 15.803922

remove NAs:
> columnmean <- function(y, removeNA = TRUE) {
+     nc <- ncol(y)
+     # create an empty vector
+     means <- numeric(nc)
+     for (i in 1:nc) {
+         means[i] <- mean(y[,i], na.rm=removeNA)
+     }
+     means
+ }
> columnmean(airquality)
[1]  42.129310 185.931507   9.957516  77.882353   6.993464  15.803922
> columnmean(airquality, F)
[1]        NA        NA  9.957516 77.882353  6.993464 15.803922

## Scoping rules
https://class.coursera.org/rprog-010/lecture/37
https://d396qusza40orc.cloudfront.net/rprog/lecture_slides/scoping_binding.pdf

binding values to a symbol:
> lm <- function(x) {x*x}

here the function is bound to 'lm'

use search() to see the search path where .GlobalEnv is the first and the base package is the last of the search list

including a new package swirl:
> library('swirl')
> search()
 [1] ".GlobalEnv"        "package:swirl"     "tools:rstudio"     "package:stats"    
 [5] "package:graphics"  "package:grDevices" "package:utils"     "package:datasets" 
 [9] "package:methods"   "Autoloads"         "package:base"   

## Lexical Scoping - Function Closure
PDF page 7:
=====
Lexical scoping in R means that the values of free variables are searched for in the environment in which the function was defined.

What is an environment?

- An environment is a collection of (symbol, value) pairs, i.e. x is a symbol and 3.14 might be its value.
- Every environment has a parent environment; it is possible for an environment to have multiple
"children"
- the only environment without a parent is the empty environment
- A function + an environment = a closure or function closure.
=====

## Scoping Rules
https://class.coursera.org/rprog-010/lecture/39
https://d396qusza40orc.cloudfront.net/rprog/lecture_slides/scoping_rules.pdf

a function pow in a scope of another function make.power
also: n is a free variable

> make.power <- function(n) {
+     pow <- function(x) {
+         x^n
+     }
+     pow
+ }
> 
> cube <- make.power(3)
> 
> square <- make.power(2)
> 
> cube(3)
[1] 27
> square(3)
[1] 9

## Lexical vs Dynamic Scoping
> y <- 10
> f <- function(x) {
+     y <- 2
+     y^2 + g(x)
+ }
> g <- function(x) {
+     x * y
+ }
> f(3)
[1] 34


> g <- function(x) {
+     a <- 3
+     x+a+y
+ }
> g(2)
Error in g(2) : object 'y' not found
> y<-3
> g(2)
[1] 8

## Optimization
https://class.coursera.org/rprog-010/lecture/73

log-likelihood:
https://en.wikipedia.org/wiki/Likelihood_function
https://de.wikipedia.org/wiki/Likelihood-Funktion

list free variables of function g():
> ls(environment(g))
[1] "g" "y"

# Coding Standards
https://class.coursera.org/rprog-010/lecture/77
https://d396qusza40orc.cloudfront.net/rprog/lecture_slides/CodingStandard.pdf

- use identing with 8 characters allows to have only 2 nested loops until you reach max length of 80 characters
- limit size of functions, split up function into several logical functions

# Dates and Times
https://class.coursera.org/rprog-010/lecture/43
https://d396qusza40orc.cloudfront.net/rprog/lecture_slides/Dates.pdf

- Date class: dates are stored as the number of days sins 1.1.1970

> as.Date('1970-01-01')
[1] "1970-01-01"
> as.Date('1970-1-1')
[1] "1970-01-01"
> x <- as.Date('1970-01-01')
> unclass(x)
[1] 0
> unclass(as.Date('1970-01-02'))
[1] 1


- POSIXct or POSIXlt class: time is stored as the number of seconds since 1.1.1970

POSIXct is a very large integer and useful to store into a data frame
POSIXlt is a list and stores other useful information

> Sys.time()
[1] "2015-01-13 15:09:07 CET"

> x <- Sys.time()
> p <- as.POSIXlt(x)
> names(unclass(p))
 [1] "sec"    "min"    "hour"   "mday"   "mon"    "year"   "wday"   "yday"   "isdst"  "zone"   "gmtoff"
> unclass(x)
[1] 1421158175

String to date/time conversion
> datestring <- c("January 10, 2012 10:40", "December 9, 2011 13:10")
> x <- strptime(datestring, "%B %d, %Y %H:%M")
> x
[1] "2012-01-10 10:40:00 CET" "2011-12-09 13:10:00 CET"

Operations
> x <- as.Date('2012-01-01')
> y <- strptime("January 10, 2012 10:40", "%B %d, %Y %H:%M")
> x-y
Error in x - y : non-numeric argument to binary operator
In addition: Warning message:
Incompatible methods ("-.Date", "-.POSIXt") for "-" 
> x <- as.POSIXlt(x)
> x-y
Time difference of -9.402778 days





