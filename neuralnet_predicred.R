library(neuralnet)

# 1. creating the initial data, plotting
data <- data.frame (
  input = c(0.225, 690, 2313, 2931, 4061, 4937, 5809, 7096, 8803, 10095, 12229, 13572),
  output = c(0.118, 274, 949, 1270, 1668, 2001, 2434, 3028, 3393, 4519, 5594, 7610)
)
plot(data$output ~ data$input, main="Distribution of the pension relative to the salary", xlab="Salary", ylab="Pension")

