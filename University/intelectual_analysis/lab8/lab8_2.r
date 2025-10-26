setwd("d:/Study/R/lab7")
set.seed(123)
alpha <- 0.05
MX <- .1
DX <- 2
n <- 100
m <- 200
# Генерація вибірки
selection_x <- rnorm(n, mean = MX, sd = DX)
selection_y <- rnorm(m, mean = MX, sd = DX)
dot_mean_x <- mean(selection_x)
dot_mean_y <- mean(selection_y)
dot_var_x <- var(selection_x)
dot_var_y <- var(selection_y)

cat("Точкове середнє для розп. x =", dot_mean_x, "\n")
cat("Точкове середнє для розп. y =", dot_mean_y, "\n")
cat("Точкова дисперсія для розп. x =", dot_var_x, "\n")
cat("Точкова дисперсія для розп. y =", dot_var_y, "\n")

# Обчислення статистики
D_XY = ((n-1)*dot_var_x + (m-1)*dot_var_y) / (n + m -2)
phi = (dot_mean_x - dot_mean_y) / D_XY

# Перевірка гіпотез
x_la = qnorm(0.5 * alpha)
x_ra = -x_la
lower = phi < x_la
higher = phi > x_ra
cat("Значення: x_la =", x_la, "phi =", phi, "| x_ra =", x_ra , "\n\n")
cat("--- Гіпотеза H0: MX == MY : ", dot_mean_x, "| ", dot_mean_y, "--- \n")
cat("Гіпотеза", ifelse(!lower && !higher, "доведена", "відкинута") ,"| x_la", ifelse(!lower, "<", "=>(!!!)"), "phi", ifelse(!higher,"<", "=>(!!!)"), "x_ra","\n\n")
cat("--- Гіпотеза H1: MX !=", MX_0, "--- \n")
cat("Гіпотеза", ifelse(lower || higher, "доведена", "відкинута") ,"| x_la", ifelse(!lower, "<", "=>(!!!)"), "phi", ifelse(!higher,"<", "=>(!!!)"), "x_ra","\n\n")