#Class 5 - Data Wrangling Basics 

#Data Wrangling: manipulating your data so it's in a format that is easier
#to work with

#Let's start with a very basic example
names <- c("rosalind", "marie", "barbara")

#let's call the output
names

#now, we can call the specific data, this is the same idea as roman, catholic 
#we can call specific positions 
names[1]
names[3]

#we can index more than one position at a time 
names[c(1,2)]
names[c(2,1)]



#Let's move on to working with Dataframes ----
# Make a data frame
df <- data.frame(
  name = c("Rosalind Franklin", "Marie Curie", "Barbara McClintock", "Ada Lovelace", "Dorothy Hodgkin", 
           "Lise Meitner", "Grace Hopper", "Chien-Shiung Wu", "Gerty Cori", "Katherine Johnson"),
  field = c("DNA X-ray crystallography", "Radioactivity", "Genetics", "Computer Programming", "X-ray Crystallography", 
            "Nuclear Physics", "Computer Programming", "Experimental Physics", "Biochemistry", "Orbital Mechanics"),
  school = c("Cambridge", "Sorbonne", "Cornell", "University of London", "Oxford", 
             "University of Berlin", "Yale", "Princeton", "Washington University", "West Virginia University"),
  date_of_birth = c("1920-07-25", "1867-11-07", "1902-06-16", "1815-12-10", "1910-05-12", 
                    "1878-11-07", "1906-12-09", "1912-05-31", "1896-08-15", "1918-08-26"),
  working_region = c("Western Europe", "Western Europe", "North America", "Western Europe", "Western Europe", "Western Europe", "North America", "North America", "North America",  "North America")
)

#let's view the dataframe so we can visualize the data (remember we are just 
#calling the dataframe "df" for this example)
View(df)

#Let's call the first column
df[,1]

#Let's call the first row
df[1,]

#Let's access a specific cell that says cornell 
df[3,3]

#We can also call specific cells by clomn name
df[3, "school"]

#We can call the column with the dollar sign also
df$school #this basically returns a vector with just the schools list 
df$school[3] #this is now looking at the thrid thing in our "new" vector = the schools

#We can also give a list of columns
df[, c("field", "name")]



#Okay,  now let's talk about standard data formats and Tidy----

#Vocab:
##variables are in the columns
##observations are in rows 
##values are in a single cell 

#Using dplyr
# "::" helps to access a specific function from a specific package - so we need to tell 
#R to look in dplyr for the function glimpse
dplyr::glimpse(df)

#To avoid this, we could just download Tidyverse package 
#install tidyverse (which contains dplyr)
install.packages("tidyverse")
library(tidyverse)

#Structure of dyplyr:
#The first argument is always a data frame
#The following arguments typically specify which columns to operate on, 
  #using the variable names (without quotes)
#The output is always a new data frame

#Let's start by manipulating ROWS----

#let's filter for scientists born after 1900
filtered_data <- filter(df, as.Date(date_of_birth) > as.Date("1900-01-01"))
#first make a new variable (filtered_data), then call the data set, then set the 
#function as date of birth, then say only as more than "1900-01-01" 

#okay, now let's look at the data we just called
view(filtered_data)

#now, let's arrange this data by date of birth 
arranged_data <- arrange(filtered_data, date_of_birth)
view(arranged_data)
#so we made a new variable called arranged data which consists of our filtered
#data and then told it to arrange the orgder by date of birth 

#we can combine these steps if we want:
arranged_data <- arrange(filter(df, as.Date(date_of_birth)> as.Date("1900-01-01")),
                         date_of_birth)
#but this is clunky and UGLY 

#So, let's use PIPES! ----
#the pipe operator is a tool that can help make the script more readable by passing
  #the result of one function into the next fucntion
  #can read it as "and then"
#if you have downloaded the dyplyr package = %>%
#if you are working in base R = |> 

#let's try it 
arranged_data <- df |>
  filter(as.Date(date_of_birth) > as.Date("1900-01-01")) |>
  arrange(date_of_birth)

#this produces the same thing, but written in a more concise way 

#PRACTICE

#filter by those who do not work in North America
df_WesternEurope <- filter(df, working_region != "North America")
view(df_WesternEurope)

#or, if we specifically wanted western europe and there were more than 2 options 
df_WesternEurope <- filter(df, working_region == "Western Europe")
view(df_WesternEurope)

#now, let's do people who did not work in Europe and arrange by name
df_names <- df |> 
  filter(working_region != "Western Europe") |>
  arrange(name)
#let's look at it
view(df_names)

#the arrangne is set like this: arrange(column name)

#DISTINCT 
#Let's look at distinct working regions by using the distict function
distinct_regions <- distinct(df, working_region)
view(distinct_regions)
#so, this tells us what the unique regions are - in this case there are only 
#two options: Western Europe and North America, so that is the output 

#practice: use distinct to find distinct pairings of working_region and school 
?distinct()

distinct_pairings <- df |>
  distinct(working_region, school)
distinct_pairings

#let's manipulate COLUMNS ---- 

#dyplr
## mutate() = creates new columns derived from the existing columns
## select() = changes which columns are present
## rename() = changes the names of the columns
## relocate () = changes the position of the column 

#let's try to add a new column with would-be age
if_they_were_still_alive <- mutate(df, age = as.Date("2024-06-17") - as.Date(date_of_birth))
view(if_they_were_still_alive)

#let's select for just the regions and the school 
region_and_school <- select(df, working_region, school)
view(region_and_school)

#let's rename "name" as "firstname, lastname" 
renamed_name <- rename(df, firstname_lastname = name)
view(renamed_name)
#here, the order matters! you have to put what you want to call it then = then
#the name that's already there 

#let's rearrange the colmn order
#if we want to bring date of birth to the first column
rearranged <- relocate(df, date_of_birth)
view(rearranged)

#what if we wanted to move our date of birth to a specific location in the middle
#of our data
?relocate

rearranged_2 <- relocate(df, date_of_birth, .after=school)
view(rearranged_2)
#this put's the date of birth after the school column 

#let's manipulate GROUPS ----

#dyplr group functions
## group_by() = allows you to create groups using more than one variable
## summarzse() = works on grouped objects and allows you to calculate a single
## summary stastitic, reducing the data fraime to have a single row for each group
## slice() = allows you to extract specific rows within each group

# let's add a new bit of data 
df$prizes <- c(0, 2, 1, 0, 1, 0, 0, 0, 1, 0)
view(df)

#let's use group by to create a group 
df_regions <- group_by(df, working_region)
view(df_regions)

#okay, let's get the average number of nobel prizes won by groups (regions)
df_avgprizes <- df |>
  group_by(working_region) |>
  summarize(nobelavg = mean(prizes), n=n())
view(df_avgprizes)

#we made a new column "nobelavg" and asked what the mean number of nobel prizes
#won in each region, and how many examples from each region we have (n=n())

#CASE STUDY ----
#first, let's load the data:
library(RCurl)

cell_phenotypes <- getURL("https://raw.githubusercontent.com/How-to-Learn-to-Code/Rclass-DataScience/main/data/wrangling-files/cellPhenotypes.csv")
cell_proportions <- getURL("https://raw.githubusercontent.com/How-to-Learn-to-Code/Rclass-DataScience/main/data/wrangling-files/cellProportions.csv")

cell_phenotypes <- read.csv(text=cell_phenotypes, row.names=1)
cell_proportions <- read.csv(text=cell_proportions, row.names=1)
#row.names=1 tell it to take the first row and treat it as a header

options(digits = 3)

head(cell_phenotypes)
view(cell_phenotypes)









