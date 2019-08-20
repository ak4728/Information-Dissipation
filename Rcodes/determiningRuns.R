library(ggplot2)
library(sqldf)
detRuns<-read.csv("E:\\Dropbox\\C2SMART Center Dropbox\\Abdullah Kurkcu\\Abdullah_Kurkcu\\Publications_Abdullah\\2018-TRB\\Information Dissipation Paper\\Data\\determiningRuns.csv",head=TRUE)

detRuns  = detRuns[-1,]

# Standard Deviation change
ggplot(detRuns,aes(y=abs(stdiff), x=3:20)) + 
  geom_point(shape=17,size=4)+
  geom_line(aes(y=abs(stdiff), x=3:20, color='blue',linetype="Simulation"))+
  xlab("Runs of the model")+
  ylab("Change in Standard Deviation") +
  scale_color_manual(name="Legend", values = c("blue"))+
  theme(axis.text.x = element_text(size=16), 
        axis.title.x= element_text(size=16, hjust=0.5, vjust=0.2))+
  theme(axis.text.y = element_text(colour = 'black', size = 12),
        axis.title.y = element_text(size = 16,
                                    hjust = 0.5, vjust = 0.2))+
  theme(panel.grid.major = element_line(colour = "grey",linetype='dashed'), panel.grid.minor.x = element_line(colour="grey", linetype="dashed"),
        strip.text.x = element_blank())+
  theme(panel.background = element_rect(fill = "#FFFFFF", colour = "#000000"))+ 
  theme(legend.position="none")

# Standard error of the mean
ggplot(detRuns,aes(y=abs(mean), x=3:20)) + 
  geom_point(shape=17,size=4)+
  geom_line(aes(y=abs(mean), x=3:20, color='blue',linetype="dashed"))+
  geom_errorbar(aes(ymin=mean-ï..std, ymax=mean+ï..std, color='Simulation',linetype="Simulation"), 
                width=0.5,size=1,alpha=0.3) +
  xlab("Runs of the model")+
  ylab("Mean Information Dissipation Time (Seconds)") +
  ylim(3,12)+
  scale_color_manual(name="Legend", values = c("blue",'blue'))+
  theme(axis.text.x = element_text(size=16), 
        axis.title.x= element_text(size=16, hjust=0.5, vjust=0.2))+
  theme(axis.text.y = element_text(colour = 'black', size = 12),
        axis.title.y = element_text(size = 16,
                                    hjust = 0.5, vjust = 0.2))+
  theme(panel.background = element_rect(fill = "#FFFFFF", colour = "#000000"))+ 
  theme(legend.position="none")
