print("hello world!")

# Calculating the mean of 'Sepal.Width' wihting iris
mean(iris$Sepal.Width) # 3.05

mean_value <- mean(iris$Sepal.Width)
mean_v = mean(iris$Sepal.Length)
mean(iris$Petal.Length) -> mean_value_petal.length

GrEeTiNg <- "hello"
#cannot start variable name with a number
5greeting <- "hello"
greeting.5 <- "hello"
#cannot have symbols in variables that are used in the coding language
greeting@5 <- "hello" 
greeting_05 <- "hello"
geet.ing <- "hello"

two ways to make notes that are easier for people to read
#camel case
HelloWorld
# snake case
hello_world

#naming variables
iris_copy <- iris

#dataframes
#each column is a vector of the same size (150 overvations) 

#character
typeof("hello")
#double
typeof(c(1, 2, 3))
#integer
typeof(c(1L, 2L, 3L))
#logical /  boolean
typeof(c(TRUE, FALSE))

## object classes
# character
class("hello")
# numeric
class(c(1, 2, 3))
# integer
class(c(1L, 2L, 3L))
# logical
class(c(TRUE, FALSE))

#class and type are different things

my_numbers <- c("4", "2", "7", "10")
print(my_numbers)

my_numbers <- as.numeric(my_numbers)

# Unexpected merging

# character & number -> character
class(c("4", "2", "7", "10", 2))
# character & logical -> character
class(c("4", "2", "7", "10", TRUE))
# numeric & logical -> numeric
c(4, 2, TRUE, FALSE)

# ((logical & numeric) -> numeric, "character") -> character 
c("hello",c(TRUE, FALSE, 4, 2))



# back to the example - what are some questions you can ask about your data
my_numbers <- (c("4", "2", "7", "10"))
my_numbers <- as.numeric(my_numbers)

min(my_numbers)

max(my_numbers)

mean(my_numbers)

# sorting and ordering your data
my_numbers <- sort(my_numbers)
my_numbers_sorted <- sort(my_numbers) 
order(my_numbers)

#accessing parts of a list
my_data <- c("A", "B", "C", "D", "E", "F")
my_data

#looking at just some of the variables with bracket notation
#just E
my_data[5]
#just AandE, can pass multiple indexes
my_data[c(1,5)]
#just EandA, multiple indexes in different orders
my_data[c(5,1)]
#a range of data
my_data[c(1:3, 5, 6)]
#everything expect a singular data point
my_data[-4]
#all of my data points, returning everything
my_data[]

# data frames
# data frames are sets of vectors (above we worked with vectors)
# each vectos must be the same length
# each column does not need to be the same data type

#accessing just one column, ex. comlumn 2
iris[2]
#accessing all the columns
iris[c(1,5)]

#accessing a subset on rows [row,comlumn]memory key [roman,catholic]
iris[,]
#the first 10 rows of all the columns
iris[1:10,]
#the a selection of rows of some fo the columsn
iris[c(1, 5, 10), c(1, 5)]
#first row of each spececis (50 per species)
iris[c(1, 51, 101),]

#all rows, specific columns
iris[, c(1,5)]
iris[,5]

#what if you include a class function?
#GOTCHA moment this is not the same as what is above - pay attention to syntax

# multiple colmns returns dataframe
class(iris[, c(1,5)])

# index of lenth 1 returns a vector!!
class(iris[, 5])


#how to ask for help
?mean
?iris



