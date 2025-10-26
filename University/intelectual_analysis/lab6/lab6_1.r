setwd("d:\\Study\\R\\lab6")
x <- as.matrix(read.csv("numbers_list.csv"))
alphaAvg <- 0.05
alphaVar <- 0.10

avg = mean(x)
var = var(x)
s <- sqrt(var)
n <- length(x)

# ---- 95% довірчий інтервал для середнього  ----
t_crit <- qt(1 - alphaAvg/2, df = n - 1)
margin <- t_crit * s / sqrt(n)
ci_mean <- c(avg - margin, avg + margin)

# ---- 90% довірчий інтервал для дисперсії ----
chi2_low <- qchisq(alphaVar/2, df = n - 1)
chi2_high <- qchisq(1 - alphaVar/2, df = n - 1)
ci_var <- c((n - 1) * var / chi2_high,
            (n - 1) * var / chi2_low)

# ---- Виведення результатів ----
cat("Точкове Мат. сподівання:", avg, "\n")
cat("Точкова дисперсія:", var, "\n")
cat("Стандартне відхилення (s) = ", s, "\n")
cat("95% довірчий інтервал для середнього: ", ci_mean[1], ci_mean[2], "\n")
cat("90% довірчий інтервал для дисперсії: ", ci_var[1], ci_var[2], "\n")
