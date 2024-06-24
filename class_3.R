#Class three - Let's get plotting! 

#reading in datasets
## read.table 
### file = path of the file, header = false/true (flase = treat first row as data
# true = treat first row as header), sep = ""./ this is how the data is seperated
# sep = "\t" means tab 
# stringsAsFactors=TRUE is converting characters in codes to numbers to save space

## read.csv() 
### is a csv file 

#first let's download our dataset for today
#We started by going to ondemand > then chose files > /work/users/... > then made
# a new directory "H2L2C" > then  uploaded the data set to the folder > then 
# copied the file path (upper left corner)

library(readr)
variants <- read.table("/work/users/a/l/alaidman/H2L2C/variants_from_assembly.bed",
                       quote='', stringsAsFactors=TRUE, header=FALSE, sep = "\t")

names(variants) <- c("chrom","start","stop","name","size","strand","type","ref.dist","query.dist")

#3 main types of variable relationships - look at slides for notes 

#2 main ways to plot in R
##using base R functions plot()
##using tidyverse ggplot()
###baseR can be harder/clunky to read, but good to use if you want to avoid dependencies
###tidyverse is good at cleaning up code, makes it easier to understand 

#Let's start by looking at Numeric vs Numeric with BaseR

#SCATTER PLOT 

plot(x = variants$ref.dist, y = variants$query.dist)

#okay, now add axis labels! 
plot(x = variants$ref.dist, y = variants$query.dist, 
     xlab = "Reference Distance", ylab = "Query Distance")

#okay, now let's add a title
plot(x = variants$ref.dist, y = variants$query.dist, 
     xlab = "Reference Distance", ylab = "Query Distance",
     main="Correlation between Reference and Query Distance")

#we can also add a subtitle
plot(x = variants$ref.dist, y = variants$query.dist, 
     xlab = "Reference Distance", ylab = "Query Distance",
     main="Correlation between Reference and Query Distance",
     sub = "yay a subtitle")

#we can also change the colors 
plot(x = variants$ref.dist, y = variants$query.dist, 
     xlab = "Reference Distance", ylab = "Query Distance",
     main="Correlation between Reference and Query Distance",
     col.main="red",
     sub = "yay a subtitle",
     col.sub="blue")

#we can alos adjust the positioning of the subtitle relative to the title 
plot(x = variants$ref.dist, y = variants$query.dist)
my_title="Title"
sub_title="subtitle"
mtext(slide = 3, line = 2, adj = 0.3, font = 2, cex = 1)
#this threw an error, i don't know why 

#LINE PLOT
     
plot(x = variants$ref.dist, y = variants$query.dist, 
     xlab = "Reference Distance", ylab = "Query Distance")
lines(x = variants$ref.dist, y = variants$query.dist)

#let's make this look better by drawing just one line through the data
#so we need to sort the x and y vectors 

x_sorted <- sort(variants$ref.dist)
y_sorted <- sort(variants$query.dist)

#okay, let's bring it together

plot(x = variants$ref.dist, y = variants$query.dist, 
     xlab = "Reference Distance", ylab = "Query Distance")
lines(x = x_sorted, y = y_sorted, col="blue")


#GGPLOT - LET'S DO THE SAME THING BUT WITH TIDYVERSE

#ggplot
# data = your data
# mapping = what you want to plot, what you're looking at 
# use + sign to add components

#first, we need to load the library for ggplot
library(ggplot2)

#SCATTER PLOT
ggplot(variants)

#this is not enough information, we need to add aestetics component to say what
#we're looking at
ggplot(variants, aes(x=ref.dist, y=query.dist))

#okay, now let's make a scatter plot
ggplot(variants, aes(x=ref.dist, y=query.dist))+
  geom_point()

#let's add labels 
ggplot(variants, aes(x=ref.dist, y=query.dist))+
  geom_point()+
  labs(x = "Reference Distance", 
       y = "Query Distance", 
       title = "Title", 
       subtitle = "subtitle")

#LINE PLOT
ggplot(variants, aes(x=ref.dist, y=query.dist))+
  geom_point()+
  geom_line()+
  labs(x = "Reference Distance", 
       y = "Query Distance", 
       title = "Title", 
       subtitle = "subtitle")

#if we wanted to plot a smooth line
ggplot(variants, aes(x=ref.dist, y=query.dist))+
  geom_smooth()+
  labs(x = "Reference Distance", 
       y = "Query Distance", 
       title = "Title", 
       subtitle = "subtitle")

#if we wanted to get rid of the grid/ change the theme
ggplot(variants, aes(x=ref.dist, y=query.dist))+
  geom_smooth()+
  theme_minimal()+
  labs(x = "Reference Distance", 
       y = "Query Distance", 
       title = "Title", 
       subtitle = "subtitle")
#there's a whole bumch of themes, you can same theme_ and then look through them 

#NUMERIC DISTRIBUTIONS

#we can use histograms, density plots, voxplots, violin plots, bar plots 

#BASE R
#let's first make a histogram
hist(variants$size)

#now let's make a density plot
plot(density(variants$size))

#okay, what about a box plot 
boxplot(variants$size)

#alright, now let's make a bar plot 
barplot(table(variants$size))

#okay, let's add labels to any of these
hist(variants$size,
     xlab="size",
     ylab="frequency",
     main="Title")

#USING GGPLOT

#we can make histograms, density plot, bar plot, violin plot, boxplot

#let's make a histogram 
ggplot(variants, aes(x=size))+
  geom_histogram()

#density plot
ggplot(variants, aes(x=size))+
  geom_density()

#box plot
ggplot(variants, aes(x=size))+
  geom_boxplot()

#violin plot - ONLY IN GGPLOT
ggplot(variants, aes(x=size))+
  geom_violin(aes(y=1))
#we need to say y=1 so that we only make one violin plot for the vector,
#if we don't tell it the y value it won't plot anything because it's used to
#plotting multiple violin plots 

#bar plot
ggplot(variants, aes(x=size))+
  geom_bar()

#let's add lables
ggplot(variants, aes(x=size)) +
  geom_histogram() +
  labs(title="Title",
       x = "size", 
       y = "frequency")

#CONTINOUS VS CATEGORICAL

#BASE R can make bar plot, box plot

#box plot size by type 
boxplot(cont_var ~ cat_var)
boxplot(variants$size ~ variants$type)
#need to write continous variable first, then category variable 


#barplot to show counts of each type
#first we need to narrow the data we're intested in, then feed that into the plot function
#subsett all the rows to only the column type 
smallData <- variants[,"type"]
variantsCounts <- table(smallData)

View(variantsCounts)
#okay, now we can see the smaller data set

barplot(height=variantsCounts, names=names(variantsCounts))
#now we have a nice plot
#this is an example of baseR being cluncky 



#GGPLOT can make bar plot, box plots, violin plots 

#boxplot
ggplot(variants, aes(x=type, y=size)) +
  geom_boxplot()

#barplot
ggplot(variants, aes(x=type, y=size)) +
  geom_bar(stat="summary", fun="mean")

#fun means the height of the bar is the average
#stat means the summary statistics and you use this because ???? 
#if you use stat="count" then you would get rid of either your x or y variable 




