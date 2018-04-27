#!bin/awk
BEGIN{
}
{   
	gsub(/ > /,">")
	split($3,ip,/:$/)
	if($0 ~ /seq/ && $0 ~ /ack/ && $0 ~ /nop,nop,TS/)
	{
		num_packets[ip[1]]++
		num_bytes[ip[1]]+=$19
		if($19 >0)
		{
			num_datapkts[ip[1]]++
		}
	}
	if($0 ~ /seq/ && ! $0 ~ /ack/ && $0 ~ /sackOK/)
	{
		num_packets[ip[1]]++
		num_bytes[ip[1]]+=$19
		if($19 >0)
		{
			num_datapkts[ip[1]]++
		}
	}
	if($0 ~ /seq/ && $0 ~ /ack/ && $0 ~ /sackOK/)
	{
		num_packets[ip[1]]++
		num_bytes[ip[1]]+=$21
		if($21 >0)
		{
			num_datapkts[ip[1]]++		
		}
	}
	if( !($0 ~ /seq/) && $0 ~ /ack/)
	{
		num_packets[ip[1]]++
		num_bytes[ip[1]]+=$17
	}
	flag[ip[1]]=0
}
END{
	for(i in num_packets)
	{
	    split(i,ippair,/>/)
	    A=ippair[1]
	    B=ippair[2]
	    j=B">"A
	    if(flag[A">"B] == 0 && flag[B">"A] == 0)
	    {
	   		print "Connection (A = "A", B = "B")"
       		print "A-->B" "  #of packets = " num_packets[i] " #of data packets= " num_datapkts[i] " #Data (bytes)= " num_bytes[i] " #Retransmitted (bytes) = "" #Throughput= """
       		print "B-->A" "  #of packets = " num_packets[j] " #of data packets= " num_datapkts[j] " #Data (bytes)= " num_bytes[j] " #Retransmitted (bytes) = "" #Throughput= """
       		flag[A">"B]++
       		flag[B">"A]++
       	}
    }
}