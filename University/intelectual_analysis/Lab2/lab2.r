setwd("D:\\Study\\R\\Lab2") # set working directory
library(e1071)

# 1
y <- as.matrix(read.csv("numbers_list.csv"))

# 2
min_max <- range(y)
cat("Minimum element of the sample:", min_max[1], "\n")
cat("Maximum element of the sample:", min_max[2], "\n")

# 3
mean <- mean(y)
cat("Sample mean:", mean(y), "\n")

# 4
median <- median(y)
cat("Median:", median(y), "\n")

# 5
var <- var(y)
sd <- sd(y)
cat("Sample variance:", var(y), "\n")
cat("Standard deviation:", sd(y), "\n")

# 6
vm3 <- 0
for (i in 1:100) vm3 <- vm3 + (y[i] - mean)^3

vm3 <- vm3 / 100
cat("Sample 3rd order moment:", vm3, "\n")

vm4 <- 0
for (i in 1:100) vm4 <- vm4 + (y[i] - mean)^4
vm4 <- vm4 / 100
cat("Sample 4th order moment:", vm4, "\n")

# 7
eks <- kurtosis(y)
cat("Sample excess (kurtosis):", eks, "\n")

# 8
coas <- skewness(y)
cat("Coefficient of skewness:", coas, "\n")


