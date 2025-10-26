setwd("D:\\Study\\R\\Lab3") # set working directory

seed = 124  

# ------------- FUNCTIONS ----------------

# --- 1. Графік щільності ймовірності (PMF) ---
plot_geom_density <- function(prob=0.2, max_k=20) {
  x <- 0:max_k
  y <- dgeom(x, prob=prob)
  
  png("Graphic\\3.2lab_geom_PMF.png", width=800, height=600)
  plot(x, y, type="h", lwd=2, col="blue",
       main=paste("PMF (Geometric, p =", prob, ")"),
       xlab="k", ylab="P(X=k)")
  points(x, y, pch=19, col="red")
  dev.off()
}

# --- 2. Графік функції розподілу (CDF) ---
plot_geom_cdf <- function(prob=0.2, max_k=20) {
  x <- 0:max_k
  y <- pgeom(x, prob=prob)
  
  png("Graphic\\3.2lab_geom_CDF.png", width=800, height=600)
  plot(x, y, type="s", lwd=2, col="blue",
       main=paste("CDF (Geometric, p =", prob, ")"),
       xlab="k", ylab="F(k)")
       dev.off()
}

# Theoretical stats
theoretical_stats_geom <- function(p) {
  mu <- (1 - p) / p
  var <- (1 - p) / (p^2)
  sd <- sqrt(var)
  m3 <- (2 - p) * (1 - p) / (p^3)   # central 3rd moment
  m4 <- (6 + p^2) * (1 - p) / (p^4) # central 4th moment
  skew <- (2 - p) / sqrt(1 - p)
  excess <- (6 + p^2) / (1 - p)
  list(mean = mu, variance = var, sd = sd, median = qgeom(0.5, p),
       m3 = m3, m4 = m4, skewness = skew, excess = excess)
}

# geometric dist sample
generate_geom_sample <- function(N, prob=0.2) {
  set.seed(seed)
  sample <- rgeom(N, prob=prob)
  return(sample)
}


# --- 1. Полігон частот ---
plot_frequency_polygon <- function(x, id=50) {
  bins <- max(x) - min(x)
  # Створюємо гістограму без малювання
  hist_info <- hist(x, breaks=bins, plot=FALSE)
  
  # Середини бінів
  mids <- hist_info$mids
  counts <- hist_info$counts
  
  # Полігон частот
  png(paste0("Graphic\\3.2lab_Frequency_polygon_",id,".png"), width = 800, height = 600)
  plot(mids, counts, type="b", lwd=2, col="blue",
       main="Frequency polygon",
       xlab="x", ylab="Frequency", pch=19)
  grid()
  dev.off()
}

# --- 2. Графік накопичених відносних частот ---
plot_cumulative_relative <- function(x, id = 50, show_line = TRUE) {
  bins = max(x) - min(x)
  # Compute histogram without plotting
  hist_info <- hist(x, breaks = bins, plot = FALSE)
  
  mids <- hist_info$mids
  rel_counts <- hist_info$counts / sum(hist_info$counts)
  cum_rel <- cumsum(rel_counts)
  
  # Prepare output file
  png(paste0("Graphic/3.2lab_Cumulative_Relative_Frequency_", id, ".png"),
      width = 800, height = 600)
  
  # --- Draw histogram (bars) of cumulative frequencies ---
  barplot(cum_rel,
          names.arg = round(mids, 2),
          col = "lightgreen",
          border = "darkgreen",
          main = "Cumulative Relative Frequency Histogram",
          xlab = "x (class midpoints)",
          ylab = "Cumulative Relative Frequency",
          ylim = c(0, 1))

  # Add gridlines
  abline(h = seq(0, 1, 0.1), col = "gray", lty = 2)
  
  dev.off()
}

# Compare theoretical vs sample
plot_geom_CDF_corridor <- function(x, p, id) {
  n <- length(x)
  x_sorted <- sort(x)
  Kz <- ecdf(x)
  kgrid <- min(x_sorted):max(x_sorted)
  Fk <- pgeom(kgrid, prob = p)
  
  # 95% Kolmogorov corridor
  band_radius <- 1.36 / sqrt(n)
  upper <- pmin(1, Fk + band_radius)
  lower <- pmax(0, Fk - band_radius)
  
  # Save plot to PNG
  png(paste0("Graphic\\3.2lab_geom_CDF_corridor",id,".png"), width = 800, height = 600)
  
  # Plot theoretical CDF
  plot(kgrid, Fk, type = "s", lwd = 2, col = "blue",
       main = "Geometric CDF with 95% corridor",
       xlab = "k", ylab = "F(X ≤ k)")
  
  # Plot empirical CDF
  lines(Kz, verticals = TRUE, do.points = FALSE, col = "black", lwd = 2)
  
  # Plot corridor
  lines(kgrid, upper, col = "darkgreen", lty = 2)
  lines(kgrid, lower, col = "darkgreen", lty = 2)
  
  # Legend
  legend("bottomright",
         legend = c("Empirical CDF", "Theoretical CDF", "95% corridor"),
         col = c("black", "blue", "red"),
         lty = c(1,1,2),
         lwd = c(2,2,1),
         bty = "n")
  
  grid()
  dev.off()
}

# Sample stats
sample_moment_central <- function(x, k) mean((x - mean(x))^k)
sample_skewness <- function(x) sample_moment_central(x, 3) / sd(x)^3
sample_excess <- function(x) sample_moment_central(x, 4) / sd(x)^4 - 3

sample_stats <- function(x) {
  list(
    mean = mean(x),
    median = median(x),
    variance = var(x),
    sd = sd(x),
    m3 = sample_moment_central(x, 3),
    m4 = sample_moment_central(x, 4),
    skewness = sample_skewness(x),
    excess = sample_excess(x)
  )
}

# Analyze one sample
analyze_one <- function(x, p, plot=FALSE, id=0) {
  kgrid <- min(x):max(x)
  stats <- sample_stats(x)
  cat(mean(x))
  if (plot) {
    plot_cumulative_relative(x, id = id)
    plot_frequency_polygon(x, id = id)
  }
  stats
}

# ----------------------------------------

p <- 0.2                 
n <- 50                 
kgrid <- 0:50   
alpha = 0.1

# 2
plot_geom_density(prob=p, max_k=n)
plot_geom_cdf(prob=p, max_k=n)

# 3
cat("=== Theoretical stats (Geometric, p=", p, ") ===\n", sep="")
print(theoretical_stats_geom(p))

# 4
cat("\n=== Sample stats ===\n")
x <- generate_geom_sample(n)
cat(x, sep=" ")
cat("\n")
# 5
res50 <- analyze_one(x, p, id = n)
print(res50)

# 6
plot_cumulative_relative(x)
plot_frequency_polygon(x)

# 7
plot_geom_CDF_corridor(x, p, id = n)

# 8. 
cat("\n=== Comparison table ===\n")

theor <- theoretical_stats_geom(p)
table <- data.frame()
table <- rbind(table, data.frame(
  type = "sample",
  n = n,
  mean = res50$mean,
  sd = res50$sd,
  skew = res50$skewness,
  excess = res50$excess
))
table <- rbind(table, data.frame(
  type = "theor",
  n = n,
  mean = theor$mean,
  sd = theor$sd,
  skew = theor$skewness,
  excess = theor$excess
))
numeric_cols <- sapply(table, is.numeric)
table_rounded <- table
table_rounded[, numeric_cols] <- round(table_rounded[, numeric_cols], 4)
print(table_rounded)

# 9 
ns_all <- c(50,150,200,300,500)
for (ni in ns_all) {
  x <- generate_geom_sample(ni)
  res <- analyze_one(x, p, plot= TRUE, id=ni)
  plot_geom_CDF_corridor(x, p, id = ni)
}