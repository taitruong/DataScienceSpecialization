add2 <- function(x,y) {
        x + y
}

above10 <- function(x) {
        x[x > 10]
}

above10 <- function(x) {
        use <- x > 10
        x[use]
}

above <- function(list, above=10) {
        list[list > above]
}

columnmean <- function(y, removeNA = TRUE) {
        nc <- ncol(y)
        # create an empty vector
        means <- numeric(nc)
        for (i in 1:nc) {
                means[i] <- mean(y[,i], na.rm=removeNA)
        }
        means
}

# closures

make.power <- function(n) {
        pow <- function(x) {
                x^n
        }
        pow
}

cube <- make.power(3)

square <- make.power(2)

cube(3)
square(3)

# lexical vs dynamic scoping
y <- 10
f <- function(x) {
        y <- 2
        y^2 + g(x)
}
g <- function(x) {
        x * y
}
f(3)


g <- function(x) {
        a <- 3
        x+a+y
}
g(2)
y<-3
g(2)