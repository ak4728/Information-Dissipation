library(ggplot2)
library(sqldf)
twoF<-read.csv("E:\\Dropbox\\C2SMART Center Dropbox\\Abdullah Kurkcu\\Abdullah_Kurkcu\\Publications_Abdullah\\2018-TRB\\Information Dissipation Paper\\Data\\DensityvsTsTT.csv",head=TRUE)
head(twoF)

# Average Speed vs Average Stop Time
ggplot(twoF,aes(x= Link.Speed, y=Link.Stop.Time)) +
  geom_point(shape=18,size=3,alpha=0.4)+
  geom_smooth(method='lm',formula=y~x, se=FALSE,color='red')+
  xlab("Average Speed (mph)")+
  ylab("Average Stop Time (seconds)") +
  scale_color_manual(name="Legend", values = c("blue"))+
  scale_x_continuous(expand = c(0, 0),limits=c(4,35)) + 
  scale_y_continuous(expand = c(0, 0),limits=c(0,5))+
  theme(axis.text.x = element_text(size=16), 
        axis.title.x= element_text(size=16, hjust=0.5, vjust=0.2))+
  theme(axis.text.y = element_text(colour = 'black', size = 12),
        axis.title.y = element_text(size = 16,
                                    hjust = 0.5, vjust = 0.2))+
  theme(panel.background = element_rect(fill = "#FFFFFF", colour = "#000000"))+ 
  theme(panel.grid.major = element_line(colour = "grey",linetype='dashed'), panel.grid.minor.x = element_line(colour="grey", linetype="dashed"),
        strip.text.x = element_blank())+
  theme(legend.position="none")

grob3 = grobTree(textGrob(paste("Pearson Correlation : ", round(cor(twoF['tf.u.est'], twoF['Link.Speed']), 4) ), 
                          x = 0.63, y = 0.97, hjust = 0, gp = gpar(col = "red", fontsize = 11, 
                                                                   fontface = "bold")))

# Average Speed vs Estimated Speed
ggplot(twoF,aes(x= u.obs, y=u.est.n)) +
  geom_point(shape=18,size=3,alpha=0.4)+
  geom_line(aes(x=seq(0,1,1/575),y=seq(0,1,1/575)), color='blue',size=1,alpha=0.3)+
  xlab("Speed - Simulation")+
  ylab("Estimated Speed - Two Fluid Theory") +
  scale_color_manual(name="Legend", values = c("blue"))+
  scale_x_continuous(expand = c(0, 0),limits=c(0,1)) + 
  scale_y_continuous(expand = c(0, 0),limits=c(0,1))+
  theme(axis.text.x = element_text(size=16), 
        axis.title.x= element_text(size=16, hjust=0.5, vjust=0.2))+
  theme(axis.text.y = element_text(colour = 'black', size = 12),
        axis.title.y = element_text(size = 16,
                                    hjust = 0.5, vjust = 0.2))+
  theme(panel.background = element_rect(fill = "#FFFFFF", colour = "#000000"))+ 
  theme(panel.grid.major = element_line(colour = "grey",linetype='dashed'), panel.grid.minor.x = element_line(colour="grey", linetype="dashed"),
        strip.text.x = element_blank())+
  theme(legend.position="none")

twoF['k.obs']
# Average Density vs Estimated Density
ggplot(twoF,aes(x= k.obs, y=kprime)) +
  geom_point(shape=18,size=3,alpha=0.4)+
  geom_line(aes(x=seq(0,1,1/575),y=seq(0,1,1/575)), color='blue',size=1,alpha=0.3)+
  xlab("Density - Simulation")+
  ylab("Estimated Density - Two Fluid Theory") +
  scale_color_manual(name="Legend", values = c("blue"))+
  scale_x_continuous(expand = c(0, 0),limits=c(0,1)) + 
  scale_y_continuous(expand = c(0, 0),limits=c(0,1))+
  theme(axis.text.x = element_text(size=16), 
        axis.title.x= element_text(size=16, hjust=0.5, vjust=0.2))+
  theme(axis.text.y = element_text(colour = 'black', size = 12),
        axis.title.y = element_text(size = 16,
                                    hjust = 0.5, vjust = 0.2))+
  theme(panel.background = element_rect(fill = "#FFFFFF", colour = "#000000"))+ 
  theme(panel.grid.major = element_line(colour = "grey",linetype='dashed'), panel.grid.minor.x = element_line(colour="grey", linetype="dashed"),
        strip.text.x = element_blank())+
  theme(legend.position="none")
