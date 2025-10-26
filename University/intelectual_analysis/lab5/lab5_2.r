setwd("d:\\Study\\R\\lab5")

N = 2
lambda_true <- 0.1 * N
n_single <- 100  # Обсяг для першої вибірки

set.seed(123) 
sample_data <- rexp(n_single, rate = lambda_true)

cat(paste("Вибіркове середнє:", mean(sample_data)))

log_likelihood <- function(lambda, data) {
  if (lambda <= 0) return(-Inf) 
  n <- length(data)
  sum_x <- sum(data)
  
  ll <-n * log(lambda) - lambda * sum_x
  return(ll)
}

lambda_range <- seq(0.01, lambda_true * 2, by = 0.01)
ll_values <- sapply(lambda_range, log_likelihood, data = sample_data)

# Знаходимо теоретичне ОМП (вибіркове середнє)
lambda_mle_single <- 1 / mean(sample_data)

png("Graphic\\5_2lab_Log_Likelihood.png", width = 800, height = 600)
plot(lambda_range, ll_values, type = "l", 
     xlab = expression(lambda), 
     ylab = expression(log(L(lambda))),
     main = paste0("Графік log-правдоподібності для n =", n_single),
     col = "blue", lwd = 2)

abline(v = lambda_mle_single, col = "red", lty = 2)
text(lambda_mle_single, max(ll_values) - 5, 
     labels = paste("ОМП =", round(lambda_mle_single, 3)), 
     col = "red", pos = 4)
dev.off()

cat(paste("\nОцінка максимальної правдоподібності для n =", n_single, ":", lambda_mle_single, "\n"))

sample_sizes <- c(10, 20, 50, 100, 200, 500, 1000, 2000, 5000, 10000, 20000)
mle_estimates <- numeric(length(sample_sizes))

for (i in 1:length(sample_sizes)) {
  n <- sample_sizes[i]
  current_sample <- rexp(n_single, rate = lambda_true)
  mle_estimates[i] <- 1 / mean(current_sample)
  cat(paste("n =", n, ": ОМП =", round(mle_estimates[i], 4), "\n"))
}

log_sample_sizes <- log10(sample_sizes)
log_labels <- c(1, 2, 3, 4)
n_labels <- 10^log_labels

png("Graphic\\5_2lab_MLE_vs_SampleSize.png", width = 800, height = 600)
plot(log_sample_sizes, mle_estimates, type = "o", 
     xlab = "Обсяг вибірки (n)", 
     ylab = expression(paste("Оцінка ", hat(lambda))),
     main = expression(paste("Залежність ОМП від обсягу вибірки (", lambda, "=0.2)")),
     ylim = range(c(0, lambda_true * 2)), 
     col = "darkgreen", pch = 16,
     xaxt = "n"
     )

axis(1,                      
     at = log_labels,      
     labels = parse(text = paste("10^", log_labels))
     )

abline(h = lambda_true, col = "red", lty = 2, lwd = 2)
text(max(log_sample_sizes) * 0.8, lambda_true * 1.05, 
     labels = expression(paste("Істинне ", lambda, " = 0.2")), 
     col = "red", pos = 4)
dev.off()