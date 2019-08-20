library(ggplot2)

Data<-read.csv("ts-tt-paramics2.csv",head=TRUE)
colnames(Data)<- c("tstt","id")
Data <- subset(Data,as.double(as.character(tstt)) < 0.99 )
Data <- subset(Data,as.double(as.character(tstt)) > 0)


#ggplot(Data, aes(x = tstt)) + geom_histogram(aes(y = ..count..), stat = "count", bin = 20)

Data$estimated <- rnorm(1325, mean = 0.3619293, sd = 0.1280486)


# Plots the histogram
ggplot(Data) +
  geom_histogram(aes(x=tstt),alpha=0.3,binwidth=.01, colour="black", fill="blue")+
  geom_histogram(aes(x=estimated), alpha=0.3,binwidth=.01, colour="black", fill="red")



# Plotting density per sec
Data2<-read.csv("densitypersec.csv",head=TRUE)
colnames(Data2)<- c("count","transtime")
Data2$estimated <- rnorm(360, mean = 0.3619293, sd = 0.1280486)
Data2 <- subset(Data2,as.double(as.character(count)) > 75 )
# Plots the histogram
ggplot(Data2) +
  geom_histogram(aes(x=count),alpha=0.3,binwidth=20, colour="black", fill="blue")
  #geom_histogram(aes(x=estimated), alpha=0.3,binwidth=.01, colour="black", fill="red")


#ggplot(Data, aes(x=tstt)) + geom_density()

# Distribution Fitting Here 
library(fitdistrplus)
library(logspline)

descdist(Data$tstt, discrete = FALSE)

x = Data$tstt
x = Data2$count
mean(Data2$count)
fit.beta <- fitdist(x,"beta", method = "mle")
fit.norm <- fitdist(x,"norm", method = "mle")
fit.weibull <- fitdist(x,"weibull", method = "mle")
fit.gamma <- fitdist(x,"gamma", method = "mle")


fit.beta <- fitdist(x,"beta", method = "mle")
fit.norm <- fitdist(x,"norm", method = "mle")
fit.weibull <- fitdist(x,"weibull", method = "mle")
fit.gamma <- fitdist(x,"gamma", method = "mle")


summary(fit.beta)
summary(fit.norm)
summary(fit.weibull)
summary(fit.gamma)

fit.beta

rgamma(100, shape = 4.04 , rate = 7.22)

plot(fit.beta)
plot(fit.norm)
plot(fit.weibull)
plot(fit.gamma)

fit.weibull$aic
fit.norm$aic
fit.gamma$aic


ks.test(x, "pweibull", shape= fit.weibull$estimate["shape"] , scale = fit.weibull$estimate["scale"])
ks.test(x, "pnorm")
library(nortest) ## package loading
ad.test(x)
lillie.test(x)
shapiro.test(x)

plot(ecdf(x))

library(vcd)

gf <- goodfit(x, type= "binomial", method = "MinChisq")
plot(gf,main="Count data vs Poisson distribution")

y <- c(0,0,0.06,0.14,0.18,0.26,0.58,0.78,1.09,1.53,2.31,3.77,5.87,6.91,7.23)
x <- c(0,0.07,0.14,0.21,0.29,0.36,0.43,0.50,0.57,0.64,0.71,0.79,0.86,0.93,1)

fit1<-lm(y ~ poly(x,2,raw=TRUE))
fit1
library(splines)
xx <- seq(0,1, length.out=250)
plot(x,y, xlim=c(0,1), ylim=c(-1,8))
lines(xx, predict(fit1, data.frame(x=xx)), col='blue')
lines(x, y, col='red')

