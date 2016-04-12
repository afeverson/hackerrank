#getting the input data
n <- as.integer(read.table('/dev/stdin', nrow = 1, header = F))
data <- read.table('/dev/stdin', skip = 1, nrow = n, header = T)

#splitting the data into testing and training sets based on missing values
train <- data[grep('Missing', data$tmax, invert = T),]
train <- train[grep('Missing', train$tmin, invert = T),]
test_max <- data[grep('Missing', data$tmax),]
test_min <- data[grep('Missing', data$tmin),]

#models built for tmax and tmin 
max_mod <- lm(tmax~., train)
min_mod <- lm(tmin~., train)

max_mod
min_mod
