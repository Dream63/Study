setwd("D:/Study/R/lab6")

N = 2
lambda_true <- 0.1 * N 
n_max <- 500
alpha_values <- c(0.05, 0.01, 0.10)
confidence_levels <- 1 - alpha_values
subset_sizes <- seq(100, n_max, by = 50) 

set.seed(42) 
sample <- rpois(n_max, lambda = lambda_true)

get_z_quantile <- function(alpha) {
  q_level <- 1 - 0.5 * alpha
  z_quantile <- qnorm(q_level)
  return(z_quantile)
}

cat("Квантилі стандартного нормального розподілу:\n")
for (a in alpha_values) {
  z <- get_z_quantile(a)
  cat(paste("  alpha = ", a, " (Надійність ", 100 * (1 - a), "%): Z = ", round(z, 4), "\n", sep = ""))
}

delta_matrix <- matrix(NA, nrow = length(subset_sizes), ncol = length(alpha_values))
colnames(delta_matrix) <- paste0("delta_alpha_", alpha_values)
rownames(delta_matrix) <- subset_sizes

cat("Обчислення точкової оцінки та надійних інтервалів:\n")

for (i in 1:length(subset_sizes)) {
  n <- subset_sizes[i]
  current_sample <- sample[1:n]
  lambda_hat <- mean(current_sample)
  
  for (j in 1:length(alpha_values)) {
    alpha <- alpha_values[j]
    Z <- get_z_quantile(alpha)
    SE <- sqrt(lambda_hat / n)
    margin <- Z * SE
    lambda_left <- lambda_hat - margin
    lambda_right <- lambda_hat + margin
    
    delta <- lambda_right - lambda_left
    delta_matrix[i, j] <- delta
    if (j == 1) {
      cat(paste("  n = ", n, 
                " | Точкова оцінка =", round(lambda_hat, 5), 
                "\t | CI (", 100 * (1 - alpha), "%): [", round(lambda_left, 3), ", ", round(lambda_right, 3), 
                "]\t | Delta =", round(delta, 5), "\n", sep = ""))
    }
  }
}

png("Graphic\\lab6_2_plot.png", width = 800, height = 600)
plot(subset_sizes, delta_matrix[, 1], type = "o",
     xlab = "Обсяг вибірки (n)",
     ylab = expression(paste(Delta, "(", lambda, ") - Довжина надійного інтервалу")),
     main = expression(paste("Залежність довжини надійного інтервалу (", Delta, ") від n та ", alpha)),
     ylim = c(0, max(delta_matrix) * 1.05),
     col = "blue", pch = 16, lwd = 2)

colors <- c("red", "darkgreen")
pchs <- c(17, 18)

for (k in 2:length(alpha_values)) {
  lines(subset_sizes, delta_matrix[, k], type = "o",
        col = colors[k-1], pch = pchs[k-1], lwd = 2)
}

legend("topright",
       legend = paste0(100 * (1 - alpha_values), "% Надійність (alpha=", alpha_values, ")"),
       col = c("blue", colors),
       pch = c(16, pchs),
       lwd = 2,
       title = "Рівень надійності")
dev.off()
