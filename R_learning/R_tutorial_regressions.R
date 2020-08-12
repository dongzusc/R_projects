# regressions related topics
# importing data
LungCapData = read.csv(file='Z:/Engaging/R_learning/LungCapData.txt', 
                       sep = '\t', header = TRUE);
setwd('Z:/Engaging/R_learning/Project 1 working directory');
attach(LungCapData);

## Correlations and Covariances
?cor.test;
?cor;
# visualization:
plot(Age, LungCap);

# correlations:
cor(Age, LungCap, method='pearson');
cor(Age, LungCap, method='kendall');
cor(Age, LungCap, method='spearman');

# correlation test:
cor.test(Age, LungCap, method='pearson');

# Covariance
cov(Age, LungCap);

# all the pairwise plots to see relationships
NumericVariables=LungCapData[,1:3];# the 1~3 columns and all rows
pairs(NumericVariables);
cor(NumericVariables); # correlation matrix
cov(NumericVariables); # covariance matrix

# ANOVA
?aov;
ANOVA_1 = aov();
summary(ANOVA_1);
TukeyHSD(ANOVA_1);
plot(TukeyHSD(ANOVA_1));



### Simple Linear regressions lm(y~X1+...+Xk)

## e.g. Age and LungCap
# visualization
plot(Age, LungCap);
cor(Age, LungCap);

# linear regression
?lm;
model <- lm(LungCap~Age); # lm(y~X);
# model_2 <-lm(LungCap~Age+Height+Gender); # lm(y~X1+X2+X3)
summary(model);
anova(model);
abline(model); # add the regression line

## Cheking Linear regression assumptions
# 1. independent errors
# 2. homoskedasticity
# 3. linear relation
# 4. Normally distributed error
par(mfrow=c(2,2)); # make the 4 pictures in a single page
plot(model);
par(mfrow=c(1,1));


### Multiple linear regression between numeric variables
# y = b0 + b1*X1 +...+ bk*Xk
model_1 <-lm(LungCap~Age+Height); # lm(y~X1+X2)
summary(model_1);
confint(model_1);

# colinear
cor(Age, Height);

## Multiple Linear regression
model_2 <-lm(LungCap~Age+Height+Gender); # lm(y~X1+X2+X3)


## converting numeric variable into categorical
# convert Height into categorical
?cut; # default left open right closed
CatHeight <- cut(Height, breaks=c(0,50,55,60,65,70,100),
                 labels = c('A','B','C','D','E','F')); # 7 breaks, 6 intervals

#
cut(Height, breaks=c(0,50,55,60,65,70,100),
    right=F);# left close, right open

CatHeight[1:10];

# let R deside how to cut
cut(Height, breaks = 4, labels = c('1','2','3','4'));

# visualize
summ=summary(CatHeight);
pie(summ);


## Dummy & indicator variable
levels(CatHeight);

mean(LungCap[CatHeight=='A']);
mean(LungCap[CatHeight=='B']);
mean(LungCap[CatHeight=='C']);
mean(LungCap[CatHeight=='D']);
mean(LungCap[CatHeight=='E']);
mean(LungCap[CatHeight=='F']);

model <- lm(LungCap~CatHeight);
summary(model);

## to change baseline category
?relevel;
# example
model_3 <- lm(LungCap~Age+Smoke);
summary(model_3);
# y = beta0 + beta_Age * Age + beta_smoke * X_smoke,
# X_smoke = 1 in no, = 0 in yes.
# we want to change it to = 1 in yes, = 0 in no.
Smoke <- relevel(Smoke, ref = 'yes');
table(Smoke);



## Including categorical variables/factors in regression
# e.g. lungcap v.s. age and smoke
class(Smoke);

model_3 <- lm(LungCap~Age+Smoke);
summary(model_3);

# plotting the model
plot(Age[Smoke=='no'], LungCap[Smoke=='no'], 
     col='blue', ylim=c(0,15), 
     xlab='Age', ylab='LungCap', main = 'LungCap v.s. Age, Smoke');
  points(Age[Smoke=='yes'], LungCap[Smoke=='yes'], 
         col='red', pch = 16)
  legend(3,15, legend = c('Non-Smokers', 'Smokers'),
         col = c('blue','red'), pch=c(1,16), bty = 'n');
  # regression lines
  abline(a=1.08, b= 0.55, col = 'blue', lwd=3); # matching with non-smoker
  abline(a=0.43, b=0.55, col ='red', lwd=3);
  # the numbers come from the lm .

### multi-category categorical variables
model_2 = lm(LungCap~Age+CatHeight);
summary(model_2);

## InterAction with examples 

# e.g. interaction between age and smoke
model_4 <- lm(LungCap~Age*Smoke);
  # same as lm(LungCap~Age+Smoke+Age:Smoke); # X1:X2 is the interaction term 
summary(model_4);
coef(model_4);
# LungCap = beta0 + beta_age*Age + beta_smoke*Smoke + beta_(a:s)*age*smoke
# the interaction is the product of 2 variables.


###### Comparing models using partial F-test
## used to determine whether adding or removing a variable will make
## the model more efficient(SSE less, residual standard error less)

  ## F_stat = (SSE_reduced - SSE_full)/(# change in variables)
   ##        ------------------------------------------------
    ##                  Mean Squared Error_full    
  
## e.g.1: LungCap ~ Age+Gender+Smoke+Height 
## v.s.
## LungCap ~ Age+Gender+Smoke, removing Height, see if R^2 and Errors change
model_agsh = lm(LungCap~Age+Gender+Smoke+Height);
model_ags = lm(LungCap~Age+Gender+Smoke);

anova(model_agsh,model_ags);  # testing, F significant
  
## e.g.2: LungCap ~ Age
##  v.s.
## LungCap ~ Age + Age^2.

Full.Model <- lm(LungCap~Age+I(Age^2)); # I(X1^2) for squaring
Reduced.Model <- lm(LungCap~Age);
summary(Full.Model);
summary(Reduced.Model);

anova(Full.Model,Reduced.Model); # comparing F_stat, F not significant

  
  
### Polynomial Regression
plot(Height, LungCap);
## Grammar
  X1^2 is I(X1^2)
  
## or 
?poly;
## lm(y ~ poly(X, degree = 2, raw = T)) ## raw = F then orthogonal polynomials
## note, this is better when diciding what is the optimal degree.
  