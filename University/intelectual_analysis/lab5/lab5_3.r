setwd("d:\\Study\\R\\lab5")
library(rmutil)  # Для функції dlaplace

theta1_true <- 1.5 
theta2_true <- 2.0 
n_sample <- 1000 

set.seed(123)
U <- runif(n_sample, min = 0, max = 1) 

cat("Функція розподілу Лапласа в точці x = 1 : ", dlaplace(1, theta1_true, theta2_true), "\n")
cat("Обернена функція розподілу Лапласа в точці x = .2 : ", qlaplace(.2, theta1_true, theta2_true), "\n")

laplace_sample <- qlaplace(U, theta1_true, theta2_true)

cat("Змодельована вибірка з розподілу Лапласа (перші 10 значень):\n")
print(head(laplace_sample, 10))

png("Graphic\\5_3lab_histogram.png", width = 800, height = 600)
hist(laplace_sample, 
     main = expression(paste("Гістограма вибірки з розподілу Лапласа (", theta[1], "=1.5, ", theta[2], "=2)")),
     xlab = "Значення X",
     breaks = 50,
     freq = FALSE,
     col = "lightblue", border = "darkblue")

laplace_pdf <- function(x, theta1, theta2) {
  return( (1 / (2 * theta2)) * exp(-abs(x - theta1) / theta2) )
}
curve(laplace_pdf(x, theta1_true, theta2_true), 
      add = TRUE, 
      col = "red", lwd = 2)

abline(v = theta1_true, col = "red", lty = 2, lwd = 2)
dev.off()
theta1_mle <- median(laplace_sample)
abs_deviations <- abs(laplace_sample - theta1_mle) 
theta2_mle <- mean(abs_deviations)

cat("Оцінки максимальної правдоподібності:\n")
cat(paste("Істинне theta1 = ", theta1_true, " | ОМП theta1 (Медіана) = ", round(theta1_mle, 4), "\n", sep = ""))
cat(paste("Істинне theta2 = ", theta2_true, " | ОМП theta2 (Середнє Відхилення) = ", round(theta2_mle, 4), "\n", sep = ""))
