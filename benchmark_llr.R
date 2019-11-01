#benchmark_llr.R
library(microbenchmark)
library(testthat)

source("llr_functions.R")

n = 100
## a very simple regression model
set.seed(123)
x = rnorm(n)
y = rnorm(x + rnorm(n))
z = seq(-1, 1, length.out = 100)

microbenchmark::microbenchmark(llr(x, y, z, omega = 1))%>%print()

#Writing this line after the first commit. I had tried out speeding up my code before using github/git.

#Recordings--------------------

#Baseline: The code as is.  
#Unit: milliseconds
#expr      min      lq     mean   median       uq      max neval
#llr(x, y, z, omega = 1) 16.11788 17.6543 21.00247 18.71356 20.77596 35.98782   100


#Version 2.1: This run uses Wz as a weight vector, performs matrix multiplication through apply and 
# a vectorized version of multiplication. This was my first attempt at question 2, in part because I couldn't
# figure out how to use an apply function on "y" and "Wz" since both were 100x1 vectors.
#Unit: milliseconds
#expr      min      lq     mean   median       uq      max neval
#llr(x, y, z, omega = 1) 11.54054 13.4767 16.29584 14.57949 16.45366 38.88911   100


#Version 2.2: Similar to 2.1 in the use of Wz as a weight vector. The main difference comes down to how 
# I modified Wz %*% y from the original code. I replaced the matrix multiplication with mapply(), which 
# is still in the *apply family.
#Unit: milliseconds
#expr      min       lq     mean   median       uq      max neval
#llr(x, y, z, omega = 1) 21.14342 23.31194 26.66393 25.33751 27.40567 43.17147   100
