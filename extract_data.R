#Extract 8 points surrounding the point (i,j) at time k-1
#and the point (i,j) at time k. So total 9 points
extract_data = function(sst,nlon,nlat,day) 
{
  dat=array(data=NaN,dim=c(5000000,9))
  p=1
  for (k in 2:(day))
  {
    for (i in 2:(nlon-1))
    {
      for (j in 2:(nlat-1))
      { #print(paste(k,i,j))
        if (is.nan(sst[k,i,j]) == 0)
        { dum=array(data=NaN,dim=9)
          dum[1]=sst[k-1,i-1,j+1]
          dum[2]=sst[k-1,i,j+1]
          dum[3]=sst[k-1,i+1,j+1]
          dum[4]=sst[k-1,i+1,j]
          #print(paste(sst[k-1,i+1,j-1]))
          dum[5]=sst[k-1,i+1,j-1]
          dum[6]=sst[k-1,i,j-1]
          dum[7]=sst[k-1,i-1,j-1]
          dum[8]=sst[k-1,i-1,j]
          dum[9]=sst[k,i,j]
          if (sum(is.nan(dum)) == 0)
          {
            dat[p,]=dum
            p=p+1
            #print(paste(p))
          }  
        }
      
      }
    }
  }
  datas=array(data=dat[1:p-1,],dim=c(p-1,9))
  return(datas)
 }