setwd("d:\\Study\\R\\lab4")

# --- Початкові параметри ---
p <- 0.2
N = 2
n_values <- seq(10, N * 1000, by = 10)   # n = 10, 20, ..., 1000
set.seed(123)                       


p_hat <- numeric(length(n_values))   # вектор для результатів

for (i in seq_along(n_values)) {
  n <- n_values[i]
  x <- rbinom(n, size = 1, prob = p)
  p_hat[i] <- mean(x)
}


png("Graphic/4.2lab_Bernoulli_convergence.png", width = 800, height = 600)

plot(n_values, p_hat, type = "b", pch = 19, col = "darkgreen",
     main = "Збіжність оцінки p̂ до істинного p у розподілі Бернуллі",
     xlab = "Обсяг вибірки n", ylab = "Оцінка p̂",
     ylim = c(0, .4))
abline(h = p, col = "red", lwd = 2, lty = 2)
grid()

legend("bottomright", legend = c("Оцінки p̂", "Істинне p = 0.2"),
       col = c("darkgreen", "red"), lwd = c(2, 2), pch = c(19, NA), lty = c(1, 2))

dev.off()