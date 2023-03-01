rm(list=setdiff(ls(),"day"))
print(paste('--------------------------Prediction For Day',day,'--------------------------'),sep="",collapse="")
setwd('/Volumes/RAID5/Projects/Ar_ANN')
library("caret")
#----------------------------------
#  Load model and train data
#----------------------------------
load('TrainData.Rda')
load('Model.Rda')

stz=dim(sst)
nlon=stz[2]
nlat=stz[3]
sstp <- array(data=-999.00,dim = c(1,nlon,nlat))
mx=array(data=maxs[1:8],dim = c(1,8))
mn=array(data=mins[1:8],dim = c(1,8))
mxO=maxs[9]
mnO=mins[9]
for (i in 2:(nlon-1))
{
  for (j in 2:(nlat-1))
  {
    #print(paste('day=',day,'i=',i,'j=',j),sep="",collapse="")
    #select the 8 surrounding points of i,j
    dum=array(data=NaN,dim=c(1,8))
    dum[1]=sst[day-1,i-1,j+1]
    dum[2]=sst[day-1,i,j+1]
    dum[3]=sst[day-1,i+1,j+1]
    dum[4]=sst[day-1,i+1,j]
    dum[5]=sst[day-1,i+1,j-1]
    dum[6]=sst[day-1,i,j-1]
    dum[7]=sst[day-1,i-1,j-1]
    dum[8]=sst[day-1,i-1,j]
    #print(paste(dum))
    #Inputing 8 points surrounding (i,j) from k-1 time and getting 
    #the (i,j) point at time k.
    if (sum(is.nan(dum)) == 0)
    {  
      scaled <- as.data.frame(scale(dum,center=mn,scale=mx-mn))
      colnames(scaled)<-c("X1","X2","X3","X4","X5","X6","X7","X8")
      ss=predict(model,scaled)
      # print(paste(ss))
      st=ss*(mxO-mnO)+mnO
      # print(paste(st))
      sstp[1,i,j]=st
    }  
  }
}


#error=sstp[1,,]-sst[day,,]
#s1=as.numeric(sst[day,,])
#s2=as.numeric(sstp[1,,])
#e=as.numeric(error)
#output= cbind(sst[day,,],sstp[1,,],error)
if (nchar(day)==1)
{
  date=paste(c('0',toString(day)),sep="",collapse="")
  
}else
{
  date=toString(day)
}
filename=paste(c('./Output/Jan',date,'.txt'),sep="",collapse="")
fileID=file.create(filename)
write.table(sstp[1,,],filename,sep = "\n",col.names = FALSE,row.names =FALSE,quote=FALSE)