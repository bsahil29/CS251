#include<stdio.h>
#include<stdlib.h>
#include<pthread.h>
#include<fcntl.h>
#include<string.h>
#define USAGE_EXIT(s) do{ \
                             printf("Usage: %s <# of elements> <# of threads> \n %s\n", argv[0], s); \
                            exit(-1);\
                    }while(0);

#define TDIFF(start, end) ((end.tv_sec - start.tv_sec) * 1000000UL + (end.tv_usec - start.tv_usec))

struct account{
                int acc_id;
                float acc_balance;  
};
struct account *acc;
int N;
struct args{
    int *arg1,*arg3,*arg4;
    float *arg2;
    struct account *arg5 ;
};
pthread_mutex_t lock,lock1,locks[11001];
int I=0;
void fun(void *arg)
{
		struct args *a=(struct args *)arg;
		while(1)
		{
			pthread_mutex_lock(&lock);
			int i=I;
			
			pthread_mutex_unlock(&lock);
			if(i>=N){
			break;
			}
			pthread_mutex_lock(&lock1);
			pthread_mutex_lock(&locks[(a->arg3)[I]]);
			if ((a->arg1)[I]==4){
				pthread_mutex_lock(&locks[(a->arg4)[I]]);
			}
			pthread_mutex_unlock(&lock1);
			acc=a->arg5;
			//printf("SSS%d %f\n",acc[(a->arg3)[I]-1001].acc_id,acc[(a->arg3)[I]-1001].acc_balance);
			switch((a->arg1)[I])
			{
				case 1:  acc[(a->arg3)[I]-1001].acc_balance=acc[(a->arg3)[I]-1001].acc_balance+0.99*(a->arg2)[I];
				//printf("-----%d---1-\n",I);
				     break;
				case 2:  acc[(a->arg4)[I]-1001].acc_balance=acc[(a->arg4)[I]-1001].acc_balance-1.01*(a->arg2)[I];
				//printf("-----%d---2--\n",I);
				     break;
				case 3:  acc[(a->arg3)[I]-1001].acc_balance=acc[(a->arg3)[I]-1001].acc_balance+0.071*acc[(a->arg3)[I]-1001].acc_balance;
				//printf("----%d----3--\n",I);
				     break;
				case 4:  acc[(a->arg3)[I]-1001].acc_balance=acc[(a->arg3)[I]-1001].acc_balance-1.01*(a->arg2)[I];
        			 	 acc[(a->arg4)[I]-1001].acc_balance=acc[(a->arg4)[I]-1001].acc_balance+0.99*(a->arg2)[I];
        			 	 //printf("-------%d---4----\n",I);
        				 pthread_mutex_unlock(&locks[(a->arg4)[I]]);
        				 break;
        	}
        	pthread_mutex_unlock(&locks[(a->arg3)[I]]);
        	//printf("***%d %f\n",acc[(a->arg3)[I]-1001].acc_id,acc[(a->arg3)[I]-1001].acc_balance);
        	I++;
		}	
		pthread_exit(NULL);
}
int main(int argc, char ** argv){
	FILE *fd1;
	struct timeval start, end;
	char c,*buf2,*cbuff,**txns;
	int fd2,T,i=0,j=0,ctr=0;
	unsigned long size,bytes_read=0;
	printf("%d",sizeof(struct account));
	acc=malloc(10000*sizeof(struct account));
	bzero(acc,10000*sizeof(struct account));
 	if(argc != 5){
            printf("Usage: %s <fileneme_account> <filename_transaction> <no of transactions> <no of threads> \n", argv[0]);
            exit(-1);         
    }  
    N=atoi(argv[3]);
    T=atoi(argv[4]);
    pthread_t threads[T];
    txns=(char**)malloc(N*sizeof(char*));
    for (i=0;i<N;i++)
    {
    	txns[i]=(char*)malloc(23*sizeof(char));
    }
    fd1 = fopen(argv[1],"r");
     if(fd1 < 0){
           printf("Can not open file\n");
           exit(-1);
     }
    fd2 = open(argv[2], O_RDONLY);
    if(fd2 < 0){
           printf("Can not open file\n");
           exit(-1);
    } 
    size = lseek(fd2, 0, SEEK_END);
    if(size <= 0){
           perror("lseek");
           exit(-1);
    }
    
    if(lseek(fd2, 0, SEEK_SET) != 0){
           perror("lseek");
           exit(-1);
    }
    int n=1;   
	char buf[100];
	for(n=1;n<10001;n++)
	{ 
	  	fscanf(fd1, "%s", buf);
	    acc[n-1].acc_id=atoi(buf);
	    fscanf(fd1, "%s", buf);
	    acc[n-1].acc_balance=atoi(buf);
	    //printf("%s amount of customer %d\n",&buf,a->acc_id);
	}

    buf2 = malloc(size);
    if(!buf2){
           perror("mem");
           exit(-1);
    }  
    do{
         unsigned long bytes;
         cbuff = buf2 + bytes_read;
         bytes = read(fd2, cbuff, size - bytes_read);
         if(bytes < 0){
             perror("read");
             exit(-1);
         }
        bytes_read += bytes;
     }while(size != bytes_read);
	cbuff=buf2+size;
	//printf("%s",buf2);
	int prev=0;
	for(i=0;i<N;i++)
	{
		ctr=0;
		for(j=1;j<size;j++)
		{
			if(buf2[prev+j]=='\n')
			{
				ctr=j;
				break;
			}
		}
		strncpy(txns[i],buf2+prev,j);
		prev=ctr+prev;
		//printf("%s",txns[i]);
	}
	int *type,*ac1,*ac2;
	float *amt;
	type=(int *)malloc(N*sizeof(int));
	amt=(float *)malloc(N*sizeof(float));
	ac1=(int *)malloc(N*sizeof(int));
	ac2=(int *)malloc(N*sizeof(int));
	

	for (ctr = 0; ctr < 11001; ctr++) {
		pthread_mutex_init(&locks[ctr],NULL);
	}
	pthread_mutex_init(&lock,NULL);
	pthread_mutex_init(&lock1,NULL);

	gettimeofday(&start, NULL);

	for(i=0;i<N;i++)
	{			
		int seq;
		sscanf(txns[i],"%d %d %f %d %d",&seq,&type[i],&amt[i],&ac1[i],&ac2[i]);
	}
	struct args argument;
	argument.arg1 = type;
    argument.arg2 = amt;
    argument.arg3 = ac1;
    argument.arg4 = ac2;
    argument.arg5 = acc;	
	for(i=0;i < T;i++){
		if(pthread_create(&threads[i],NULL,fun,(void*)&argument)!=0){
			perror("pthread_create");
            exit(-1);
		}
	}
	for(i=0; i < T; ++i){
    	pthread_join(threads[i], NULL);
	}

	gettimeofday(&end, NULL);

	for(ctr=0;ctr<10000;ctr++){
		int x=ctr;
		printf("%d\t%lf\n",x+1001,acc[ctr].acc_balance);
	}

	printf("Time taken = %ld microsecs\n", TDIFF(start, end));
	free(buf2);
	close(fd2);
	return 0;
}