mkd <- read.table('/dev/stdin', header = F, nrow = 1)
stocks <- read.table('/dev/stdin', sep = ' ', skip = 1, header = F)

trans <- data.frame()
for (stock in 1:nrow(stocks)) {
    if (stocks[stock,6] <= stocks[stock,5] && stocks[stock,6] <= stocks[stock,4] && stocks[stock,6] <= stocks[stock,3]) {
        trans <- rbind(trans,c(as.character(stocks[stock,1]),'BUY',10))
    }
    if (stocks[stock,6] >= stocks[stock,5] || stocks[stock,6] >= stocks[stock,4] || stocks[stock,6] >= stocks[stock,3]) {
        if (stocks[stock,2] > 0) {
            trans <- rbind(trans, c(as.character(stocks[stock,1]),'SELL',stocks[stock,2]))
        }
    }
}

write.table(trans, row.names = F, col.names = F, quote = F)
