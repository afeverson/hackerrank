# Enter your code here. Read input from STDIN. Print output to STDOUT
#getting the input data
n <- as.integer(read.table('/dev/stdin', nrow = 1, header = F))
data <- read.table('/dev/stdin', skip = 1, nrow = n, header = T)
data$month <- match(data$month, month.name)

#splitting the data into testing and training sets based on missing values
train <- data[grep('Missing', data$tmax, invert = T),]
train <- train[grep('Missing', train$tmin, invert = T),]
test_max <- data[grep('Missing', data$tmax),]
test_min <- data[grep('Missing', data$tmin),]
train$tmax <- as.numeric(as.character(train$tmax))
train$tmin <- as.numeric(as.character(train$tmin))


test_max$tmin <- as.numeric(as.character(test_max$tmin))
test_min$tmax <- as.numeric(as.character(test_min$tmax))

#figuring the periods for temp (probably ~12 but just to be sure)
max_spc <- spectrum(train$tmax)
min_spc <- spectrum(train$tmin)
max_per <- 1/max_spc$freq[max_spc$spec == max(max_spc$spec)]
min_per <- 1/min_spc$freq[min_spc$spec == max(min_spc$spec)]

#models built for tmax and tmin 
max_mod <- lm(tmax~tmin+yyyy+sin(2*pi/max_per*month)+cos(2*pi/max_per*month), train)
min_mod <- lm(tmin~tmax+yyyy+sin(2*pi/min_per*month)+cos(2*pi/min_per*month), train)

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

#ordering the output data appropriately
final$miss <- as.numeric(substr(final$miss,9,100))
ans <- data.frame()
for (i in 1:100){
    ans <- rbind(ans, final[i,])
    }

write.table(ans[order(ans$miss),]$pred, row.names = F, col.names = F, quote = F)
