mkd <- read.table('/dev/stdin', header = F, nrow = 1)
stocks <- read.table('/dev/stdin', sep = ' ', skip = 1, header = F)

trans <- data.frame()

for (stock in 1:as.integer(mkd[2])) {
    if (stocks[stock,6] <= stocks[stock,5] && stocks[stock,6] <= stocks[stock,4] && stocks[stock,6] <= stocks[stock,3]) {
        if (as.numeric(mkd[1]) >= as.numeric(stocks[stock,7])) {
            trans <- rbind(trans,c(as.character(stocks[stock,1]),'BUY',as.numeric(mkd[1])%/%as.numeric(stocks[stock,7])))
            mkd[1] <- mkd[1] - ((as.numeric(mkd[1])%/%as.numeric(stocks[stock,7]))*stocks[stock,7])
        }
    }
    if (stocks[stock,6] >= stocks[stock,5] | stocks[stock,6] >= stocks[stock,4] | stocks[stock,6] >= stocks[stock,3]) {
        if (stocks[stock,2] > 0) {
            trans <- rbind(trans, c(as.character(stocks[stock,1]),'SELL',stocks[stock,2]))
            mkd[1] <- mkd[1] + (stocks[stock,2]*stocks[stock,7])
        }
    }
    if (mkd[3] == 1) {
        if (stocks[stock,2] > 0) {
            trans <- rbind(trans, c(as.character(stocks[stock,1]),'SELL',stocks[stock,2]))
            mkd[1] <- mkd[1] + (stocks[stock,2]*stocks[stock,7])
        }
    }
}

write.table(as.integer(nrow(trans)), row.names = F, col.names = F, quote = F)
write.table(trans, row.names = F, col.names = F, quote = F)
