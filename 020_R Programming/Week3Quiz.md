# Quiz
https://class.coursera.org/rprog-010/quiz

https://de.wikipedia.org/wiki/Portal:Statistik/Datensaetze#Iris
https://en.wikipedia.org/wiki/Iris_flower_data_set

## Q1
Take a look at the 'iris' dataset that comes with R. The data can be loaded with the code: 

```
library(datasets)
data(iris)

```
A description of the dataset can be found by running 
```
?iris
```
There will be an object called 'iris' in your workspace. In this dataset, what is the mean of 'Sepal.Length' for the species virginica? (Please only enter the numeric result and nothing else.)
```
> virginica <- subset(iris, Species == 'virginica')[,1]
> virginica
 [1] 6.3 5.8 7.1 6.3 6.5 7.6 4.9 7.3 6.7 7.2 6.5 6.4 6.8 5.7 5.8 6.4 6.5 7.7
[19] 7.7 6.0 6.9 5.6 7.7 6.3 6.7 7.2 6.2 6.1 6.4 7.2 7.4 7.9 6.4 6.3 6.1 7.7
[37] 6.3 6.4 6.0 6.9 6.7 6.9 5.8 6.8 6.7 6.7 6.3 6.5 6.2 5.9
> mean(virginica)
[1] 6.588
```

## Q2
Continuing with the 'iris' dataset from the previous Question, what R code returns a vector of the means of the variables 'Sepal.Length', 'Sepal.Width', 'Petal.Length', and 'Petal.Width'?

```
apply(iris[, 1:4], 2, mean)
```

## Q3
Load the 'mtcars' dataset in R with the following code 
```
library(datasets)
data(mtcars)
```
There will be an object names 'mtcars' in your workspace. You can find some information about the dataset by running 
```
?mtcars
```
How can one calculate the average miles per gallon (mpg) by number of cylinders in the car (cyl)?
```
> sapply(split(mtcars$mpg, mtcars$cyl), mean)
       4        6        8 
26.66364 19.74286 15.10000

# solution 2
> with(mtcars, tapply(mpg, cyl, mean))
       4        6        8 
26.66364 19.74286 15.10000 

# solution 3
> tapply(mtcars$mpg, mtcars$cyl, mean)
       4        6        8 
26.66364 19.74286 15.10000 

```

Another manual calculation found here:
- http://wiener.math.csi.cuny.edu/Statistics/R/simpleR/stat019.html
```
> attach(mtcars)
> mean(mpg[cyl == 4])
[1] 26.66364

```

## Q4
Continuing with the 'mtcars' dataset from the previous Question, what is the amean(mtcars[mtcars$cyl == "8",]$hp)?
```
> mean(mtcars[mtcars$cyl == "8",]$hp) - mean(mtcars[mtcars$cyl == "4",]$hp)
[1] 126.5779
```

```

```

## Q5
If you run 
```
debug(ls)
```
what happens when you next call the 'ls' function?
```
Execution of 'ls' will suspend at the beginning of the function and you will be in the browser.
```
