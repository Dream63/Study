setwd("d:/Study/R/lab7")
set.seed(123)
alpha <- 0.1     
MX <- 0.1        
DX <- 2          
DX_0 <- 2        
n <- 100         

D_0 <- DX_0^2    
df <- n - 1      

# Генерація вибірки
selection <- rnorm(n, mean = MX, sd = DX)
dot_mean <- mean(selection)
dot_dx_sq <- var(selection)
cat("Точкове середнє =", dot_mean, "\n")
cat("Точкова квадратна дисперсія =", dot_dx_sq, "\n")

# Обчислення статистики
chi_sq_stat <- (n - 1) * dot_dx_sq / D_0

# Перевірка гіпотез
chi_sq_la <- qchisq(0.5 * alpha, df = df)
chi_sq_ra <- qchisq(1 - 0.5 * alpha, df = df)
lower = chi_sq_stat < chi_sq_la
higher = chi_sq_stat > chi_sq_ra
cat("Значення: x_la =", chi_sq_la, "chi =", chi_sq_stat, "| x_ra =", chi_sq_ra , "\n\n")
cat("--- Гіпотеза H0: DX ==", DX_0, "--- \n")
cat("Гіпотеза", ifelse(!lower && !higher, "доведена", "відкинута") ,"| x_la", ifelse(!lower, "<", "=>(!!!)"), "chi", ifelse(!higher,"<", "=>(!!!)"), "x_ra","\n\n")
cat("--- Гіпотеза H1: DX !=", DX_0, "--- \n")
cat("Гіпотеза", ifelse(lower || higher, "доведена", "відкинута") ,"| x_la", ifelse(!lower, "<", "=>(!!!)"), "chi", ifelse(!higher,"<", "=>(!!!)"), "x_ra","\n\n")

h1_chi_sq_la = qchisq(1-alpha, df = df)
h1_higher = chi_sq_stat > h1_sq_ra
cat("--- Гіпотеза H1: DX >", DX_0, "--- \n")
cat("Гіпотеза", ifelse(h1_higher, "доведена | x_ra < chi", "відкинута | x_ra >(!!!) chi"),"\n\n")

h1_chi_sq_la <- qchisq(alpha, df = df)
h1_lower = chi_sq_stat < h1_chi_sq_la
cat("--- Гіпотеза H1: DX <", DX_0, "--- \n")
cat("Гіпотеза", ifelse(h1_lower, "доведена | x_la > chi", "відкинута | x_la <=(!!!) chi") , "\n\n")