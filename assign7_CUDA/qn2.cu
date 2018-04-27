#include<stdio.h>
#include<stdlib.h>
#include<sys/time.h>
#include<math.h>
#define CUDA_ERROR_EXIT(str) do{\
                                    cudaError err = cudaGetLastError();\
                                    if( err != cudaSuccess){\
                                             printf("Cuda Error: '%s' for %s\n", cudaGetErrorString(err), str);\
                                             exit(-1);\
                                    }\
                             }while(0);
#define TDIFF(start, end) ((end.tv_sec - start.tv_sec) * 1000000UL + (end.tv_usec - start.tv_usec))
__device__ unsigned int myxor(unsigned long x,unsigned long y)
{
    unsigned int  result = 0;
    for (int  i = 63; i >= 0; i--)                     
    {
       // Find current bits in x and y
       bool b1 = x & (1 << i);
       bool b2 = y & (1 << i);
        
        // If both are 1 then 0 else xor is same as OR
        bool xoredBit = (b1 & b2) ? 0 : (b1 | b2);          
 
        // Update result
        result <<= 1;
        result |= xoredBit;
    }
    return result;
}
__global__ void calculate(unsigned long *mem, unsigned long num,int iter)
{
    int  i = blockDim.x * blockIdx.x + threadIdx.x;
    if(i >= num)
           return;
    if(i<num/2){
		int temp=2*i;
		if(temp+iter<num)
			mem[temp]=myxor(mem[temp],mem[temp+iter]);
    }
}

int main(int argc, char **argv)
{
    struct timeval start, end, t_start, t_end;
    int i;
    unsigned long *ptr;
    unsigned long *gpu_mem;   
    unsigned long num,SEED;
    int  blocks=0;

    if(argc == 3){
         num = atoi(argv[1]);  
        SEED = atoi(argv[2]);
    }

    /* Allocate host (CPU) memory and initialize*/

    srand(SEED);
    ptr =(unsigned long*) malloc((num+1) * sizeof(unsigned long));
    for(i=0; i<num; ++i){
       ptr[i] = random();
    }
    ptr[i]=0;
    
    gettimeofday(&t_start, NULL);
    
    /* Allocate GPU memory and copy from CPU --> GPU*/

    cudaMalloc(&gpu_mem, (num+1) * sizeof(unsigned long));
    CUDA_ERROR_EXIT("cudaMalloc");

    cudaMemcpy(gpu_mem, ptr, (num+1) * sizeof(unsigned long) , cudaMemcpyHostToDevice);
    CUDA_ERROR_EXIT("cudaMemcpy");
    
    gettimeofday(&start, NULL);
    
    blocks = (num) /1024;
    
    if((num) % 1024)
           ++blocks;
    for(i=0;i<log(num)/log(2);i++)
    {
    	calculate<<<blocks, 1024>>>(gpu_mem, num,(int)pow(2,i));
    }
    CUDA_ERROR_EXIT("kernel invocation");
    gettimeofday(&end, NULL);
    
    /* Copy back result*/
    cudaMemcpy(ptr, gpu_mem, (num+1) * sizeof(unsigned long) , cudaMemcpyDeviceToHost);
    CUDA_ERROR_EXIT("memcpy");
    gettimeofday(&t_end, NULL);
    
    printf("Total time = %ld microsecs Processsing =%ld microsecs\n", TDIFF(t_start, t_end), TDIFF(start, end));
    cudaFree(gpu_mem);
    /*Print the last element for sanity check*/ 
    printf("XOR sum=%lu\n",ptr[0]);
    free(ptr);
}