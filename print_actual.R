  ssta=array(data=-999,dim=c(nlon,nlat))
  nlat=length(lat)
  nlon=length(lon)
  for (i in 1:nlon)
  {
    for (j in 1:nlat)
    {
      if (is.nan(sst[day,i,j])== 0)
      {
        ssta[i,j]=sst[day,i,j]
      }
    }
  }
  if (nchar(day)==1)
  {
    date=paste(c('0',toString(day)),sep="",collapse="")
    
  }else
  {
    date=toString(day)
  }
  filename=paste(c('./Actual/Jan',date,'.txt'),sep="",collapse="")
  fileID=file.create(filename)
  write.table(ssta,filename,sep = "\n",col.names = FALSE,row.names =FALSE,quote=FALSE)