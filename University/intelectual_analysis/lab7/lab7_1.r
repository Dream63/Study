setwd("d:/Study/R/lab7")
set.seed(123)
alpha <- 0.1
MX <- .1
DX <- 2
n <- 100
MX_0 <- 1

cat("Відоме стандартне відхилення DX =", DX, "\n\n")

# Генерація вибірки
selection <- rnorm(n, mean = MX, sd = DX)
dot_mean <- mean(selection)
dot_sd <- sd(selection)

cat("Точкове середнє =", dot_mean, "\n")

# Обчислення статистики
phi = (dot_mean - MX_0) / (DX / sqrt(n))

# Перевірка гіпотез
x_la = qnorm(0.5 * alpha)
x_ra = -x_la
lower = phi < x_la
higher = phi > x_ra
cat("Значення: x_la =", x_la, "phi =", phi, "| x_ra =", x_ra , "\n\n")
cat("--- Гіпотеза H0: MX ==", MX_0, "--- \n")
cat("Гіпотеза", ifelse(!lower && !higher, "доведена", "відкинута") ,"| x_la", ifelse(!lower, "<", "=>(!!!)"), "phi", ifelse(!higher,"<", "=>(!!!)"), "x_ra","\n\n")
cat("--- Гіпотеза H1: MX !=", MX_0, "--- \n")
cat("Гіпотеза", ifelse(lower || higher, "доведена", "відкинута") ,"| x_la", ifelse(!lower, "<", "=>(!!!)"), "phi", ifelse(!higher,"<", "=>(!!!)"), "x_ra","\n\n")

h1_x_ra = qnorm(1 - alpha)
h1_higher = phi > h1_x_ra
cat("--- Гіпотеза H1: MX >", MX_0, "--- \n")
cat("Гіпотеза", ifelse(h1_higher, "доведена | x_ra < phi", "відкинута | x_ra >(!!!) phi"),"\n\n")

h1_x_la = -h1_x_ra
h1_lower = phi < h1_x_la
cat("--- Гіпотеза H1: MX <", MX_0, "--- \n")
cat("Гіпотеза", ifelse(h1_lower, "доведена | x_la > phi", "відкинута | x_la <=(!!!) phi") , "\n\n")