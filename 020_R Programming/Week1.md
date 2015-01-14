# Week 1 - Data Types, Subsetting
https://class.coursera.org/rprog-010/lecture

# Completed Data Types - Matrices
https://class.coursera.org/rprog-010/lecture/107
https://d396qusza40orc.cloudfront.net/rprog/lecture_slides/matrices.pdf

creation with matrix()-function:
> m <- matrix(1:6, nrow=2, ncol=3)
     [,1] [,2] [,3]
[1,]    1    3    5
[2,]    2    4    6

creation from vectors using dim()-function:
> m <- 1:6
[1] 1 2 3 4 5 6
> dim(m) <- c(2,3)
     [,1] [,2] [,3]
[1,]    1    3    5
[2,]    2    4    6

# Completed Vectorized Operations 
https://class.coursera.org/rprog-010/lecture/41
https://d396qusza40orc.cloudfront.net/rprog/lecture_slides/Vectorized.pdf

matrix multiplication using %*%-operator
https://de.wikipedia.org/wiki/Matrizenmultiplikation

> x <- matrix(1:6, 2,3)
> x
     [,1] [,2] [,3]
[1,]    1    3    5
[2,]    2    4    6
> y <- matrix(c(10,20,30,40,50,60), 3,2)
> y
     [,1] [,2]
[1,]   10   40
[2,]   20   50
[3,]   30   60
> x %*% y
     [,1] [,2]
[1,]  220  490
[2,]  280  640
> y %*% x
     [,1] [,2] [,3]
[1,]   90  190  290
[2,]  120  260  400
[3,]  150  330  510

element-wise multiplication 

both matrices needs to be of same size (otherwise error):
> x * y
Error in x * y : non-conformable arrays
> y*x
Error in y * x : non-conformable arrays

> x<-matrix(1:4,2,2);y<-matrix(rep(10,4),2,2)
> x
     [,1] [,2]
[1,]    1    3
[2,]    2    4
> y
     [,1] [,2]
[1,]   10   10
[2,]   10   10
> x*y
     [,1] [,2]
[1,]   10   30
[2,]   20   40
> y*x
     [,1] [,2]
[1,]   10   30
[2,]   20   40

# swirl
Interactive way to learn R

http://swirlstats.com

Trainin materials: https://github.com/swirldev/swirl_courses

- listing variables: ls()
- remove variables from working directory: rm(list=ls()) 

Some functions:
| You can exit swirl and return to the R prompt (>) at any time by pressing the Esc key. If you are already
| at the prompt, type bye() to exit and save your progress. When you exit properly, you'll see a short
| message letting you know you've done so.

| When you are at the R prompt (>):
| -- Typing skip() allows you to skip the current question.
| -- Typing play() lets you experiment with R on your own; swirl will ignore what you do...
| -- UNTIL you type nxt() which will regain swirl's attention.
| -- Typing bye() causes swirl to exit. Your progress will be saved.
| -- Typing main() returns you to swirl's main menu.
| -- Typing info() displays these options again.

Help:
| If at any point you'd like more information on a particular topic related to R, you can type help.start()
| at the prompt, which will open a menu of resources (either within RStudio or your default web browser,
| depending on your setup). Alternatively, a simple web search often yields the answer you're looking for.

