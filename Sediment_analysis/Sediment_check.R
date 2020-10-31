library(ncdf4)

setwd("/Users/mmori/Atlantis_East_Ant/output_test_sed")
out<-nc_open("output.nc")
SED<-ncvar_get(out, "SED")


AGfile<-'/Users/mmori/Atlantis_MAO_test_input_CEPmod_set0/AntarcticGroupsnew.csv'
AntGroups<-read.csv(AGfile)

pdf("totalmass.pdf",30,25)
tuneon<-which(AntGroups$IsTurnedOn==1)
check_ages<-AntGroups$NumCohorts[tuneon]
par(mfrow=c(5,8))
for (i in 1:length(tuneon)){
  
  alltarget<-0
  target_N<-AntGroups$Name[tuneon[i]]
  
  if(target_N=="Cephalopods"){
    for (age in 1:check_ages[i]){
      Taget<-sprintf("%s_N%s",target_N,age)
      Target1<-ncvar_get(out,Taget)
      alltarget_t<-apply(Target1,3,function(x) sum(x))
      alltarget<-alltarget+alltarget_t
    }  
    
  }else if(check_ages[i] == 1){
    Taget<-sprintf("%s_N",target_N)
    Target1<-ncvar_get(out,Taget)
    if(length(dim(Target1))==3){
      alltarget_t<-apply(Target1,3,function(x) sum(x))  
    }else{
      alltarget_t<-apply(Target1,2,function(x) sum(x))    
    }
    alltarget<-alltarget+alltarget_t
    
  }else{
    
    for (age in 1:check_ages[i]){
      Taget<-sprintf("%s%s_Nums",target_N,age)
      Target1<-ncvar_get(out,Taget)
      alltarget_t<-apply(Target1,3,function(x) sum(x))
      alltarget<-alltarget+alltarget_t
    }
  }
  plot(time,alltarget,pch=20,col="black",xaxt="n", yaxt="n",xlab="time(days)",ylab=target_N,cex=0.5)
  lines(time,alltarget,xaxt="n", yaxt="n")
  axis(side = 1, at = seq(0,max(time),30))
  axis(side = 2, at = round(seq(0,max(alltarget),max(alltarget)/10)))
}
dev.off()
par(mfrow=c(1,1))


Totalbio<- read.table("outputBiomindx.txt",header=TRUE,sep=" ")

pdf("totalmass_r.pdf",30,25)
par(mfrow=c(6,8))
for (i in 2:47){
  plot(Totalbio$Time,Totalbio[,i],pch=20,col="black",xaxt="n",xlab="time(days)",ylab=sprintf("%s [ton]",colnames(Totalbio)[i]),cex=0.7)
  lines(Totalbio$Time,Totalbio[,i])
  axis(side = 1, at = seq(0,max(time),30))
  title(main=sprintf("%s [ton]",colnames(Totalbio)[i]))
  #axis(side = 2, at = round(seq(0,max(Totalbio[,i]),max(Totalbio[,i])/10),2))  
}
dev.off()
par(mfrow=c(1,1))

Recruits<- read.table("outputYOY.txt",header=TRUE,sep=" ")

Migration<-read.table("outputMigration.txt",header=TRUE,sep=" ")

boxbio<-read.table("/Users/mmori/Atlantis_MAO_test_input_CEPmod_vertc/output_test_r11/outputBoxBiomass.txt",header=TRUE,sep=" ")

ZS<-ZM<-ZL<-ZG<-matrix(0,1459,28)
for (i in 1:28){
  t<-which(boxbio$Box==i-1)
  ZS[,i]<-boxbio$ZS[t]
  ZM[,i]<-boxbio$ZM[t]
  ZL[,i]<-boxbio$ZL[t]
  ZG[,i]<-boxbio$ZG[t]
}




premort<-read.table("/Users/mmori/Atlantis_MAO_test_input_CEPmod_set0/output_test_r1/outputMortPerPred.txt",header=TRUE,sep=" ")


test<-read.table("larvalforce.ts",header=TRUE,sep=" ")

date<-seq(1,3650)
num<-num1<-rep(0,length(date))
target<-10+seq(0,3650,365)
num[target[1:length(target)-1]]<-4000
ta<-data.frame(date,num)
write.table(ta, file = "larvalforce.txt" ,quote = FALSE, row.names = FALSE)



