setwd("D:/Study/R/lab11")

data <- read.csv("selection.csv", header = FALSE)
data_matrix <- as.matrix(data) 
alpha <- 0.05
m_a <- nrow(data_matrix)
m_b <- ncol(data_matrix)
n <- m_a * m_b

row_dot_means <- rowMeans(data_matrix)
col_dot_means <- colMeans(data_matrix)
global_mean <- mean(data_matrix)
cat("Середні значення:\n")
cat("  Середнє по рядках:", row_dot_means, "\n")
cat("  Середнє по стовпцях:", col_dot_means, "\n")
cat("  Загальне середнє:", global_mean, "\n")

dx_a <- (m_b / n) * sum((row_dot_means - global_mean)^2)
dx_b <- (m_a / n) * sum((col_dot_means - global_mean)^2)
dx_0 <- sum((data_matrix - global_mean)^2) / n
dx <- dx_0 + dx_a + dx_b
cat("Суми квадратів:\n")
cat("  Сума квадратів фактору A:", dx_a, "\n")
cat("  Сума квадратів фактору B:", dx_b, "\n")
cat("  Сума квадратів помилки:", dx_0, "\n")
cat("  Загальна сума квадратів:", dx, "\n")

F_a <- dx_a / dx_0
F_critical_a <- qf(1 - alpha, m_a - 1, (m_a - 1) * (m_b - 1))

cat("--- Гіпотеза про вплив фактору A за рівнем значущості", alpha,"---\n")
if (F_a > F_critical_a) {
  cat("  --- Відхиляємо  гіпотезу", F_a, ">", F_critical_a, "\n")
  det_coef_a <- (dx_a) / (dx_a + dx_0)
  cat("  --- Коефіцієнт детермінації для фактору A:", det_coef_a, "\n")

} else {
  cat("  --- Не відхиляємо гіпотезу", F_a, "<=", F_critical_a, "\n")
}


F_b <- dx_b / dx_0
F_critical_b <- qf(1 - alpha, m_b - 1, (m_a - 1) * (m_b - 1))
cat("--- Гіпотеза про вплив фактору B за рівнем значущості", alpha,"---\n")
if (F_b > F_critical_b) {
  cat("  --- Відхиляємо  гіпотезу", F_b, ">", F_critical_b, "\n")
  det_coef_b <- (dx_b) / (dx_b + dx_0)
  cat("  --- Коефіцієнт детермінації для фактору B:", det_coef_b, "\n")
} else {
  cat("  --- Не відхиляємо гіпотезу", F_b, "<=", F_critical_b, "\n")
}
sigma_sq <- dx_0 / (n - m_a - m_b + 1)

cat("Параметри моделі:\n")
cat("  Незсунена дисперсія:", sigma_sq , "\n")
cat("  Середнє значення:", global_mean, "\n")
cat("  Вплив фактору A:", row_dot_means - global_mean, "\n")
cat("  Вплив фактору B:", col_dot_means - global_mean, "\n")