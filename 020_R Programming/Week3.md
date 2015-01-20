# Week 3 - Loop Functions and Debugging Tools
https://class.coursera.org/rprog-010/lecture

# Loop Functions

## lapply - Loop over a list and evaluate a function on each element
3 args: list x, function FUN, and other args with '...'
returns: always a list

Example 1:
- calculate mean values
- rnorm (randorm deviates), dnorm (density), pnorm (distribution), qnorm (quantile): Normal distribution function
```
> x <- list(a=1:5, b = rnorm(10))
> x
$a
[1] 1 2 3 4 5

$b
 [1] -0.05727401  0.01810299  1.00612248  0.53889119 -0.34095009  1.12265294  0.73648573
 [8]  0.30995761 -2.36051086  0.99903991
```

Example 2: create random uniforms
- runif (random deviates), dunif (density), punif (distribution), qunif (qunatile): Uniform distribution function
```
> x <- 1:4
> lapply (x, runif)
[[1]]
[1] 0.9833959

[[2]]
[1] 0.4325972 0.8130720

[[3]]
[1] 0.7973733 0.4080640 0.8115922

[[4]]
[1] 0.4478592 0.8595638 0.5599153 0.9663238
```
passing other arguments:
lapply (x, runif, min=0, max=10)

Example 3: extract the first column of each matrix
```
> x <- list( a = matrix(1:4, 2, 2), b = matrix (1:6, 3, 2))
> x
$a
     [,1] [,2]
[1,]    1    3
[2,]    2    4

$b
     [,1] [,2]
[1,]    1    4
[2,]    2    5
[3,]    3    6

> extract <- function(x) {
+ x[,1]
+ }
> lapply(x, extract)
$a
[1] 1 2

$b
[1] 1 2 3
```
Or easier: pass an anonymous function
```
> lapply(x, function(element) element[,1])
$a
[1] 1 2

$b
[1] 1 2 3
```

## sapply: same as lapply but try to simplify the result

- Returns a vector if result is a list where every element is length 1
- Returns a matrix if result is a list where every element is a vector with the same length > 1
- In all other cases a list is returned

Example 1:
```
> x <- list(a=1:4, b=rnorm(10))
> lapply(x, mean)
$a
[1] 2.5

$b
[1] 0.07256922

> sapply(x,mean)
         a          b 
2.50000000 0.07256922 
```

Example 2:
- 
- 
```
```


## apply: Apply a function over the margins of an array

Used to evaluate a function over the margins of an array

- not faster than writing a loop, but works in one line
Arguments:

- array/matrix x
- margin
- function FUN

Example 1:
- mean value of each column (1+2+3/3 = 2, 4+5+6/3 = 5)
- sum value of each row (1+4=5, 2+5=7, 3+6=9)
margin with value 2: is the second dimension (=column) of the array
margin with value 1: is the first dimension (=row) of the array
```
> x <- matrix(1:6, 3, 2)
> x
     [,1] [,2]
[1,]    1    4
[2,]    2    5
[3,]    3    6
> apply(x, 2, mean)
[1] 2 5
> apply(x, 1, sum)
[1] 5 7 9
```

[Quantile (wiki)](http://de.wikipedia.org/wiki/Quantil)


Example 2: there are special and faster function for example 1
- colMeans, colSums
- rowMeans, rowSums
```
> colMeans(x)
[1] 2 5
> rowSum(x)
Error: could not find function "rowSum"
> rowSums(x)
[1] 5 7 9
```

Example 3: Quantiles of the rows of a matrix
- calculate the 25% and 75% quantile
```
> x <- matrix(rnorm(6),3,2)
> x
           [,1]       [,2]
[1,]  1.4552037  0.6631910
[2,]  0.9122206 -2.1591226
[3,] -1.0106938 -0.3838641
> apply(x, 1, quantile, probs=c(0.25, 0.75))
         [,1]       [,2]       [,3]
25% 0.8611942 -1.3912868 -0.8539864
75% 1.2572006  0.1443848 -0.5405715
```

Example 4: Average matrix in an array
- input array with 10 matrices with 2 columns and 2 rows, 3rd dimension is 10
- apply: margin covers dimension 1 and 2, 3rd dimension is collapsed
```
> a <- array(rnorm(2 * 2 * 10), c(2, 2, 10))
> a
, , 1

           [,1]       [,2]
[1,]  0.9592367  0.4715349
[2,] -1.0598036 -0.6256314

, , 2

        [,1]       [,2]
[1,] 1.14262  1.3574153
[2,] 2.08659 -0.8004494

, , 3

           [,1]       [,2]
[1,] -0.3821270  0.7328953
[2,] -0.6560154 -1.0380834

, , 4

           [,1]        [,2]
[1,] -0.9139387 -0.07757807
[2,]  0.4121722 -3.12468934

, , 5

            [,1]       [,2]
[1,] -0.07968806 -0.6945397
[2,]  0.12417877 -0.4717492

, , 6

           [,1]      [,2]
[1,] -1.7012498  1.859282
[2,]  0.6207813 -2.004396

, , 7

           [,1]       [,2]
[1,]  0.8513132  0.2827163
[2,] -0.3582679 -2.2034927

, , 8

          [,1]       [,2]
[1,] -0.493894 -0.9950604
[2,]  1.086664  0.7241571

, , 9

           [,1]       [,2]
[1,] -1.2173606 -0.2864506
[2,]  0.1321602  0.3098915

, , 10

           [,1]       [,2]
[1,] -0.1772259 -0.3838337
[2,] -0.7378225 -1.3173119

> apply(a, c(1, 2), mean)
           [,1]       [,2]
[1,] -0.2012315  0.2266382
[2,]  0.1650637 -1.0551755
> rowMeans(a, dims = 2)
           [,1]       [,2]
[1,] -0.2012315  0.2266382
[2,]  0.1650637 -1.0551755
```

## mapply (multi apply): Multivariate version of lapply
Applies a function in parallel over a set of arguments
Arguments: 

- function
- arguments '...' to apply over
- MoreArgs = NULL
- SIMPLIFY = TRUE
- USE.NAMES = TRUE?

Example 1: another way of creating a list
```
> list(rep(1, 4), rep(2, 3), rep(3, 2), rep(4, 1))
[[1]]
[1] 1 1 1 1

[[2]]
[1] 2 2 2

[[3]]
[1] 3 3

[[4]]
[1] 4

> mapply(rep, 1:4, 4:1)
[[1]]
[1] 1 1 1 1

[[2]]
[1] 2 2 2

[[3]]
[1] 3 3

[[4]]
[1] 4
```

Example 2: Instant Vectorization
- alternative to: list(rnorm(1,1,2), rnorm(2,2,2), rnorm(3,3,2), rnorm(4,4,2), rnorm(5,5,2))
```
> mapply(rnorm, 1:5, 1:5, 2)
[[1]]
[1] 3.567136

[[2]]
[1] 1.787073 2.441805

[[3]]
[1] 3.352087 2.196454 2.881562

[[4]]
[1] 4.269124

[[5]]
[1] 1.165838 4.193559

> list(rnorm(1,1,2), rnorm(2,2,2), rnorm(3,3,2), rnorm(4,4,2), rnorm(5,5,2))
[[1]]
[1] 1.319977

[[2]]
[1]  2.827520 -2.110889

[[3]]
[1] 4.999711 2.388916 6.404378

[[4]]
[1] 2.7948734 0.4307937 0.5934768 3.9079354

[[5]]
[1] 1.039455 6.074662 1.586015 6.673763 5.499379
```

## tapply (table apply): Apply a function over subsets of a vector
Arguments:

- vector x
- INDEX is a factor or a list of factors
- FUN = NULL
- other arguments '...' to be passed to FUN
- simplify = TRUE

Example 1: take group means
- gl(): generte factor levels
- 
```
> x <- c(rnorm(10), runif(10), rnorm(10, 1))
> x
 [1] -1.78244603  0.92493019  0.25833363  0.29600133 -0.05043037 -1.80798057  0.09837589
 [8] -1.07656324  0.03970378 -1.20055647  0.71491994  0.60755225  0.31695780  0.49634238
[15]  0.80431805  0.89979507  0.78340489  0.12992125  0.58077107  0.26461665  0.48182093
[22]  0.02673055  0.77043440 -0.82317294  0.11694116  1.99038044  2.06173726  0.33750527
[29]  1.75775230  2.65321510
> f <- gl(3, 10)
> f
 [1] 1 1 1 1 1 1 1 1 1 1 2 2 2 2 2 2 2 2 2 2 3 3 3 3 3 3 3 3 3 3
Levels: 1 2 3
> tapply(x, f, mean)
         1          2          3 
-0.4300632  0.5598599  0.9373344 
> tapply(x, f, mean, simplify = FALSE)
$`1`
[1] -0.4300632

$`2`
[1] 0.5598599

$`3`
[1] 0.9373344
```

Example 2: find group ranges
```
> tapply(x, f, range)
$`1`
[1] -1.8079806  0.9249302

$`2`
[1] 0.1299212 0.8997951

$`3`
[1] -0.8231729  2.6532151
```

## split
Takes a vector or other objects and splits into groups determined by a factor or a list of factors

Arguments:

- x is a vector (or list) or data frame
- f is a factor or a list of factors
- drop = FALSE: indicates whether empty factor levels should be dropped


Example 1:
```
> x <- c(rnorm(10), runif(10), rnorm(10, 1))
> f <- gl(3, 10)
> split(x, f)
$`1`
 [1]  0.02808994  1.15525216  2.27705676  1.65217286 -1.29880524 -0.57914124  0.90117573
 [8]  1.13481075 -0.25923030  0.08552581

$`2`
 [1] 0.230297994 0.493372772 0.008448331 0.095933177 0.430913523 0.306082812 0.991966885
 [8] 0.301652256 0.450236074 0.043078022

$`3`
 [1]  0.45358228  1.37851299  0.98951037  0.98477592 -0.08896936  0.96684831  0.28703471
 [8]  0.68550977  1.99357674 -0.08123973
```

Example: common idiom is split followed by an lapply
```
> lapply(split(x, f), mean)
$`1`
[1] 0.5096907

$`2`
[1] 0.3351982

$`3`
[1] 0.7569142
```

Example: splitting on more than one level
```
> x <- rnorm(10)
> f1 <- gl(2, 5)
> f2 <- gl(5 ,2)
> f1
 [1] 1 1 1 1 1 2 2 2 2 2
Levels: 1 2
> f2
 [1] 1 1 2 2 3 3 4 4 5 5
Levels: 1 2 3 4 5
> interaction(f1, f2)
 [1] 1.1 1.1 1.2 1.2 1.3 2.3 2.4 2.4 2.5 2.5
Levels: 1.1 2.1 1.2 2.2 1.3 2.3 1.4 2.4 1.5 2.5

> str(split(x, list(f1, f2))) # here list() does the interaction
List of 10
 $ 1.1: num [1:2] 0.224 -0.151
 $ 2.1: num(0) 
 $ 1.2: num [1:2] 2.43 -1.06
 $ 2.2: num(0) 
 $ 1.3: num 2.11
 $ 2.3: num -0.859
 $ 1.4: num(0) 
 $ 2.4: num [1:2] 1.348 -0.487
 $ 1.5: num(0) 
 $ 2.5: num [1:2] 0.0817 -0.2054
```
 
Example: drop emtpy levels
```
> str(split(x, list(f1, f2), drop = TRUE))
List of 6
 $ 1.1: num [1:2] 0.224 -0.151
 $ 1.2: num [1:2] 2.43 -1.06
 $ 1.3: num 2.11
 $ 2.3: num -0.859
 $ 2.4: num [1:2] 1.348 -0.487
 $ 2.5: num [1:2] 0.0817 -0.2054
```


Example: 
```

```


Example: 
```

```

# Debugging Tools


## diagnosing the problem
Indications that something's not right. There are 3 conditions: message, warning, error

- message
- warning
- error
- condition: a generic concept for indicating that something unexpected can occur; programmers can create their own conditions

Example: Warning
```
> log(-1)
[1] NaN
Warning message:
In log(-1) : NaNs produced

```

Example: 
- invisible(x): return x without printing x
```
> printmessage <- function(x) {
+ if ( x > 0) print("x > 0")
+ else print("x<=0")
+ invisible(x)
+ }
> printmessage(10)
[1] "x > 0"
> printmessage(0)
[1] "x<=0"
> printmessage(NA)
Error in if (x > 0) print("x > 0") else print("x<=0") : 
  missing value where TRUE/FALSE needed
```

Example: consider NAs
```
> printmessage2 <- function(x) {
+ if (is.na(x)) print("x is a missing value!")
+ else if (x>0) print("x > 0")
+ else print(x <= 0)
+ invisible(x)
+ }
> x <- log(-1)
Warning message:
In log(-1) : NaNs produced
> printmessage2(x)
[1] "x is a missing value!"
```

## Basic Tools

The primary tools for debugging functions in R are:

- traceback: prints out the function call stack after an error occurs
- debug: flags a function for 'debug' mode which allows you to step through execution of a function one line at a time
- browser: suspends the execution of a function wherever it is called and puts the function in debug mode
- trace: allows you to insert debugging code into a function a specific places
- recover: allows you to modify the error behavior so that you can browse the function call stack


Example: 
```

```

Example: 
```

```

Example: 
```

```

## Using the Tools

Example: traceback needs to be called after the most recent error occurs!
```
> mean(xyz)
Error in mean(xyz) : object 'xyz' not found
> traceback()
1: mean(xyz)
```

Example: traceback
```
> lm(y - x)
Error in formula.default(object, env = baseenv()) : invalid formula
> traceback()
9: stop("invalid formula")
8: formula.default(object, env = baseenv())
7: formula(object, env = baseenv())
6: as.formula(formula)
5: model.frame.default(formula = y - x, drop.unused.levels = TRUE)
4: stats::model.frame(formula = y - x, drop.unused.levels = TRUE)
3: eval(expr, envir, enclos)
2: eval(mf, parent.frame())
1: lm(y - x)
```

Example: debug
```
> debug(lm)
> lm(y - x)
debugging in: lm(y - x)
debug: { # first prints out the source code
    ret.x <- x
    ret.y <- y
    cl <- match.call()
    ...
    if (!qr) 
        z$qr <- NULL
    z
}
Browse[2]> n
debug: ret.x <- x
Browse[2]> n
debug: ret.y <- y
Browse[2]> n
debug: cl <- match.call()
Browse[2]> n
debug: mf <- match.call(expand.dots = FALSE)
Browse[2]> n
debug: m <- match(c("formula", "data", "subset", "weights", "na.action", 
    "offset"), names(mf), 0L)
Browse[2]> n
debug: mf <- mf[c(1L, m)]
Browse[2]> n
debug: mf$drop.unused.levels <- TRUE
Browse[2]> n
debug: mf[[1L]] <- quote(stats::model.frame)
Browse[2]> n
debug: mf <- eval(mf, parent.frame())
Browse[2]> n
Error in formula.default(object, env = baseenv()) : invalid formula

> undebug(lm)
```

undebug function like 'undebug(lm)'

Example: recover
```
> options(error = recover) # set on global level
> read.csv("nosuchfile")
Error in file(file, "rt") : cannot open the connection
In addition: Warning message:
In file(file, "rt") :
  cannot open file 'nosuchfile': No such file or directory

Enter a frame number, or 0 to exit   

1: read.csv("nosuchfile")
2: read.table(file = file, header = header, sep = sep, quote = quote, dec = dec, fill = fill, 
3: file(file, "rt")

Selection: 
```


Example:
```

```

Example:
```

```

Example:
```

```


