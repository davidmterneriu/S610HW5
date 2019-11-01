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