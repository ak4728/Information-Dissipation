library(ggplot2)
library(sqldf)
Data<-read.csv("lineplot.csv",head=TRUE)

colnames(Data)<- c("Density","Lambda","std","mn")
#Data <- subset(Data, Data$Lambda<10)


df <- sqldf("select Density,avg(Lambda) as mn, stdev(Lambda) as std from Data group by Density")

dCalc <- function(MP){
MP <- MP
crossover <- MP
Vf <- 35*1.467
L <- 0.5
n <- 3
Area <- 480
kjam <- 450/5280
C <- MP
lambda <- L/(Vf*kjam)
localD <- (1+((1-rnorm(1,0.21,0.29))^(n+1))/lambda)^(-1)
Lambda <- crossover * C * Area * localD * MP * kjam
return(Lambda)
}

meanC <- function(MP){x<-replicate(20, {
  mm <- dCalc(MP)
  mean(mm)
})
return(mean(x))
}

stdC <- function(MP){x<-replicate(20, {
  mm <- dCalc(MP)
  mean(mm)
})
return(sd(x))
}

estimated <- data.frame(matrix(ncol = 4,nrow=14))
colnames(estimated)<- c("Density","Lambda","mn","std")
estimated

estimated$Density <- df$Density

estimated$mn<-mapply(meanC, estimated$Density)
estimated$std<-mapply(stdC, estimated$Density)
Data$Density

Data$mn2 <- estimated$mn
Data$std2 <- estimated$std
#Data$mn <- Data$mn + 0.01
Data$mn[1] <- 0.03
nVehs <- 60
nVehsList <- c(60,27,27,28,25,700,800,900,1000,1100,1200,1300,1400)
Data$disTime <- nVehs/Data$mn
Data$disTime2 <- nVehs/Data$mn2
Data$disTime3 <- nVehsList/Data$mn2

# Standard error of the mean
ggplot(Data,aes(x=Density, y=mn)) + 
  geom_line(aes(x=Density, y=mn, colour="Simulation"))+
  geom_line(aes(x=Density, y=mn2, colour="Analytical"))+
  geom_errorbar(aes(ymin=mn-std, ymax=mn+std, colour="Simulation"), width=.1) +
  geom_point(aes(x=Density, y=mn))+
  geom_point(aes(x=Density, y=mn2))+scale_color_manual(values=c("#CC6666", "#9999CC"))

Data$mnplus <- nVehs/(Data$mn + Data$std)
Data$mnminus <- nVehs/(Data$mn - Data$std)
Data$mn2plus <- nVehs/(Data$mn2 + Data$std2)
Data$mn2minus <- nVehs/(Data$mn2 - Data$std2)
Data <- Data[2:14,]
Data$actualT <- c(1051.62,190.39,144.95,108.56,42.1,33.535,23.525,19.58,12.985,8.72,6,5.415,5.675)
Data$actualTsd <- c(755.8410447,146.0474252,137.911003,95.57844615,43.66266622,39.29174649,35.44435038,28.51527015,23.23314952,12.18340545,1.955558878,1.405730752,1.684566163)

#Data <- Data[2:14,]
# Standard error of the mean
ggplot(Data,aes(x=Density*100, y=actualT)) + 
  geom_line(aes(x=Density*100, y=actualT, linetype="Simulation"))+
  geom_line(aes(x=Density*100, y=disTime2, linetype="Analytical"))+
  geom_errorbar(aes(ymin=actualT-actualTsd, ymax=actualT+actualTsd, color='Simulation',linetype="Simulation"), width=3,size=1) +
  geom_errorbar(aes(ymin=disTime2-mn2plus, ymax=disTime2+mn2plus, color='Analytical',linetype="Analytical"), width=3,size=1,alpha=0.4) +
  geom_point(aes(x=Density*100, y=actualT),shape="Simulation")+
  geom_point(aes(x=Density*100, y=disTime2),shape="Analytical")+
  scale_color_manual(name="Legend", values = c("blue","red"))+
  scale_linetype_manual(name="Legend",values= c('solid' , 'dotdash')) +
  labs(linetype="Line Type")+
  xlab("Market Penetration Level (%)")+
  ylab("Information Dissemination Time (Seconds)") +
  xlim(0,100)+
  ylim(0,10000)+
  theme(axis.text.x = element_text(size=16), 
        axis.title.x= element_text(size=16, hjust=0.5, vjust=0.2))+
  theme(axis.text.y = element_text(colour = 'black', size = 12),
        axis.title.y = element_text(size = 16,
                                    hjust = 0.5, vjust = 0.2))+
  theme(panel.background = element_rect(fill = "#FFFFFF", colour = "#000000"))

#ggplot(estimated, aes(x=Density, y=mn)) + 
#  geom_errorbar(aes(ymin=mn-std, ymax=mn+std), width=.1) +
#  geom_line() +
#  geom_point()

mean(((Data$actualT-Data$disTime2)/(Data$actualT))[1:11])
((Data$actualT-Data$disTime2)/(Data$actualT))[1:11]
mean(abs(Data$actualT-Data$disTime2)[2:13])


ggplot(estimated, aes(x=Density, y=mn)) +
 geom_errorbar(aes(ymin=mn-std, ymax=mn+std), width=.1) +
 geom_line() +
 geom_point()

val = 250
m = 0.01
s = 0.99
s2 = 0.99
s3 = 0.99
s4 = 0.99
i = 0.01
lambda = 2.5
lambda20 = 0.14
lambda50 = 1.63
lambda100 = 7.36
res <- list()
res2 <- list()
res3 <- list()
res4 <- list()
for(n in 0:val){
sbar = -lambda*i*s
sbar2 = -lambda20*i*s2
sbar3 = - lambda50*i*s3
sbar4 = - lambda100*i*s4
s = s + sbar
s2 = s2 + sbar2
s3 = s3 + sbar3
s4 = s4 + sbar4
res[length(res)+1] = s
res2[length(res2)+1] = s2
res3[length(res3)+1] = s3
res4[length(res4)+1] = s4
}
d <- data.frame(y = unlist(res))
d$y20 <- unlist(res2)
d$y50 <- unlist(res3)
d$y100 <- unlist(res4)
d$x <- 0:val
d
library(grid)
library(gridExtra)
ggplot(d)+geom_line(aes(x=x, y=y*100,lty = "Constant Contact Rate"))+
  geom_line(aes(x=x, y=y20*100,lty = "20% MP Contact Rate"))+
  geom_line(aes(x=x, y=y50*100,lty = "50% MP Contact Rate"))+
  geom_line(aes(x=x, y=y100*100,lty = "100% MP Contact Rate"))+
  labs(linetype="MP=Market Penetration")+ xlab("Time (Seconds)")+
  ylab("Susceptible Population (%)") +
  theme(axis.text.x = element_text(size=12),
        axis.title.x= element_text(size=12, hjust=0.5, vjust=0.2))+
  theme(axis.text.y = element_text(colour = 'black', size = 12),
        axis.title.y = element_text(size = 12,
                                    hjust = 0.5, vjust = 0.2))


ebar = lambda*i*s - (m+g)*e
ibar = g * e - (g+m)*i
rbar = g*i - mr
