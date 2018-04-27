#! /usr/bin/python
import numpy as np
import sys
import math
#from _future_ import print_function

n = 0 
def sort(arr):
     # copy collection to list
    for i in range(len(arr)-1, 0, -1):
        for j in range(i):
             if arr[j] > arr[j + 1]:
                 arr[j], arr[j + 1] = arr[j + 1], arr[j]
    return arr

#def sort(arr):
# for i in arr:
#  for j in arr:
#    if(arr[i-1]>arr[j-1]):
#      # print arr[i]
#       temp =arr[i-1]
#       arr[i-1]=arr[j-1]
#       arr[j-1]=temp

def print_tree(arr,start,end,level,ind):
   if(start>end): 
     return 0
   #tem=math.pow(2,level)
   mid =(start+end)/2
   M[level][ind]=arr[mid]
   #print M[level][ind]
   print_tree(arr,start,mid-1,level+1,2*ind)
   #print "%d\n" %(arr[mid])
   print_tree(arr,mid+1,end,level+1,2*ind+1)

def display(M,height):
   level = height
   depth = 0
   for i in range(height+1):
     ini=int(math.pow(2,level))-1
     fin=int(math.pow(2,depth))  
     mid=int(math.pow(2,level+1))   
     for l in range(ini):
       #print "inside"
       #print " "
       sys.stdout.write('     ')
       sys.stdout.flush()
     for j in range(fin):
       #print "in"
       #print "%d %d"%(i,j)
       print M[i][j],
       #sys.stdout.write(M[i][j])
       #sys.stdout.flush()
       for k in range(mid):
         sys.stdout.write('     ') 
         sys.stdout.flush()
     sys.stdout.write('\n')
     sys.stdout.flush()
     level=level-1
     depth=depth+1
             
strA = sys.argv[1].replace('[', ' ').replace(']', ' ').replace(',', ' ').split()
arr = [int(i) for i in strA]

#arr = np.array(eval(sys.argv[1]))
for i in arr:
 #print arr[i-1]
 n=n+1
 #print arr[1]

#print n
height=math.log(n,2)
#print height
height=int(height)
#print height
col=int(math.pow(2,height))
row=height+1
M = [ [ 0 for x in range(col)] for y in range(row)] 
sort(arr)

depth1=0
for i in range(height+1):
 fin=int(math.pow(2,depth1))
 for j in range(fin):
  M[i][j]=''
 depth1=depth1+1



print_tree(arr,0,n-1,0,0)
display(M,height)
#print M[1][0]
