flow_out<-nc_open("/Users/mmori/Atlantis_East_Ant/EAflow.nc")
Mass<-ncvar_get(flow_out,"exchange")
dest_h<-ncvar_get(flow_out,"dest_b")
dest_v<-ncvar_get(flow_out,"dest_k")

depth<-1
poly<-2
day<-2
who<-which(!is.na(Mass[,depth,poly,day]))
dest_h[who,depth,poly,day]
dest_v[who,depth,poly,day]
Mass[who,depth,poly,day]

new_Mass<-Mass


  for (poly in 1:28){
    for(depth in 1:10){
      who<-which(!is.na(Mass[,depth,poly,1]))
      if (length(who)>0){ 
     tar<-size<-rep(1,length(who))
    for (j in 1:length(tar)){
      tar[j]<-mean(abs(Mass[who[j],depth,poly,]))
      if(tar[j]>=50 &&tar[j]<100){
       size[j]==1/6
        }else if (tar[j]>=100 &&tar[j]<500){
          size[j]<-1/10
        }else if (tar[j]>=500 &&tar[j]<1000){
          size[j]<-1/15
        }else if (tar[j]>=1000 &&tar[j]<5000){
          size[j]<-1/25
        }else if (tar[j]>=5000 &&tar[j]<10000){
          size[j]<-1/75
        }else if(tar[j]>=10000){
          size[j]<- 0.0001
        }
    }  
      new_Mass[who,depth,poly,]<- Mass[who,depth,poly,]*size
        
         }
      }
    }


library(ncdf4)
setwd("/Users/mmori/Atlantis_East_Ant")
# Define netcdf dimensions: name, units and value
dim1 <- ncdim_def( # create a time dimension
  name = 't',
  units = 'seconds since 2000-01-01 00:00:00 +10',
  vals = as.double(seq(86400,86400*365,86400))
)
#as.double(seq(0,86400*365,86400)
dim2 <- ncdim_def( # create a box dimension
  name = 'b',
  units = 'num',
  vals = as.double(1:28)
)
dim3 <- ncdim_def( # create a box dimension
 name = 'z',
  units = 'num',
  vals = as.double(1:10)
)
dim4 <- ncdim_def( # create a box dimension
  name = 'dest',
  units = 'num',
  vals = as.double(1:44)
)

var.dim <- list(dim1,dim2,dim3,dim4)

ver1<-ncvar_def(name = as.character("exchange"),
                units = 'm^3', dim = var.dim, missval = 0, prec="double")

ver2<-ncvar_def(name = as.character("dest_b"),dim = var.dim, missval =-1, units = 'none')
ver3<-ncvar_def(name = as.character("dest_k"),
               dim = var.dim, missval =-1, units = 'none')

filename <- "/Users/mmori/Atlantis_East_Ant/EAflow_rev.nc"
outnc <- nc_create(filename,  list(ver1,ver2, ver3), force_v4 = TRUE)

# add global attributes
ncatt_put(nc = outnc, varid = 0, attname = 'title', attval = "trivial")
ncatt_put(nc = outnc, varid = 0, attname = 'geometry', attval = "Antarctica_28.bgm")
ncatt_put(nc = outnc, varid = 0, attname = 'parameters', attval = "")

ncvar_put(outnc,varid ="exchange",new_Mass)
ncvar_put(outnc,varid ="dest_b",dest_h)
ncvar_put(outnc,varid ="dest_k",dest_v)

nc_close(outnc)









Home<-"/Users/mmori/SETas_model_Trunk_Stripped_mao"
exchange.file    <- sprintf("%s/inputs/forcisets/SETAS_VMPAhydroA.nc",Home)
SETAS_out<-nc_open("/Users/mmori/Atlantis_East_Ant/EAflow.nc")
SMass<-ncvar_get(SETAS_out,"exchange")
Sdest_h<-ncvar_get(SETAS_out,"dest_b")
Sdest_v<-ncvar_get(SETAS_out,"dest_k")


depth<-3
poly<-3
day<-1
who<-which(!is.na(SMass[,depth,poly,day]))
Sdest_h[who,depth,poly,day]
Sdest_v[who,depth,poly,day]
SMass[who,depth,poly,day]