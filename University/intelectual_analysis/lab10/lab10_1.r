setwd("D:/Study/R/lab10")

alpha <- 0.05
data <- read.csv("selection.csv", header = TRUE, sep = ",")

selection_matrix <- t(as.matrix(data))
c_length <- nrow(selection_matrix)
r_length <- ncol(selection_matrix)
lengths <- rowSums(!is.na(selection_matrix))
global_length <- sum(lengths)
print(selection_matrix)
cat("Довжини факторів:", lengths, "\n")

row_dot_means <- rowMeans(selection_matrix, na.rm = TRUE)
global_mean <- mean(selection_matrix, na.rm = TRUE)
row_variances <- apply(selection_matrix, MARGIN = 1, FUN = var, na.rm = TRUE)

df_b <- c_length - 1             
df_w <- global_length - c_length

s_sq_1_W <- sum(row_variances * (lengths - 1))
s_sq_2_B <- sum((row_dot_means - global_mean)^2 * lengths)
sd_sq <- sum((selection_matrix - global_mean) ^ 2, na.rm = TRUE) # перевірка

cat("Сума квадратів відхилень всередині груп:", round(s_sq_1_W,4), "\n")
cat("Сума квадратів відхилень між групами:", round(s_sq_2_B,4), "\n")
cat("Загальна квадратна дисперсія:", round(sd_sq,4), "\n")

# F = (SSB / DFB) / (SSW / DFW) => (SSB * DFW) / (SSW * DFB)
F_H <- s_sq_2_B * df_w / s_sq_1_W * df_b
cat("Значення Фішера:", round(F_H,4), "\n")

x_a <- qf(1 - alpha, df_b, df_w)
cat("Критичне значення:", round(x_a,4), "\n")

independence_lower = F_H < x_a
cat("--- Гіпотеза H0: F_H < x_a (незаліжність від фактору):", F_H, "|", x_a, "\n")
cat("--- Гіпотеза", ifelse(independence_lower, "доведена | F_H < x_a", "відкинута | F_H >(!!!) x_a"), "\n")

det_coef <- s_sq_2_B / sd_sq
cat("Коефіцієнт детермінації:", round(det_coef,4), "\n")

cat("Математичне сподівання для кожного фактору:", round(row_dot_means,4), "\n")
cat("Дисперсія для кожного фактору:", round(row_variances,4), "\n")


# Графіки
factors <- rownames(selection_matrix)
names(row_dot_means) <- factors
names(row_variances) <- factors
sds <- sqrt(row_variances)

x_min <- min(row_dot_means - 3 * sds)
x_max <- max(row_dot_means + 3 * sds)
x_range <- seq(x_min, x_max, length.out = 500)
y_max <- dnorm(row_dot_means["C"], mean = row_dot_means["C"], sd = sds["C"]) * 1.1

png("Graphic/lab10_1_Distribution_Graph.png", width = 800, height = 600)
plot(x = range(x_range), 
     y = c(0, y_max), 
     type = "n", 
     main = "Щільність ймовірності (Нормальний розподіл) за факторами",
     xlab = "Значення",
     ylab = "Щільність ймовірності")
     
colors <- c("blue", "green", "red", "purple")

for (i in 1:length(factors)) {
  factor_name <- factors[i]
  mean_val <- row_dot_means[factor_name]
  sd_val <- sds[factor_name]
  curve(dnorm(x, mean = mean_val, sd = sd_val), 
        from = x_min, to = x_max,
        col = colors[i], lwd = 2, add = TRUE)
  abline(v = mean_val, col = colors[i], lty = 2)
}

legend("topright", 
       legend = paste0(factors, 
                       " (M=", round(row_dot_means, 2), 
                       ", Var=", round(row_variances, 2), ")"),
       col = colors,
       lty = 1,
       lwd = 2,
       title = "Фактор")
dev.off()

F_crit <- qf(1 - alpha, df_b, df_w)
png("Graphic/lab10_1_F_distribution.png", width = 800, height = 600)
curve(df(x, df1 = df_b, df2 = df_w), 
      from = 0, to = F_crit * 2, 
      col = "darkred", lwd = 2,
      main = paste("F-розподіл (df1 =", df_b, ", df2 =", df_w, ")"),
      xlab = "F-статистика",
      ylab = "Щільність ймовірності")

abline(v = F_crit, col = "blue", lty = 3)
text(x = F_crit * 1.3, y = max(df(seq(0, F_crit * 1.5, length.out=100), df1=df_b, df2=df_w))/2, 
     labels = paste("F_крит:", round(F_crit, 3)), col = "blue")
dev.off()


cat(" ========== Додатково ==========\n")
selection_matrix_no_na <- selection_matrix[!is.na(selection_matrix)]
data_long <- data.frame(
  Value = c(selection_matrix_no_na),
  Factor = rep(rownames(selection_matrix), times = lengths)
)

bartlett_result <- bartlett.test(Value ~ Factor, data = data_long)
p_value <- bartlett_result$p.value
cat("P-значення тесту Бартлетта:", round(p_value, 4), "\n")

cat("--- Гіпотеза H0: p < alpha (рівність групових дисперсій):", p_value, "|", alpha, "\n")
if (p_value < alpha) {
  cat("--- Гіпотеза відхилена | Дисперсії груп статистично нерівні.\n")
} else {
  cat("--- Гіпотеза доведена | Дисперсії груп статистично рівні\n")
}
