 	lambda <- 0.2
 	num_samples<- 50000
 	data <- rexp(num_samples, lambda)
 	x <- data.frame(X = seq(1, num_samples , 1), Y = sort(data))

plot(x)

y <- split(data,sample(1:500))

pdata <- rep(0, 100);
mean <- rep(0,100);
sd <- rep(0,100);

for(j in 1:5){
	vec <- unlist(y[j], use.names = TRUE)
	for(i in 1:100){
    	val=round(vec[i], 0);
    	pdata[val] = pdata[val] + 1/ 100; 
	}
	xcols <- c(0:99)
	str(pdata)
	str(xcols)
	plot(xcols, pdata, "l", xlab="X", ylab="f(X)")
	cdata <- rep(0, 100)

	cdata[1] <- pdata[1]

	for(i in 2:100){
    	cdata[i] = cdata[i-1] + pdata[i]
	}

	plot(xcols, cdata, "o", col="blue", xlab="X", ylab="F(X)");
}

for(i in 1:500){
	vec <- unlist(y[i], use.names = TRUE)
	mean[i] <- mean(vec);
	sd[i] <- sd(vec);
}

for(i in 1:5){
	print(mean[i])
	print(sd[i])
}

tab <- table(round(mean))

str(tab)
plot(tab, "h", xlab="Value", ylab="Frequency")

pdata <- rep(0, 100);

for(i in 1:500){
    val=round(mean[i], 0);
    pdata[val] = pdata[val] + 1/ 500; 
}

xcols <- c(0:99)

str(pdata)
str(xcols)

plot(xcols, pdata, "l", xlab="X", ylab="f(X)")

cdata <- rep(0, 100)

cdata[1] <- pdata[1]

for(i in 2:100){
    cdata[i] = cdata[i-1] + pdata[i]
}

plot(xcols, cdata, "o", col="blue", xlab="X", ylab="F(X)");
mean_original=mean(data);
sd_original=sd(data);
mean_means=mean(mean);
sd_means=mean(sd);
print(mean_original)
print(sd_original)
print(mean_means)
print(sd_means)




