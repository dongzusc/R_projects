# Distributions: binomial, normal, Poisson, student T

# Binomial: dbinom, pbinom
?dbinom;
?pbinom;
# k success on n trials with p for success probability: 
# P(x=k)=kCn p^k (1-p)^(n-k)

dbinom(3, 20, 0.3); # dbinom(k,n,p)
dbinom(x=3, size=20, prob= 0.3);

# P(x=k1) & P(x=k2) & ...
dbinom(x=0:3, size=20, prob=0.3);

# P(x<=k)
sum( dbinom(x=0:3, size=20, prob=0.3));
#or
pbinom(q=3, size=20, prob=0.3, lower.tail = T);
#q=k, size=n, prob=p, lower.tail: less than or equal to k

?rbinom;
rbinom(n=20, size=100, prob = 0.5);
?qbinom;



# Poisson distribution ppois, dpois
# 
?ppois

# x=occurances, lambda= average occurance per period
# P(x=4), lambda =7:
dpois(x=4, lambda=7);

# P(x=0) & P(x=1) & ... & P(x=4)
dpois(x=0:4, lambda = 7);

# P(x<=4):
sum(dpois(x=0:4, lambda = 7));
# or
ppois(q=4, lambda=7, lower.tail=T);

# P(x>=12):
ppois(q=12, lambda=7, lower.tail = F);



# Normal distributions N(mu, sigma)
# propability
?pnorm; 
# P(x<=70), mean = 75, SD = 5
pnorm(q=70, mean=75, sd=5, lower.tail = T);
# P(x>=85)
pnorm(q=85, mean=75, sd=5, lower.tail = F);
# P(Z>=1) standard normal, Z
pnorm(q=1, mean = 0,sd = 1, lower.tail = F);

# quantile:
?qnorm;
# find Q1(lower 1st quantile)
qnorm(p=0.25, mean = 75, sd = 5, lower.tail = T);

#density:
?dnorm;

# find a probability distribution of mean= 75, sd= 5, and plot
x<-seq(from=50, to= 100, by=0.25);
dens=dnorm(x,75,5);
plot(x,dens,las=1,type='l');
  abline(v=75);

# drawing random samples
?rnorm;
rand_1 <- rnorm(40, mean=75, sd=5);
#plot a histagram for the draw
hist(rand_1);

# t-distribution for p-values and critical values
# probability
?pt;
# for t-stat = 2.3, df=25, find one-sided p-value P(t>2.3):
pt(q = 2.3,df = 25,lower.tail = F);
# 2-sided p-value
2 * pt(q = 2.3,df = 25,lower.tail = F);

# confidence intervals:
?qt;
# find the t value for 95% 2 sided confidence interval:
qt(p=0.025, df=25, lower.tail = T);


# other distributions
#F-distribution
?pf;

#Exponential distribution
?pexp;

#chi-square distribution
?pchisq;
