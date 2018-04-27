#!/usr/bin/awk
BEGIN{
count=0
}
{
 if(NR==1)
  {for(i=1;i<9;i++)
  { col=i
   #print $col
   arr[$col]=i
   #print arr[$col]
  }
  init_flag=1
  }
 else
{
 pos=arr["USER"]
 if($pos!="") 
    user[$pos]++
 if(user[$pos]==1 && $pos!="")
  { 
    #print $pos
    count++
  }
 pos1=arr["PID"]
 pos3=arr["SZ"]
 if($pos1!="")
    pid[$pos1]++
 if(pid[$pos1]==1 && $pos!="")
  {#print "1"
   sz[$pos]=sz[$pos]+$pos3 
   np[$pos]++
}
 pos2=arr["TIME"]
 if($pos!="" && pos2!="")
   {
    ip_end=$pos2;
   split(ip_end,end,":");
   hr_s=end[1];
   min_s=end[2];
   sec_s=end[3];
   time[$pos]=time[$pos]+hr_s*3600+min_s*60+sec_s
   }
}
  
}
END{
  printf "No of users: %d\n",count
  for(i in user)
  { if(i!="")
   {
     printf "No of processes : %s = %d\n",i,user[i] 
   }
  }
  for(i in np)
  {
    printf "Total no of threads : %s = %d\n",i,np[i]
  }
  for(i in time)
  { 
    printf "Total CPU consumption : %s = %d\n",i,time[i] 
  }
  for(i in sz)
  {
    printf "Total Memory consumption : %s = %d\n",i,sz[i]
  }

} 
