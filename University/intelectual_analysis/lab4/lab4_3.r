setwd("d:\\Study\\R\\lab4")

# --- Параметри ---
N <- 2
theta <- N / 2      # = 1
n_values <- seq(10, N * 1000, by = 10)
set.seed(123)

# --- Ініціалізація результатів ---
theta1 <- numeric(length(n_values))
theta3 <- numeric(length(n_values))

for (i in seq_along(n_values)) {
  n <- n_values[i]
  x <- runif(n, 0, theta)
  theta1[i] <- 2 * mean(x)      
  theta3[i] <- max(x) * (n + 1) / n           
}

# --- 1. Графік для theta1 ---
png("Graphic/4.3lab_Uniform_theta1.png", width=800, height=600)
plot(n_values, theta1, type="b", col="blue", pch=19, lwd=2,
     ylim=c(.8, 1.2), xlab="Обсяг вибірки n", ylab=expression(hat(theta)[1]),
     main=expression("Збіжність оцінки" ~ hat(theta)[1] ~ "до істинного θ"))
abline(h=theta, col="red", lty=2, lwd=2)
grid()
legend("bottomright", legend=c(expression(hat(theta)[1]), expression(theta == 1)),
       col=c("blue", "red"), lwd=c(2,2), pch=c(19,NA), lty=c(1,2))
dev.off()

# --- 2. Графік для theta3 ---
png("Graphic/4.3lab_Uniform_theta3.png", width=800, height=600)
plot(n_values, theta3, type="b", col="darkgreen", pch=19, lwd=2,
     ylim=c(.8, 1.2), xlab="Обсяг вибірки n", ylab=expression(hat(theta)[3]),
     main=expression("Збіжність оцінки" ~ hat(theta)[3] ~ "до істинного θ"))
grid()
abline(h=theta, col="red", lty=2, lwd=2)
legend("bottomright", legend=c(expression(hat(theta)[3]), expression(theta == 1)),
       col=c("darkgreen", "red"), lwd=c(2,2), pch=c(17,NA), lty=c(1,2))
dev.off()