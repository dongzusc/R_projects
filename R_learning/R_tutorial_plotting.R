# Plottings

LungCapData = read.csv(file='Z:/Engaging/R_learning/LungCapData.txt', 
                       sep = '\t', header = TRUE);
setwd('Z:/Engaging/R_learning/Project 1 working directory');

attach(LungCapData);


# Bar Charts 
?barplot;
# good for frequency of categorical variable
count = table(Gender);
percent = count/length(Gender);

barplot(count);

barplot(percent, main='Title', xlab='Gender', ylab='%', names.arg = c('female', 'male'));
# Pie Charts
?pie;
pie(count, labels = names(count), clockwise = T, col =c('green','red'));
box();



# box plots
# box plots for summary of data
?boxplot;

boxplot(LungCap);
quantile(LungCap, probs= c(0,0.25,0.5,0.75,1));
boxplot(LungCap, main = 'Boxplot', ylab='lung capacity', ylim=c(0,16), las =1);

# ploting LungCap separeted by Gender
boxplot(LungCap~Gender, main = 'Boxplot', ylab='lung capacity', ylim=c(0,16), las =1);

# ploting LungCap separeted by Smoked
boxplot(LungCap~Smoke, main = 'Boxplot', ylab='lung capacity', ylim=c(0,16), las =1);
# same as
boxplot(LungCap[Smoke=='no'], LungCap[Smoke=='yes']);


# Stratified box plots
?cut;
AgeGroup = cut(Age, breaks = c(0,13,15,17,250), 
               labels = c('<13','14/15','16/17','18+'));
levels(AgeGroup);

# comparing boxplot in a single plot
boxplot(LungCap, ylab='lung capacity', main='BoxPlot of lungcap', 
        las=1);
boxplot(LungCap[Age>=18]~Smoke[Age>=18], ylab='lung capacity', 
        main='BoxPlot of lungcap for age 18+', las=1);

# comparing boxplot in all stratas
Smoke*AgeGroup;
#when catagorical times catagorical, 
#it becomes a table of catagories
boxplot(LungCap~Smoke*AgeGroup, ylab='lung capacity', 
        main='BoxPlot of lungcap for different age groups', 
        las=2, col=c('green','red'));
# col argument if colors are less than num of graphs, will cycle


# Histagrams
# summarizing distributions of a numerical value
?hist();

hist(LungCap);
hist(LungCap, freq = F);# become density, same as prob=T
hist(LungCap, freq = F, ylim=c(0,0.2), xlim=c(-5,20));

hist(LungCap, freq = F, ylim=c(0,0.2), xlim=c(-5,20), breaks = 7);
#8 bins, 7 breaks
#inputting breaks manuly
hist(LungCap, freq = F, ylim=c(0,0.2), xlim=c(-5,20), 
     breaks = c(0,3,6,9,12,15));
#or
hist(LungCap, freq = F, ylim=c(0,0.2), xlim=c(-5,20), 
     breaks = seq(from=0,to=16, by=2));
#adding a density curve
lines(density(LungCap), 
      col=2, lwd=3);


#Stem and Leaf plots
# good for smaller datasets, numerical
# not a graphic illustration
?stem;
stem(LungCap, scale=2);


# stack barcharts, clustered barcharts and mosaic plots
# good for examining relations between 2 catagorical variables
class(Gender);
class(Smoke);
class(Caesarean);
# first create a table of the 2 variables 
table1 = table(Gender, Smoke);

barplot(table1);#stacked
barplot(table1, beside=1);# clustered(side-by-side)
barplot(table1, beside=1, legend.text = T); #default lables
barplot(table1, beside=1, legend.text = c('girls','boys'));
barplot(table1, beside=1, 
        legend.text = c('girls','boys'), col=c('red','blue'),
        main='Smoke and Gender', 
        las=1,);


# scatter plots
# good for examining relationship between 2 numeric vairables
?plot;
cor(Age, Height);
plot(Age, Height, las=1, 
     main='Age v.s. Height',
     xlab='Age', ylab='Height',
     xlim=c(0,25),
     cex=0.5, #circle radius
     pch=3, # dot style
     col = 'red',
     );
#add a line
abline(lm(Height~Age), col = 'blue');



## producing numerical summary in plots
# quantify the center and spread

# catagorical: table
table(Smoke);
table(Smoke)/length(Smoke);

# numerical: mean, trimmed mean(remove top % and bottom %)
mean(Age);
mean(Age, trim=0.10);# top-bottom 10% trimmed
median(Age);
var(Age);
sd(Age);
(var(Age)-sd(Age)^2)-(sqrt(var(Age))-sd(Age));
min(Age);
max(Age);
range(Age);
quantile(Age, probs=0.90);
quantile(Age, probs=c(0.9,0.6,0.3));
sum(Age);#summation
summary(Age); # summary
cor(LungCap,Age); # correlation
cor(LungCap,Age, method = 'spearman'); # Spearman correlation
cov(LungCap,Age); # covariance, same as
var(LungCap,Age); # covariance


## Modifying plots, scatter plots as examples
?par;#all parameters

# cex to change font sizes
plot(Age, Height, las = 1, 
     cex = 0.5, # size of dots
     main='Example',
     cex.main=2, # size of title
     xlab = 'Age', ylab = 'Height',
     cex.lab = 1.5, cex.axis=0.5, # size of labels and axis
     );

# font to change font sizes
plot(Age, Height, las = 1, 
     main='Example',
     font.main = 4, # leaning
     xlab = 'Age', ylab = 'Height',
     font.lab = 2, # bold
     font.axis = 3, # thin
);

# col to change font sizes
plot(Age, Height, las = 1, 
     col = 'grey',
     main='Example',
     col.main = 'blue', 
     xlab = 'Age', ylab = 'Height',
     col.lab = 'red', 
     col.axis = 'green',
);

# pch for dot types
plot(Age, Height, las = 1, 
     pch = 2, # numbers for different types
     # pch = 'o', # use different characters
     main='Example',
     xlab = 'Age', ylab = 'Height',
);

# adding a line
abline(lm(Height~Age),
       col = 'red',
       lty = 2,
       lwd = 6,
       ); # lm(y~X). 

## adding points to existing plots
# example: plot male and female height v.s. age
plot(Age[Gender == 'male'], Height[Gender == 'male'],
     pch = 'M', col = 'blue', cex = 0.5,
     main = 'Height vs. Age, gender specified',
     xlab = 'Age', ylab = 'Height', las = 1,
     );
points(Age[Gender == 'female'], Height[Gender == 'female'],
       pch = 'F', col = 'pink', cex = 0.5,
       )

# subplots structures using par()
par(mfrow = c(1,2)); # c(1,2) for 1 by 2(1 row, 2 columns)

plot(Age[Gender == 'male'], Height[Gender == 'male'],
pch = 'M', col = 'blue', cex = 0.5,
main = 'Height vs. Age, male',
xlab = 'Age', ylab = 'Height', las = 1,
);
plot(Age[Gender == 'female'], Height[Gender == 'female'],
     pch = 'f', col = 'red', cex = 0.5,
     main = 'Height vs. Age, female',
     xlab = 'Age', ylab = 'Height', las = 1,
);

par(mfrow = c(1,1)); # change the arrangement back

# adding ticks and labels
plot(Age, Height, axe=F);

  axis(side = 1, #x-axis
       at = c(min(Age),mean(Age),max(Age)),
       labels = c('min','mean','max'),
  );
  axis(side = 2, #x-axis
           at = c(min(Height),mean(Height),max(Height)),
           labels = c('min','mean','max'),
  );
  axis(side = 4, #x-axis
       at = c(min(Height),mean(Height),max(Height)),
       labels = c('min','mean','max'),
  );
  box();


## adding text and comments using 
#    text(in the body) and mtext(outside the margin)
?text;
cor(Age,LungCap);
plot(Age, LungCap, las =1,
     main = 'LungCap v.s. Age');
  text(x=5,y=12,#position of the text
       label = 'r = 0.82',
       adj = 0, #0==starting from position, 1==end at position
       cex = 0.5,
       col = 'red',
       font = 4
       )
  abline(h=mean(LungCap), # a horizontal line
         col = 'red', lwd = 3,
         );
    text(x= 4, y = 9,
         label = 'mean capacity',
         cex=0.5,
         col = 'red',
         );

?mtext;
plot(Age, LungCap, las =1,
      main = 'LungCap v.s. Age');
  mtext(side = 3, #on the top side
        adj = 0.25, #between 0~1, left~right
        text = 'r = 0.82',
        );
  

# legends
?legend
plot(Age[Smoke=='no'],LungCap[Smoke=='no'],
     pch = 16, col = 'green');
points(Age[Smoke=='yes'],LungCap[Smoke=='yes'], 
       pch=17, col = 'red', cex=0.5);
legend(x=3, y=13, # position of lefttop cornor of legend
       legend = c('non-smoker', 'smoker'),
       fill = c('green','red'),
       )

plot(Age[Smoke=='no'],LungCap[Smoke=='no'],
     pch = 16, col = 'green');
points(Age[Smoke=='yes'],LungCap[Smoke=='yes'], 
       pch=17, col = 'red');
legend(x=3, y=13, # position of lefttop cornor of legend
       legend = c('non-smoker', 'smoker'),
       col = c('green','red'),
       pch = c(16,17),
       bty = 'n', # box type = no box
)
