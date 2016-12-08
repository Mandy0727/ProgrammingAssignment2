## Loop functions

# lapply: 1) a list x; 2) a function FUN; 3) other arguments via ...
# lapply always returns a list
x <- list(a = 1:5, b = rnorm(10))
lapply(x, mean)

x <- list(a = 1:4, b = rnorm(10), c = rnorm(20, 1), d = rnorm(100, 5))
lapply(x, mean)

x <- 1:4
lapply(x, runif)

lapply(x, runif, min = 0, max = 10)

# lapply make heavy use of anonymous functions
x <- list(a = matrix(1:4, 2, 2), b = matrix(1:6, 3, 2))
x

lapply(x, function(elt) elt[,1]) # extract the first column of each matrix

# sapply: simplify the result of lapply
x <- list(a = 1:4, b = rnorm(10), c = rnorm(20, 1), d = rnorm(100, 5))
lapply(x, mean)

sapply(x, mean)

# apply: little typing
str(apply)

x <- matrix(rnorm(200), 20, 10)
apply(x, 2, mean)
apply(x, 1, sum)
apply(x, 1, quantile, probs = c(0.25, 0.75))

# apply: average matrix in an array
a <- array(rnorm(2 * 2 * 10), c(2, 2, 10))
apply(a, c(1, 2), mean) # collapse the third dimension
rowMeans(a, dims = 2)

# mapply: multivariate apply of sorts, can have more argumants
str(mapply)
list(rep(1, 4), rep(2, 3), rep(3, 2), rep(4, 1))

mapply(rep, 1:4, 4:1)

noise <- function(n, mean, sd) {
        rnorm(n, mean, sd)
}

noise(5, 1, 2) # get five random variables with mean 1 and sd 2
noise(1:5, 1:5, 2)

mapply(noise, 1:5, 1:5, 2) # is same as

list(noise(1, 1, 2), noise(2, 2, 2),
     noise(3, 3, 2), noise(4, 4, 2),
     noise(5, 5, 2))

# tapply: apply a function over subsets of a vector
str(tapply)

x <- c(rnorm(10), runif(10), rnorm(10, 1))
f <- gl(3, 10) # create three levels of factor variable, and repeted 10 times
f

tapply(x, f, mean)
tapply(x, f, mean, simplify = F)
tapply(x, f, range)

# split: takes a vector/other objects and splits it into groups determined by a factor
str(split)

split(x, f) # split x factor into three parts
lapply(split(x, f), mean)

# splitting a data frame
library(datasets)
head(airquality)

s <- split(airquality, airquality$Month)
lapply(s, function(x) colMeans(x[,c("Ozone", "Solar.R", "Wind")]))
sapply(s, function(x) colMeans(x[, c("Ozone", "Solar.R", "Wind")]))
sapply(s, function(x) colMeans(x[, c("Ozone", "Solar.R", "Wind")], na.rm = T))

# splitting on more than one level
x <- rnorm(10)
f1 <- gl(2, 5)
f2 <- gl(5, 2)
f1
f2
interaction(f1, f2)
str(split(x, list(f1, f2)))
str(split(x, list(f1, f2), drop = T)) # drop the empty levels


## debugging
# diagnosing the problem
printmessage <- function(x) {
        if(x > 0)
                print("x is greater than zero")
        else
                print("x is less than or equal to zero")
        invisible(x)
}

printmessage(1)
printmessage(NA)

printmessage2 <- function(x) {
        if(is.na(x))
                print("x is a missing value!")
        else if(x > 0)
                print("x is greater than zero")
        else
                print("x is less than or equal to zero")
        invisible(x)
}

x <- log(-1)
printmessage2(NA)


# debugging tools
# traceback
rm(x)
mean(x)
traceback()

lm(y ~ x)
traceback()

# debug
debug(lm)
lm(y ~ x)

# recover
options(error = recover)
read.csv("nosuchfile")


