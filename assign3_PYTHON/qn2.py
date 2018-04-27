import numpy as np
import matplotlib.pyplot as plt
#step1
f = open("train.csv", "r")
from numpy import genfromtxt
mydata = genfromtxt('train.csv', delimiter=',')
X_train=mydata[:,0]
X_train = X_train[1:]
y_train=mydata[:,1]
y_train=y_train[1:]
a=X_train.shape
X_train=X_train.reshape(a[0],1)
y_train=y_train.reshape(a[0],1)
one = np.ones((a[0],1))
X_train=np.column_stack((one,X_train))
#step2
w=np.random.random((2, 1))
#step3
plt.plot(mydata[1:,0], mydata[1:,1],'go')
#plt.show()
plt.plot(mydata[1:,0],X_train.dot(w),'r')
plt.show()
plt.figure(2)
#step4
w_direct=np.linalg.inv(X_train.transpose().dot(X_train)).dot(X_train.transpose()).dot(y_train)
plt.plot(mydata[1:,0], mydata[1:,1],'go')
plt.plot(mydata[1:,0],X_train.dot(w_direct),'r')
plt.show()
#step5-training
eta=0.00000001
for i in range(1,2):
	for j in range(0,a[0]):
		b = eta*(X_train[j].dot(w)-y_train[j])*X_train[j]
		b = b.reshape(2,1)
		w = w - b
		if j%100 == 0:
			plt.figure(3)
			plt.plot(mydata[1:,0], mydata[1:,1],'go')
			plt.plot(mydata[1:,0],X_train.dot(w),'r')
			plt.show()
	#print w
#step6
plt.figure(4)
plt.plot(mydata[:,0], mydata[:,1],'go')
plt.plot(mydata[1:,0],X_train.dot(w),'r')
plt.show()
#step7-Evaluation
f = open("test.csv", "r")
from numpy import genfromtxt
mydata1 = genfromtxt('test.csv', delimiter=',')
X_test=mydata1[1:,0]
y_test=mydata1[1:,1]
a1=X_test.shape
X_test=X_test.reshape(a1[0],1)
y_test=y_test.reshape(a1[0],1)
one1 = np.ones((a1[0],1))
X_test=np.column_stack((one1,X_test))
y_pred1=X_test.dot(w)
def rmse(predictions, targets):
    return np.sqrt(((predictions - targets) ** 2).sum()/a1[0])
rmse1=rmse(y_pred1,y_test)
print rmse1
y_pred2=X_test.dot(w_direct)
rmse2=rmse(y_pred2,y_test)
print rmse2