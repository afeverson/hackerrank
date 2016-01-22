# Enter your code here. Read input from STDIN. Print output to STDOUT
T <- read.table("/dev/stdin",nrows = 1, sep=" ", header = F);
T <- as.list(as.data.frame(t(T)))

oth <- read.table("/dev/stdin",skip = 1, sep=" ", header = F);
oth <- as.numeric(as.data.frame(t(oth)))

df <- data.frame()

T <-T[[1]][1]
s1 <- T[[1]][2]
s2 <- T[[1]][3]
times <- oth[1]

for (i in 1:times) {
    
}

#write.table(df, sep = '', append = T, row.names = F, col.names = F)
