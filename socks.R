# hackerrank
saved code from hackerrank porjects
T <- read.table("/dev/stdin",nrows = 1, sep=" ", header = F);
T <- as.list(as.data.frame(t(T)))

socks <- read.table("/dev/stdin",skip = 1, sep=" ", header = F);
socks <- as.numeric(as.data.frame(t(socks)))

T <- as.numeric(T)
df <- data.frame()

for (i in 1:T) {
    sock <- socks[i]+1
    df <- rbind(df,data.frame(sock))
}

write.table(df, sep = '', append = T, row.names = F, col.names = F)
