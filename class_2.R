# A review from last class - things we didn't cover
#double brackets unravel the list
#single brackets return the single vector inside the list?
# a data frame is just a list - 5 columns are 5 lists
iris[["Species"]]

## Functions ---- ASK GABI
## how do we create a funciton?
# variable > function constructor > formal named argument > special "dots" argument
add10 <- function(num, ...) {
    #function body
    result <- num + 10
    dots <- list(...)
    cat("there were", length(dots),
        "unused arguments.\n")
    result
}

##Some notes: 
## the last value evaluated expression will be returned from the function

add10(num = 1)

## functions can be defined with no arguments

## when calling funcitons, providing argument names is optional
## If not provided, arguments are passed iin order of the formals 

# Notes on de-bugging 
browser() #allows you to step through the code line by line and the focus
#becomes the body of the function 

# CLASS TWO -------------
#Your data sets: mtcars, palmer penguins, 
# this code is making sure that the correct files are installed during the project rendering
# Students, don't worry too much about this code. It is here to make sure that our curriculum
# book runs correcrtly, but if you are curious, feel free to ask teachers for more info. 
if(!require("palmerpenguins")){
  install.packages("palmerpenguins",repos = 'http://cran.us.r-project.org')
}

install.packages("palmerpenguins")

library(palmerpenguins)

data(package = "palmerpenguins")

data("penguins", package = "palmerpenguins")
#package is a box of useful stuff that is related to eachother, contains data
#sets and sometimes will have functions
#the namespace is everything in the package that you can see (pathfiles, raw 
#data, etc.) by saying the package:: you can pull up the namespace
palmerpenguins::penguins

#now that we have access to the data set, we can MANIPULATE THE DATAFRAME 

#let's first use the cars dataset 

#Q1: how do we print out the first 5, 10, 20 rows of the mtcars data set?
#use what we learned last class about how to look at specific rows and columns 
#of data set

head(mtcars)

mtcars[1:10,]

mtcars[1:20,]

head(x = mtcars, n = 5)

#Q2: lets assign mtcars to a new variable name, this makes a copy of the data so 
#when im messing around with it, it is different from the original copy

mcqueen <- mtcars

#Q3: what is the data type of each column in the data set?

typeof(mcqueen$mpg)
typeof(mcqueen$gear)
#OR
class(mcqueen$mpg)
class(mcqueen$drat)
#OR
for (column in mcqueen) {
  print(class(column))
}
#define a for loop "for" then define the first variable (column) inside the second
#variable we already have (mcqueen) and then saying what you want it to do:
#(print(the class(of each column))) of course the "column" is simply what we 
#defined the X to be in the for loop - it can be written generically like this:
for (X in dataset) {
  print(class(X))
}

#most of the data is in doubles, which is basically the same as an interger,
#but allows for values between 0 and 1, etc. ie decimal places


#Q4: how many rows are in the dataset? how many columns?

nrow(mcqueen)
ncol(mcqueen)
#there are 32 rows and 11 columns 

#Q5: Run str(mtcars). What is this output telling you?

str(mcqueen)
#this tells you the number of observations (32) and variables (11)

#Q6 for each column, find the mean, range, and median values 

mean(mcqueen$mpg)
range(mcqueen$mpg)
median(mcqueen$mpg)
#the mean is 20.1, the range is 10.4, the median 19.2)

#okay, now lets try to make a for loop so we dont have to do this for each column 
for (column in mcqueen) {
  mean_value <-mean(column)
  range_value <- range(column)
  median_value <- median(column)
  cat("mean:", mean_value, "range:", range_value, "median", median_value, "\n")
}

#Q7: what is the value in the 6th row and the 10th column?
mcqueen[6, 10]
#rember its roman-catholic - it goes row and then column 

#Q8: print every row of the 4th column, or print out the fourth column 
mcqueen[,4]

#Q9: print rows 28 to 31
mcqueen[28:31,]

#TRY DATA SET 2: PENGUINS FOR HOMEWORK

#OKAY, NOW LETS DEBUG THE WEIRD BARBIE CODE
# The data -- DO NOT EDIT 
ken_data <- data.frame(
  "ken_name" = c("Ken1", "Ken2", "Ken3", "Ken4", "Ken5", "Ken6", "Ken7", "Allan"),
  "hair_color" = c("Blonde", "Brown", "Black", "Red", "Blonde", "Brown", "Black", "Black"),
  "cowboy_hats_owned" = c(2, 0, 1, 3, 0, 1, 2, 0),
  "favorite_outfit" = c("Casual", "Formal", "Sporty", "Beachwear", "Formal", "Casual", "Sporty", "Casual"),
  "age" = c(25, 27, 26, 28, 29, 30, 26, 27),
  "height_cm" = c(180, 175, 182, 178, 180, 183, 177, 175),
  "weight_kg" = c(75, 70, 80, 77, 76, 78, 79, 70),
  "favorite_hobby" = c("Surfing", "Reading", "Soccer", "Volleyball", "Painting", "Cooking", "Dancing", "Guitar"),
  "favorite_color" = c("Blue", "Green", "Red", "Yellow", "Purple", "Orange", "Pink", "Blue"),
  "shoe_size" = c(10, 9, 11, 10, NA, 11, 10, 9),
  "best_friend" = c("Barbie", "Barbie", "Barbie", "Barbie", "Barbie", "Barbie", "Barbie", NA),
  "is_ken" = c(TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, FALSE)
)

#our goal is to go through the code below and improve it by adding comments 
# or variable names 

ken_data

str(ken_data)

head(ken_data)

mean(ken_data$cowboy_hats_owned)

hist(ken_data$cowboy_hats_owned)
ken_data$more.than.1_cowboyHat <- ken_data$cowboy_hats_owned > 1

print(paste(sum(ken_data$more.than.1_cowboyHat), "Kens have more than 1 cowboy hat"))
#this line does not return correct information, it says "0 Kens have more than
# 1 cowboy hat, so we need to try to fix it 

print(paste(sum(ken_data$cowboy_hats_owned), "Kens have more than 1 cowboy hat"))
#yay I fixed it

#okay, lets continue testing the code 

range(ken$age)
#this returns "error: object 'ken' not found"

range(ken_data$age)
#yay I fixed it 

#okay, lets keep going 

range(ken_data$shoe_size)
#this returns "NA, NA" so we need to remove the NA datapoint

range(na.omit(ken_data$shoe_size))
#yay I fixed it 

#okay, lets keep going 

correlation <- cor(ken_data$height_cm, ken_data$weight_kg)
print(paste("The correlation between height and weight is", correlation))
plot(ken_data$height_cm, ken_data$weight_kg)
#these axis are very ugly, let's fix the axis labels on the graph

correlation <- cor(ken_data$height_cm, ken_data$weight_kg)
print(paste("The correlation between height and weight is", correlation))
height_cm <- ken_data$height_cm
weight_kg <- ken_data$weight_kg
plot(height_cm, weight_kg)
#yay, the names are not ugly anymore 

#okay, lets keep going

table(ken_data$best_friend)
# looks like everyone's bff is barbie!

# outfits
table(ken_data$favorte_outfit)
#this doesnt result in anything ... because there is a typo, let's fix it

table(ken_data$favorite_outfit)
#yay, I fixed it 

#okay, let's keep going 

# no allan
range(ken_data[1:7,5])
#this is a bad label, I would call it- 

#age range excluding allan 
range(ken_data[1:7,5])

#okay, let's keep going 

noAllan <- ken_data[1:7,]
also_noAllan <- noAllan <- ken_data[ken_data$is_ken == TRUE,]
#why do we need this line ^ of code??

range(noAllan$shoe_size)

#let's exclude the NA again 
range(na.omit(noAllan$shoe_size))
#yay, I fixed it 

#okay, let's keep going 


# Are the sporty Kens taller than the other Kens?
sporty_kens <- mean( ken_data [ken_data$favorite_outfit == "Sporty", "height_cm"])
other_kens <- mean(ken_data[ken_data$favorite_outfit != "Sporty", "height_cm"] )
sporty_kens
other_kens
#yes, sporty_kens are taller than other_kens 1 cm on average

#OKAY, HERE IS A SUMMARY OF WEIRD BARBIE'S CODE AND MY EDITS TO HER CODE
##WEIRD BARBIE'S OG CODE 

str(ken_data)
haed(ken_data)

mean(ken_data$cowboy_hats_owned)
hist(ken_data$cowboy_hats_owned)
ken_data$more.than.1_cowboyHat <- ken_data$cowboy_hats_owned > 1
print(paste(sum(ken_data$more.than.1_cowboyHat), "Kens have more than 1 cowboy hat"))

range(ken$age)
range(ken_data$shoe_size)


correlation <- cor(ken_data$height_cm, ken_data$weight_kg)
print(paste("The correlation between height and weight is", correlation))
plot(ken_data$height_cm, ken_data$weight_kg)

table(ken_data$best_friend)
# looks like everyone's bff is barbie!

# outfits
table(ken_data$favorte_outfit)


# no allan
range(ken_data[1:7,5])

noAllan <- ken_data[1:7,]
also_noAllan <- noAllan <- ken_data[ken_data$is_ken == TRUE,]
range(noAllan$shoe_size)

# Are the sporty Kens taller than the other Kens?
sporty_kens <- mean( ken_data [ken_data$favorite_outfit == "Sporty", "height_cm"])
other_kens_mean <- mean(ken_data[ken_data$favorite_outfit != "Sporty", "height_cm"] )

sporty_kens > other_kens_mean

##WEIRD BARBIE'S CODE WITH MY EDITS

ken_data

str(ken_data)

head(ken_data)

#let's talk about cowboy hats
mean(ken_data$cowboy_hats_owned)
hist(ken_data$cowboy_hats_owned)
ken_data$more.than.1_cowboyHat <- ken_data$cowboy_hats_owned > 1
print(paste(sum(ken_data$cowboy_hats_owned), "Kens have more than 1 cowboy hat"))

#what is the range of ages
range(ken_data$age)

#what is the range of shoe sizes
range(na.omit(ken_data$shoe_size))

#graph of the correlation of height vs weight
correlation <- cor(ken_data$height_cm, ken_data$weight_kg)
print(paste("The correlation between height and weight is", correlation))
height_cm <- ken_data$height_cm
weight_kg <- ken_data$weight_kg
plot(height_cm, weight_kg)

#who is everyone's best friend?
table(ken_data$best_friend)

# outfits
table(ken_data$favorite_outfit)

#age range excluding allan 
range(ken_data[1:7,5])

#shoe size excluding allan
noAllan <- ken_data[1:7,]
also_noAllan <- noAllan <- ken_data[ken_data$is_ken == TRUE,]
range(noAllan$shoe_size)
range(na.omit(noAllan$shoe_size))

# Are the sporty Kens taller than the other Kens?
sporty_kens <- mean( ken_data [ken_data$favorite_outfit == "Sporty", "height_cm"])
other_kens <- mean(ken_data[ken_data$favorite_outfit != "Sporty", "height_cm"] )
sporty_kens
other_kens
#yes, sporty_kens are taller than other_kens 1 cm on average





