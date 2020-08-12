# Hypothesis testing
# importing data
LungCapData = read.csv(file='Z:/Engaging/R_learning/LungCapData.txt', 
                       sep = '\t', header = TRUE);
setwd('Z:/Engaging/R_learning/Project 1 working directory');

attach(LungCapData);


# one sample t test
# good for examine a single numeric variable
?t.test;

boxplot(LungCap); # have a plot before testing
mean(LungCap);

# H_0: mu < 8 vs. H_1: mu >=8, for 95% confidence 
# one-sided interval

t.test(LungCap, mu=8, alternative = 'less', conf.level = 0.95);

# H_0: mu = 8 vs. H_1: mu >=8, for 95% confidence 
# 2-sided interval
t.test(LungCap, mu=8, alternative = 'two.sided', conf.level = 0.95);

text_2 <-t.test(LungCap, mu=8, alternative = 'two.sided', conf.level = 0.99);

text_2$stderr;


# 2 sample t test
# good for examine 2 numeric variable
# and regression 
?t.test;

# H_0: mean of LungCap of Smoke = mean of LungCap of non-Smoke
# H_0: m(LungCap,yes)=m(LungCap,no), 2 sided
# assume non-equal variance
# mu=m(LungCap,yes)-m(LungCap,no)

t.test(LungCap~Smoke, 
       mu=0, alt='two.sided', conf=0.95, var.eq=F, paired=F)

#same as
t.test(LungCap[Smoke=='yes'],LungCap[Smoke=='no'], 
       mu=0, alt='two.sided', conf=0.95, var.eq=F, paired=F)

# how to determine equal variance?
var(LungCap[Smoke=='yes'])-var(LungCap[Smoke=='no'])==0;

# Levene's test: 
# H_0: population variances are equal
library(car);
leveneTest(LungCap~Smoke);
leveneTest(LungCap~Gender);


# Mann Whitney U/Wilcoxon Rank test
# good for numerical Y and categotical X variables
?wilcox.test;

# H_0: median of lungcap of smokers = median of non-smokers
# 2 sided test
wilcox.test(LungCap~Smoke, mu=0, alt='two.sided',
            conf.int=T, conf.level=0.95, paired= F, exact=F,
            correct=T);



# Paired t-test
# good for 2 populations that are paired.
# e.g. blood pressure for before and after.
BloodPressureData = read.csv(file='Z:/Engaging/R_learning/BloodPressure.txt', 
                       sep = '\t', header = TRUE);
attach(BloodPressureData);
?t.test;
# step 0: visualize
names(BloodPressureData);
boxplot(Before, After);
# or use scatter plot with a y=x line as seperation
plot(Before, After);
abline(a=0,b=1);

# H_0: Before-After=0;
t.test(Before, After, mu=0, alt='two.sided', 
       paired=T, conf.level = 0.95);
# if switch order of variable, all outputs t and intervals will be negative


## Wilcoxon signed rank test
# good on paired, non-parametric

?wilcox.test;

# H_0: median change is 0
# 2 sided test
wilcox.test(Before, After, mu=0, alt='two.sided', 
            paired=T, conf.int = T, conf.level = 0.95, exact=F);


# Chi-square test of independence
# good for 2 categorical 
?chisq.test;

# LungCap between Gender and is_Smoke;
# step 1: contingency table
tab = table(Gender, Smoke);

# visualization
barplot(tab, beside = T, legend=T);

chisq.test(tab, correct=T);


# Fisher's exact test: a non-parametric equavalence
?fisher.test;
fisher.test(tab, conf.int = T, conf.level = 0.95);


# Odd Ratio: in medical statistics
# odd=ad/bc= [P(D|E)/P(D|E^c)] / [P(D^c|E)/P(D^c|E^c)]
# measure how strong 2 categorical variables relate to each other

library(epiR);
epi.2by2(tab, method = 'cohort.count', conf.level = 0.95);



