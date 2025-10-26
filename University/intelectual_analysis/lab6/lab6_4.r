setwd("D:/Study/R/lab6")
# Вектори X та Y
data_df <- read.csv("selection.csv", 
                    header = TRUE,     # Вказує, що перший рядок містить заголовки (x, y)
                    sep = ",",         # Вказує розділювач колонок (стандартно для CSV - кома)
                    dec = ".",         # Вказує десятковий розділювач (стандартно - крапка)
                    stringsAsFactors = FALSE # Запобігає автоматичному перетворенню рядків у фактори (для числових даних не критично)
                    )

X <- data_df$X
Y <- data_df$Y
n <- length(X)

x_bar <- mean(X)
y_bar <- mean(Y)

cat("Cереднє X = ", round(x_bar, 4), "\n")
cat("Cереднє Y = ", round(y_bar, 4), "\n")

sigma_x2_hat <- mean((X - x_bar)^2)
sigma_y2_hat <- mean((Y - y_bar)^2)

cat("Дисперсія X, =", round(sigma_x2_hat, 4), "\n")
cat("Дисперсія Y, =", round(sigma_y2_hat, 4), "\n")

q_level <- 1 - 0.5 * alpha
Z_quantile <- qnorm(q_level)

cat(paste("Квантиль стандартного нормального розподілу: alpha =", alpha, " | Рівень =", q_level, " | Z =", round(Z_quantile, 4), "\n"))

r_hat_std <- cor(X, Y) 

cat("Точкова оцінка коефіцієнта кореляції:", round(r_hat_std, 4), "\n")

z_r_5 <- 0.5 * log((1 + r_hat_std) / (1 - r_hat_std))
SE_z <- 1 / sqrt(n - 3)
z_left_5 <- z_r_5 - Z_quantile * SE_z
z_right_5 <- z_r_5 + Z_quantile * SE_z
rho_left_5 <- (exp(2 * z_left_5) - 1) / (exp(2 * z_left_5) + 1)
rho_right_5 <- (exp(2 * z_right_5) - 1) / (exp(2 * z_right_5) + 1)

cat("95% Надійний інтервал для кореляції: [", round(rho_left_5, 4), ", ", round(rho_right_5, 4), "]\n")

m_bar <- mean(X * Y)
numerator <- m_bar - x_bar * y_bar 
denominator <- sqrt(sigma_x2_hat * sigma_y2_hat)

r_hat_7 <- numerator / denominator

cat("Точкова оцінка коефіцієнта кореляції (за другою формулою): ", round(r_hat_7, 4), "\n")

r_hat_8 <- r_hat_7
z_r_8 <- 0.5 * log((1 + r_hat_8) / (1 - r_hat_8))
z_left_8 <- z_r_8 - Z_quantile * SE_z
z_right_8 <- z_r_8 + Z_quantile * SE_z
rho_left_8 <- (exp(2 * z_left_8) - 1) / (exp(2 * z_left_8) + 1)
rho_right_8 <- (exp(2 * z_right_8) - 1) / (exp(2 * z_right_8) + 1)

cat("95% Надійний інтервал для rho (на основі другої кореляції): [", round(rho_left_8, 4), ", ", round(rho_right_8, 4), "]\n")