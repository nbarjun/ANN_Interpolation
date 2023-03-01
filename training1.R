rm(list=setdiff(ls(),"day"))
print(paste('--------------------------Training For Day',day,'--------------------------'),sep="",collapse="")
setwd('/Volumes/RAID5/Projects/Ar_ANN')
library("caret")
library("matrixStats")
load('TrainData.Rda')

tr_dat <- createDataPartition(y=1:nrow(dataset),p=.8,list=FALSE)
dataset <- dataset[tr_dat,] 
testset <- dataset[-tr_dat]
dsz=dim(dataset)

maxs <- array(data=colMaxs(dataset),dim=c(1,dsz[2]))
mins <- array(data=colMins(dataset),dim=c(1,dsz[2]))
dats <- as.data.frame(scale(dataset,center=mins,scale=maxs-mins),dim = c(dsz[1],dsz[2]))

colnames(dats)<-c("X1","X2","X3","X4","X5","X6","X7","X8","X9")
n <- names(dats[1,1:8])
#----------------------------------
#  Defining the Neural Network
#----------------------------------
f <- as.formula(paste("X9~", paste(n[!n %in% "X9"], collapse = " + ")))
if (day == 15)
{
  model=pcaNNet(f,dats ,linout = TRUE, trace = TRUE, size=10, maxit=10000, abstol=0.0000001,rang=0.5,MaxNWts=500)#,Wts=Dnnet$model$wts)
}else
{
  load("Model.Rda")
  model=pcaNNet(f,dats ,linout = TRUE, trace = TRUE, size=10, maxit=10000, abstol=0.0000001,rang=0.5,MaxNWts=500,Wts=model$model$wts)
}
#----------------------------------
#  Saving the Neural Network
#----------------------------------
save(dats,model,maxs,mins,file = "Model.Rda")
