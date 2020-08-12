# R tutorials
# assign
x <- 1;
y = 2;

# remove
rm(x,y);

# other names
x.1 = 13;
x_name = 'donny';
# illegal: number start
1x = 10;

# arithmatics
z = x^2 + sqrt(y);
w = log(x)+exp(x); #natural log and exponential
r = log2(x+2/2); #log base 2

# create vector
v_1 = c(1,2,3);
gender = c('male', 'female');
s_1 = c(1:10);
seq_1 = seq(from=1,to=10, by=2);
# rep( what, times )
ones = rep(1, 10); #(1,1,1,1,1,1,1,1,1);
donnies = rep('donny', 3);
rep_seq = rep(seq_1,3);

# vector arithmatics
a = c(1,2,3,4,5);
b = c(2,4,6,8,10);
a + 10;
a * 2 - b;
a/b; # divide by element

# calling elements(index starting from 1, not 0, as numpy)
a[3];
a[-3]; # everything but the 3rd element
b[c(1,2,4)]; # calling the 1st, 2nd and 4th elements
b[-c(1,2,4)];
filt = b<6; # apply a filter for elements
b[filt]; 
# b[b<6];

# creating matrix
mat_1 = matrix(c(1,2,3,4,5,6,7,8,9), nrow = 3, byrow = T);

# calling elements from matrix
mat_1[1,3]; # 1st row, 3rd column
mat_1[ ,3]; # all rows, 3rd column
mat_1[c(1,3),]; # 1st and 3rd row, all columns

# matrix arithmetics
mat_2 = mat_1 *2;
mat_2 + mat_1/mat_2;
mat_1 * mat_2; # multiply by elements, NOT matrix multiplication
mat_1 ** mat_2; # to the power by elements, ** == ^, NOT matrix multiplication
mat_1 %*% mat_2; # THE matrix multiplication %*%

# importing CSVs
file_1 <- read.csv(file='link', header = T); # use original header
# file_1 <- read.csv(file.choose(), header = T); # pop a window and choose
read.csv(file.choose(), header = T);

# importing tab delimited files .txt:
read.delim(file='link', header = T);
read.table(file.choose(), header = T, sep = '\t');

# readxl package and Import Dataset on the right top window
# write.table, write.csv command and Exporting Data from R
write.table(Name_of_Data, file = 'folder/folder/exportdata.csv', sep=',');
write.csv(Name_of_Data, file = 'folder/folder/exportdata.csv', row.names = F);

# data basics
LungCapData <- read.table(file='Z:/Engaging/R_learning/LungCapData.txt', header= TRUE, sep = '\t');

dim(LungCapData);
length(LungCapData); # number of variables
head(LungCapData);
tail(LungCapData);
names(LungCapData); # column/variable names
LungCapData[-(4:726),];
# $ for variables
mean(LungCapData$Age);
median(LungCapData$Height);
mode(LungCapData$LungCap); # this is the type of variable data, not the mode
# Create the function.
getmode <- function(v) {
  uniqv <- unique(v)
  uniqv[which.max(tabulate(match(v, uniqv)))]
};
getmode(LungCapData$Gender);

# attach to make variables available withouth calling object first
attach(LungCapData);
mean(Age);
detach(LungCapData); # detach it.

# data type: class or mode
class(LungCapData$Gender);
mode(LungCapData$Gender);

# summary: numeric gives mean,median,..., 
#          factor gives counts, 
#          character gives type.
summary(LungCapData);

# change from numeric to factor, count the levels(distinct different values)
x <- c(0,1,0,1,0,0,1,1,1,0);
x <- as.factor(x);
levels(x);
gender = LungCapData$Gender;
gender <- as.factor(gender);
summary(gender);
length(gender); 

# subsetting with filters in square brackets
attach(LungCapData);

mean(Age[Gender=='female']);
mean(Age[Gender=='male']);

FemData <- LungCapData[Gender=='female', ];
MaleData <- LungCapData[Gender=='male', ];

MaleOver15 <- LungCapData[Gender=='male' & Age>15, ];

# Logic commands
filter1 = Age >= 10;
filter2 <- as.numeric(filter1);

FemSmoke <- Gender == 'female' & Smoke == 'Yes';

# Useful commands
# 1. combine data/add new variables
MoreData = cbind(LungCapData,FemSmoke);

# 2. clean workspace
rm(list=ls());

## working directory
getwd();
setwd('Z:/Engaging/R_learning/Project 1 working directory');

# or
project1wd <-'Z:/Engaging/R_learning/Project 1 working directory';
setwd(project1wd);

# saving and loading the current workspace
save.image('Project1.Rdata');

rm(list=ls());
q();

setwd('Z:/Engaging/R_learning/Project 1 working directory');
getwd();
load('Project1.Rdata');
load(file.choose());

# installing and loading packages
install.packages("epiR");
remove.packages("epiR");

library(epiR);

# apply functions
StockData <- read.csv(file.choose(), header = T);

?apply;
# X of object, Margin : 1 = apply to rows, 2 = apply to columns 
apply(X=StockExample, MARGIN=2, FUN=mean);
apply(StockData, 2, max);
apply(StockData, 2, plot, type='l');
apply(StockData, 1, sum, na.rm=TRUE);
rowSums(StockData, na.rm=TRUE);

# tApply function: apply and group by
attach(LungCapData);
?tapply;
tapply(X=Age, INDEX=Smoke, FUN=mean, na.rm=TRUE);
# apply mean function to variable Age, group by the index Smoke.

tapply(Age, Smoke, summary);
tapply(Age, Smoke, quantile, probs=c(0.2,0.8));#the quantile of 20%

tapply(X=Age, INDEX=list(Smoke, Gender), FUN=mean, na.rm=TRUE);
#the above is the same as
mean(Age[Smoke='yes' & Gender='male']);
mean(Age[Smoke='yes' & Gender='female']);
mean(Age[Smoke='no' & Gender='female']);
mean(Age[Smoke='no' & Gender='male']);
#combined

# by command, return a vector
?by;
by(Age, list(Smoke, Gender), mean, na.rm=TRUE);
V_sgm <- by(Age, list(Smoke, Gender), mean, na.rm=TRUE);
V_sgm
# END









