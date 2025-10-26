setwd("d:\\Study\\R\\lab4")

data <- read.csv("numbers_list.csv", header = TRUE)
# Вектор значень
x <- data$Value
# Незсунена оцінка математичного сподівання
mu_hat <- mean(x)

# Незсунена оцінка дисперсії
sigma2_hat <- var(x)

cat("Незсунена оцінка Mξ:", mu_hat, "\n")
cat("Незсунена оцінка Dξ:", sigma2_hat, "\n")
