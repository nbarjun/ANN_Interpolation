#clear the enviornment
rm(list=ls())

#----------------------------------
#  LOAD REQUIRED PACKAGES
#----------------------------------
library("caret")
#define the number of points in the grid. The starting and ending point of the grid are read directly from the files
nlat=121
nlon=121

#Read the input data. The data are stored in multiple files in different directory. Make sure that the files provided are properly grided. Failing which
#can lead to wrong results.

#----------------------------------
#  LOADING INPUT FILES
#----------------------------------
#Change to required Path of input data
setwd("/Volumes/RAID5/Projects/Ar_ANN/Input_Data/")
srcfiles1 <- (Sys.glob("*.txt"))

f1  <- file.path("./Input_Data",srcfiles1)

setwd('/Volumes/RAID5/Projects/Ar_ANN')

#The data in the input files are listed in d and are later read into an array d1 of the dimensions grid_points(lat*lon) x 3 (lon,lat,sst) x No. of days
d1 <- lapply(f1, read.table)
d=array(unlist(d1), dim = c(nrow(d1[[1]]), ncol(d1[[1]]), length(d1)))

sz=dim(d)
nday=sz[3]
lon=d[1:nlon,1,1]
lat=d[seq(1,sz[1],nlon),2,1]

#Select only points if data is present for atleast 20 previous days.
#If the 40 concecutive time steps have no data. Don't consider it.
sst=array(data=NaN,c(sz[3],nlon,nlat))

for (p in 1:nday) 
{ k=1
for (i in 1:nlat) 
{for (j in 1:nlon)
{if (d[k,3,p] > 20.0 && d[k,3,p] < 41) 
{sst[p,j,i]=d[k,3,p]}
 else
  {sst[p,j,i]=NaN}
  k=k+1
}
}
}
#----------------------------------
#  PREDICTION FROM 15th to 31st DAY
#----------------------------------
for (k in 15:31)
{
  day=k-1
  source("extract_data.R")
  #Extract 5000000 data points. 
  dataset = extract_data(sst,nlon,nlat,day)
  #Save the extracted dataset
  save(lat,lon,sst,dataset,file="TrainData.Rda")
  day=k
  #Training module for the day k 
  source("training1.R")
  #Predicting SST for day k
  source("predict1.R")
  #Save the output SST for day k
  source("print_actual.R")
} 
