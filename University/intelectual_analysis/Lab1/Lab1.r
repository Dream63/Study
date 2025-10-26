setwd("D:\\Study\\R\\Lab1") # set working directory

n <- 20 # starting index
y_length <- 100 # data length
m <- 5 # num of intervals

y <- read.csv("numbers_list.csv")

#1
y_vec <- as.numeric(unlist(y[[1]]))

end <- min(n + y_length - 1, 250)
y_vec <- y_vec[n:end]

#2
y_sorted <- sort(y_vec)
print_first <- 3
print_last <- 3
cat("Selection of", y_length, "numbers from general selection starting from index", n, # nolint
    ":\n")
cat(y_sorted[1:print_first], sep = ", ")
cat("\n...\n")
cat(y_sorted[(y_length - print_last + 1):y_length], sep = ", ")

#3
min_val <- min(y_sorted)
max_val <- max(y_sorted)
delta <- (max_val - min_val) / m
cat("\n\nNumber of intervals:", m)
cat("\nDelta (interval width):", delta, "\n")

#4
if (y_length %% m != 0)
  stop("\n >>> Data length must be divisible by number of intervals")

x <- c()
for (j in 1:m) {
  interval_center_offset <- delta * (j - 0.5)
  xj <- min_val + interval_center_offset
  x <- c(x, xj)
}
cat("\nCenters of intervals:\n")
cat(x, sep = ", ")

#5
breaks <- seq(min_val, max_val + 1e-8, length.out = m + 1)
freq_vector <- table(cut(y_sorted, breaks = breaks, right = FALSE))
cat("\nFrequencies of intervals:\n")
print(as.matrix(freq_vector))

#6
png("Graphic\\!!!!Histogram.png")
barplot(freq_vector, names.arg = round(x, 2),
        xlab = "Interval Centers", ylab = "Frequencies",
        main = "Histogram of Frequencies", col = "lightblue")
dev.off()

png("Graphic\\!!!FreqPolygon.png")
plot(x = x, y = as.matrix(freq_vector), type = "b", pch = 19, col = "red",
     xlab = "Interval", ylab = "Frequency",
     main = "Frequency polygon")
dev.off()

#7
c_freq <- cumsum(freq_vector)

c_freq_vector <- as.matrix(c_freq)
cat("Cumulative frequencies of intervals:\n")
print(c_freq_vector)

#8
rel_c_freq <- c_freq / y_length

rel_c_freq_vector <- as.matrix(rel_c_freq)
cat("Relative cumulative frequencies of intervals:\n")
print(rel_c_freq_vector)

png("Graphic\\!!CFreqPolygon.png")
plot(x = x, y = c_freq, type = "b", pch = 19, col = "red",
     xlab = "Interval", ylab = "Cumulative frequency",
     main = "Cumulative Frequency polygon")
dev.off()

png("Graphic\\!RelCFreqPolygon.png")
plot(x = x, y = rel_c_freq, type = "b", pch = 19, col = "red",
     xlab = "Interval", ylab = "Relative cumulative frequency",
     main = "Relative cumulative Frequency polygon")
dev.off()