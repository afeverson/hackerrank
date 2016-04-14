#getting the input data
n <- as.integer(read.table('/dev/stdin', nrow = 1, header = F))
data <- read.table('/dev/stdin', skip = 1, nrow = n, header = T)

#splitting the data into testing and training sets based on missing values
train <- data[grep('Missing', data$tmax, invert = T),]
train <- train[grep('Missing', train$tmin, invert = T),]
test_max <- data[grep('Missing', data$tmax),]
test_min <- data[grep('Missing', data$tmin),]
train$tmax <- as.numeric(as.character(train$tmax))
train$tmin <- as.numeric(as.character(train$tmin))

test_max$tmin <- as.numeric(as.character(test_max$tmin))
test_min$tmax <- as.numeric(as.character(test_min$tmax))

#models built for tmax and tmin 
max_mod <- lm(tmax~., train)
min_mod <- lm(tmin~., train)

#applying models to the set with the missing values
max_pred <- predict(max_mod, test_max[,c(1,2,4)])
min_pred <- predict(min_mod, test_min[,c(1,2,3)])

fin_max <- data.frame(test_max$tmax)
fin_max$pred <- max_pred
colnames(fin_max) <- c('miss','pred')
fin_min <- data.frame(test_min$tmin)
fin_min$pred <- min_pred
colnames(fin_min) <- c('miss','pred')

final <- rbind(fin_max, fin_min)

ans <- final[sort(as.integer(substr(final$miss,9,100))),]

write.table(ans$pred, row.names = F, col.names = F, quote = F)
