
R <- 300 #coverage radius
r <- 9#normalized cov radius
delta <-5 #minimum distance between 2 vehs
ropi <-2 # occupation prob.
sigma <- 20# duration of backoff slot
Wj <-31 # contention window size
Ti <- 5# duration of message in time slots
D <-0.2 # hop delay in time slots
L <- 7# hop length
PA <- 8# message arrival probability at position y
PRynh <- 1# probability of first reception at position y time n in h hops
PRynbar <-1 # marginal probability of first reception at position y at time n 
PRyhbar <-1 # marginal probability of first reception at position y in h hops
PBy <-1 # message block probability
PTynhl <-1 # probability that the message is transmitted at pos y time n in h hops having received from a veh at distance l
PTynhbar <-1 # marginal probability that the message is trans at pos y time n h hops
PSyCbLl <-1 # prob that a veh y extracts a backoff b slots wins the contention the msg advancement is ueqalt to l positions
Mn <-1 # maximum dist reach by msg at time n
PMyn <- 1# dist of maximum distance reachehd by msg at time n 
  
df <- data.frame(matrix(NA, nrow = 150, ncol = 4))
colnames(df) <- c("ro","PA","PB","Wj")
for(i in 1:150){b<-runif(1,min=0,max=1);df$ro[i] <-b }
for(i in 1:150){df$Wj[i] <-31 }
df$PA[1]<-1
for(i in 2:r){df$PA[i] <- ro[i]}
PA <- df$PA
ro <- df$ro
PA
ro

a=1
for(j in 1:r){print(ro[j]);a = a * (1-ro[j])}
PA[r+1]<-1-a

PA


for(y in r+2:41){
  a = 1
  mi = y-r
  ma = y-1
  for(j in mi:ma){a = a * (1-ro[j])*PA[y-r-1]}
  PA[y] <- PA[y-1]-ro[y-r-1] *a
}

y=11

PA
PB <- df$PB
for(y in 1:41){
  a=1
  mi = y+1
  ma = y+r
  for(j in mi:ma){a = a * (1-ro[j])} 
  PB[y] <- ro[y]*PA[y]*a
}
PB

#backoff
b <- 20

for(j in 1:41){
PBb[j] <- 1 - ro[y-1+j] + ro[y-1+j] * (Wj-b+1)/(Wj+1)
}

PTynhl <- for(b in 0:Wt){PRynhbar * PSyCbLl}
PRynhbar <-for(l in 1:r){for(b in 0:Wt) {   } }

calcPSyCbLl<-function(y,b,l){
a = 1
for(j in 1:l-1){ a = a * (1 - ro[y-1+j] + ro[y-1+j] * (Wj-b+1)/(Wj+1)) }
c = 1
for(j in l+1:r){ c= c * 1 - ro[y-1+j] + ro[y-1+j] * (Wj-b+2)/(Wj+1)  }
PSyCbLl = ro[y]* 1/ (Wl + 1 ) * a * b
return(PSyCbLl)
}

calcPSyCbLl(10,20,5)
 
