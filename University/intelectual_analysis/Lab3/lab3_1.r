setwd("D:\\Study\\R\\Lab3") # set working directory

# 2. Функція Колмогорова K(z)
K <- function(z, terms=100) {
  s <- 0
  for (k in 1:terms) {
    s <- s + (-1)^(k-1) * exp(-2 * k^2 * z^2)
  }
  1 - 2 * s
}


png("Graphic\\3.1lab_Kolmogorov_funcion.png", width = 800, height = 600)
# (b) Функція Колмогорова K(z)
z <- seq(0.02, 2, length=200)
plot(z, K(z), type="l", lwd=2, col="darkgreen",
     main="Функція Колмогорова K(z)",
     xlab="z", ylab="K(z)")
dev.off()



alpha <- 1 - K(z)

png("Graphic/3.1lab_alpha_equals_Kz.png", width=800, height=600)
plot(z, alpha, type="l", lwd=2, col="blue",
     main="Alpha = 1 - K(z)",
     xlab="D (max |F_n - F|)",
     ylab="Alpha")
grid()
abline(h=0.05, col="red", lty=2)  # наприклад рівень значущості 0.05
dev.off()


get_Dn <- function(x, F_theor) {
  # x - вектор вибірки
  F_emp <- ecdf(x)
  z_vals <- sort(unique(x))  # усі унікальні точки для оцінки
  D_n <- max(abs(F_emp(z_vals) - F_theor(z_vals)))
  return(D_n)
}


plot_KS_corridor_norm <- function(file_path, col_name, mu=150, sigma=10, alpha=0.05) {
  # Завантажуємо дані
  data <- read.csv("d:\\Study\\R\\Lab3\\numbers_list.csv", stringsAsFactors = FALSE)
  x <- data[[col_name]]
  
  n <- length(x)
  
  # Емпірична CDF
  F_emp <- ecdf(x)
  
  # Теоретична CDF для N(mu, sigma)
  F_theor <- function(z) pnorm(z, mean=mu, sd=sigma)
  
  # Критичне значення D для 95% коридору (наближення)
  D_n <- 1.36/sqrt(n)
  cat("Критичне значення D для 95% коридору:", D_n)

  # Малюємо графік
  max_z <- max(x, mu + 4*sigma)  # для охоплення всіх значень
  png("Graphic/3.1lab_KS_corridor_normal.png", width=800, height=600)
  plot(F_emp, main="ECDF + 95% KS Corridor (Normal)", xlab="z", ylab="F(z)", lwd=2, col="blue")
  curve(F_theor(x), from=0, to=max_z, add=TRUE, col="red", lwd=2)
  
  # 95% коридор
  curve(F_theor(x) + D_n, from=0, to=max_z, add=TRUE, col="darkgreen", lty=2)
  curve(F_theor(x) - D_n, from=0, to=max_z, add=TRUE, col="darkgreen", lty=2)
  
  legend("bottomright", legend=c("ECDF","Theoretical CDF","95% KS Corridor"),
         col=c("blue","red","darkgreen"), lwd=c(2,2,1), lty=c(1,1,2))
  dev.off()
}

plot_KS_corridor_norm("numbers_list.csv", "Value")