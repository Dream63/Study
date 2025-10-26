n <- 60    
m <- 35  
alpha <- 0.05 

q_level <- 1 - alpha / 2
Z_quantile <- qnorm(q_level)

cat("Квантиль стандартного нормального розподілу:",round(Z_quantile, 4),"\n")
p_hat <- m / n

cat("Точкова оцінка ймовірності : ", round(p_hat, 4) ,"\n")

SE <- sqrt(p_hat * (1 - p_hat) / n)
margin_of_error <- Z_quantile * SE
p_left <- p_hat - margin_of_error
p_right <- p_hat + margin_of_error

cat(paste("95% Надійний інтервал: [", round(p_left, 4), ", ", round(p_right, 4), "]\n"))