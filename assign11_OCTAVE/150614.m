#STEP-1
data=csvread("train.csv");
#data
X_train=data(:,1);
X_train = X_train(2:end, :);
#X_train

Y_train=data(:,2);
Y_train = Y_train(2:end, :);
#Y_train

a=size(X_train);
#a(1)
one = ones(a(1),1);
X_train=[one,X_train];

#STEP-2
w=rand(2,1);

#STEP-3
figure(1)
plot(data(2:end,1), data(2:end,2),'go')
hold on
plot(data(2:end,1),(X_train*w),'r')
figure(2)
#size(data(2:end,1))
#size(X_train)
#size(w)
#size(X_train*w)
#size(X_train)
#size(X_train')
#size(Y_train)

#STEP-4
w_direct=inv(X_train'*X_train)*X_train'*Y_train;
plot(data(2:end,1), data(2:end,2),'go')
hold on
plot(data(2:end,1),(X_train*w_direct),'r')

#STEP-5
eta=0.00000001;
#disp(size(X_train(1)*w))
#disp(size(Y_train))
#disp(size(w))
#a(1)
figure(3)
plot(data(2:end,1), data(2:end,2),'go')
hold on
for i = 1:2
	for j = 1:a(1)
		b = eta*((X_train(j,:)*w)-Y_train(j)).*X_train(j,:)
		w = w - b'
		if (mod(j,1000) == 0)
			plot(data(2:end,1),(X_train*w),'r')
      hold on
    endif
   endfor
endfor

#STEP-6
figure(4)
plot(data(2:end,1), data(2:end,2),'go')
hold on
plot(data(2:end,1),(X_train*w),'r')

#STEP-7

data1=csvread("train.csv");
X_test=data1(:,1);
X_test = X_test(2:end, :);

Y_test=data1(:,2);
Y_test = Y_test(2:end, :);

a1=size(X_test);
one1 = ones(a1(1),1);
X_test=[one1,X_test];

function  ret = rms(predictions, targets,a1)
    ret = sqrt(sum(((predictions - targets)')*((predictions - targets)))/a1(1));
endfunction

Y_pred1=X_test*w;
rmse1=rms(Y_pred1,Y_test,a1);
#printf("rmse1=%f", rmse1)

Y_pred2=X_test*w_direct;
rmse2=rms(Y_pred2,Y_test,a1);

printf("rmse1=%f rmse2=%f", rmse1,rmse2)