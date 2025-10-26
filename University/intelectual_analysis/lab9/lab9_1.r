setwd("D:/Study/R/lab9")

data_df <- read.csv("selection.csv", 
                    header = TRUE, 
                    sep = ",",     
                    dec = ".",     
                    stringsAsFactors = FALSE 
                    )
                    
alpha <- 0.05


selection_x <- data_df$X
selection_y <- data_df$Y
n <- length(selection_x)

dot_mean_x <- mean(selection_x)
dot_mean_y <- mean(selection_y)
dot_sd_x <- sd(selection_x)
dot_sd_y <- sd(selection_y)

# Y ~ X - формула: Y залежить від X
model <- lm(Y ~ X, data = data_df)

png("Graphic/lab9_1_Regression_Plot.png" , width = 800, height = 600)
plot(selection_x, selection_y, 
     main = "Граік регресії Y ~ X", 
     type = "o",
     xlab = "X", 
     ylab = "Y", 
     pch = 19, 
     col = "blue"
     )
abline(model, col = "red", lwd = 2)
dev.off()

t_a <- qt(alpha / 2, df = n - 2)
cat("Квантиль t-розподілу для alpha =", alpha, "та df =", n - 2, ":", x_a, "\n")

summary_output <- summary(model)
s_epsilon <- summary_output$sigma
SSX <- sum((selection_x - dot_mean_x)^2)
T_CRIT <- c(t_a , t_a)

cat("Tочкове значення для a0:", coef(model)["(Intercept)"], "\n")
a0_hat <- coef(model)["(Intercept)"]
SE_a0 <- summary_output$coefficients["(Intercept)", "Std. Error"]
a0_l <- a0_hat - t_a * SE_a0
a0_r <- a0_hat + t_a * SE_a0
cat("Довірчий інтервал a =",alpha,"для a0: [", a0_l, ", ", a0_r, "]\n")

cat("Tочкове значення для a1:", coef(model)["X"], "\n")
a1_hat <- coef(model)["X"]
SE_a1 <- summary_output$coefficients["X", "Std. Error"]
a1_l <- a1_hat - t_a * SE_a1
a1_r <- a1_hat + t_a * SE_a1
cat("Довірчий інтервал a =",alpha,"для a1: [", a1_l, ", ", a1_r, "]\n")

chi_la <- qchisq(alpha / 2, df = n - 2)
chi_ra <- qchisq(1 - alpha / 2, df = n - 2)
dx_l <- (n - 2) * dot_sd_y ^ 2 / chi_la
dx_r <- (n - 2) * dot_sd_y ^ 2 / chi_ra
cat("Квантилі хі-квадрат розподілу для alpha =", alpha, ":", chi_la, ", ", chi_ra, "\n")
cat("Довірчий інтервал для дисперсії y при a =", alpha, ": [", dx_l, ", ", dx_r, "]\n")


X_range <- seq(min(selection_x), max(selection_x), length.out = 100)
new_data <- data.frame(X = X_range)
ci_y0 <- predict(model, 
                 newdata = new_data, 
                 interval = "confidence", 
                 level = 1 - alpha)

png("Graphic/lab9_1_Regression_CI_Plot.png" , width = 800, height = 600)
plot(selection_x, selection_y, pch = 16, col = "blue", 
     main = "Регресійна пряма та 95% Надійний інтервал для Y0",
     xlab = "Незалежна змінна X",
     ylab = "Залежна змінна Y",
     ylim = range(selection_y, ci_y0))

abline(model, col = "red", lwd = 2)

# 2. Надійний інтервал для середнього Y0
lines(X_range, ci_y0[, "lwr"], col = "darkgreen", lty = 2, lwd = 2)
lines(X_range, ci_y0[, "upr"], col = "darkgreen", lty = 2, lwd = 2)

# 3. Легенда
legend("topleft", 
       legend = c("Вибіркові дані", 
                  "Регресійна пряма", 
                  paste0(100 * (1 - alpha), "% Надійний інтервал для E[Y|X]")
                  ),
       col = c("blue", "red", "darkgreen"),
       pch = c(16, NA, NA),
       lty = c(NA, 1, 2),
       lwd = c(NA, 2, 2))
dev.off()

# Функція обчислює нижню межу: y = a0_hat + a1_hat * x - [T_CRIT * s * SE_Factor]
calculate_lower_bound <- function(x_vector, a0, a1, n_val, x_bar_val, SSX_val, s_val, t_crit_val) {
  SE_factor <- sqrt((1 / n_val) + (x_bar_val^2 / SSX_val))
  ME <- t_crit_val * s_val * SE_factor
  Y_hat <- a0 + a1 * x_vector
  lower_bound <- Y_hat - ME
  return(lower_bound)
}

Y_lower_bound <- calculate_lower_bound(
    x_vector = X_range,
    a0 = a0_hat, a1 = a1_hat, n_val = n, x_bar_val = dot_mean_x, 
    SSX_val = SSX, s_val = s_epsilon, t_crit_val = T_CRIT
)

Y_upper_bound <- calculate_lower_bound(
    x_vector = X_range,
    a0 = a0_hat, a1 = a1_hat, n_val = n, x_bar_val = dot_mean_x, 
    SSX_val = SSX, s_val = s_epsilon, t_crit_val = -T_CRIT
)

png("Graphic/lab9_1_Regression_Bound_Plot.png" , width = 800, height = 600)
plot(selection_x, selection_y, pch = 16, col = "blue", 
     main = "Регресійна пряма та лінія, обчислена за Вашою формулою",
     xlab = "Незалежна змінна X",
     ylab = "Залежна змінна Y",
     ylim = range(selection_y, Y_lower_bound, Y_upper_bound))

# 1. Регресійна пряма
abline(model, col = "red", lwd = 2)

# 2. Лінія
lines(X_range, Y_lower_bound, col = "darkorange", lty = 2, lwd = 3)
lines(X_range, Y_upper_bound, col = "darkorange", lty = 2, lwd = 3)

# Легенда
legend("topleft", 
       legend = c("Вибіркові дані", 
                  "Регресійна пряма", 
                  "Межі"
                  ),
       col = c("blue", "red", "darkorange"),
       pch = c(16, NA, NA),
       lty = c(NA, 1, 2),
       lwd = c(NA, 2, 3))
dev.off()