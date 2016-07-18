library(quantmod)

# acquire data
sh <- getSymbols(Symbols = '000001.SS', auto.assign = F)
sh <- sh[1:dim(sh)[1]-1,]

# generate % change and weekday
sh.p.change <- Delt(sh[,6])
day.of.week <- weekdays(index(sh))
data.container <- data.frame(day.of.week, sh.p.change*100)[-1,]
colnames(data.container) <- c('weekday', 'p.change')

by(data.container$p.change, data.container$weekday, mean)
by(data.container$p.change, data.container$weekday, sd)
quantile.data <- by(data.container$p.change, data.container$weekday,
   function(x) quantile(x, probs = seq(0,1,0.05)))
quantile.table <- data.frame(quantile.data$星期一, quantile.data$星期二,
                             quantile.data$星期三, quantile.data$星期四,
                             quantile.data$星期五)
write.csv(quantile.table, "output.csv")
