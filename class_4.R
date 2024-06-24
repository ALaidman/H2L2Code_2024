#CLASS FOUR 

#first, let's look at our data set - we are using Penguins 
#so, let's load our library

library(palmerpenguins)

#now, let's look at a little bit of our data - our data head
head(penguins)

#now, let's load tidyverse

library(tidyverse)

#okay, with that out of the way we are ready to get started 

#let's rename the datafile
happyfeet <- penguins
head(happyfeet)
#fct, dbl, int are datatype
#hit the drop down button on the happyfeet the the upper right box you can see
#the variables in the data set for reference 

#let's start with a continous vs continous plot ----

#let's look at flipper length vs body mass 
head(happyfeet$flipper_length_mm)
class(happyfeet$flipper_length_mm)
head(happyfeet$body_mass_g)
class(happyfeet$body_mass_g)

#two ways to do this
#explicit
ggplot(data = happyfeet, mapping = aes(x = body_mass_g, y = flipper_length_mm))+
  geom_point()
#implicit (i like this one more)
ggplot(happyfeet, aes(x = body_mass_g, y = flipper_length_mm))+
  geom_point()

#let's color add to it
#implicit
ggplot(happyfeet, aes(x = body_mass_g, y = flipper_length_mm, color =  species))+
  geom_point()
#explicit (i like this one more)
ggplot(happyfeet, aes(x = body_mass_g, y = flipper_length_mm))+
  geom_point(aes(color=island))

#now let's talk about global vs local variable assignment 
#the global assingment is on the top line
#the local assingment is on the botto line

#local overides global
ggplot(happyfeet, aes(x = body_mass_g, y = flipper_length_mm, color=species))+
  geom_point(aes(color=flipper_length_mm))

#what happens with year?
#if you write it like this, year is going to be treated like a sliding scale
ggplot(happyfeet, aes(x = body_mass_g, y = flipper_length_mm, color = year))+
  geom_point()

#we need to change year to a factor, so it gets treated year like a bucket (there
#are 3 different years, years are not a sliding scale)
ggplot(happyfeet, aes(x = body_mass_g, y = flipper_length_mm, color = as.factor(year)))+
  geom_point()

#challenge! let's try to recreate a plot shown on the screen ----
ggplot(happyfeet, aes(x = flipper_length_mm, y = body_mass_g, 
                      color = (species),
                      shape = (species)))+
  geom_point()+
  labs(x = "Flipper Length (cm)",
       y = "Body mass (kg)",
       title = "Penguin Size, Palmer Station LTER",
       subtitle = "Flipper length and body mass for Adelie, Chinstrap, and Gentoo Penguins")

#Okay, this is all things we covered last class, but we added shapes
#now let's talk about scaling - this is how you make specifications
  #its either a discreet varaible (aka a factor), continous (aka numeric),
  #or manual (she doesn't know how this works)
?scale_color_manual
  
  ggplot(happyfeet, aes(x = flipper_length_mm, y = body_mass_g, 
                        color = (species),
                        shape = (species)))+
  geom_point()+
  labs(x = "Flipper Length (cm)",
       y = "Body mass (kg)",
       title = "Penguin Size, Palmer Station LTER",
       subtitle = "Flipper length and body mass for Adelie, Chinstrap, and Gentoo Penguins")+
  scale_color_manual(values = c("purple", "green", "orange"))
  
#note, the values function assigns color in alphabetical order of the species
  #but if we want to assing the colors to specific species, we do it like this"
  
ggplot(happyfeet, aes(x = flipper_length_mm, y = body_mass_g, 
                        color = (species),
                        shape = (species)))+
    geom_point()+
    labs(x = "Flipper Length (cm)",
         y = "Body mass (kg)",
         title = "Penguin Size, Palmer Station LTER",
         subtitle = "Flipper length and body mass for Adelie, Chinstrap, and Gentoo Penguins")+
    scale_color_manual(values = c("purple", "green", "orange"))+
    theme(legend.position = c(0.9, 0.1))

#theme, the first is how far left and right 
#theme, the second is how far top and bottom
#the scale goes from 0 to 1
#or you can use words but then you have less specificity 



#Okay, let's do some box plots ----

ggplot(happyfeet, aes(x = species, y = body_mass_g, color=species))+
  geom_boxplot()+
  geom_jitter()+
  labs(x = "Species",
       y = "Body Mass (kg)",
       Title = "Penguin Size, Palmer Station LTER")

#tidy it up 

ggplot(happyfeet, aes(x = species, y = body_mass_g, color=species))+
  geom_boxplot(width = 0.3)+
  geom_jitter(alpha = 0.5,
              position = position_jitter(width = 0.2))+
  theme(legend.position = "none")+
  labs(x = "Species",
       y = "Body Mass (kg)",
       Title = "Penguin Size, Palmer Station LTER")

#so the alpha makes the dots more transparent I think??? I don't know - ask 
#chatGPT later 


#Okay, lets do cts vs var (Histogram) ----

ggplot(happyfeet, aes(x = flipper_length_mm, fill=species))+
  geom_histogram(binwidth=2, alpha=0.5, position = "identity")+
  labs (x = "flipper length",
        y = "Frequency",
        Title = "Penguin Flipper Lengths")+
  scale_fill_manual(values = c("orange", "purple", "green"))

#a few notes about the histogram
#for color, we need to use "fill" and not "color" or it will just outline them 
#for making the graph more transparent, use alpha 
#to see the histogram overlap, use position = "identity" 
#to adjust the width of the bars, use binwdith


#Okay, let's talk about faceting ---- 

#you have a plot and you want to split it into 2 plots based on a varible 

ggplot(happyfeet, aes(x = bill_depth_mm, y = body_mass_g, color = species))+
  geom_point()

#but what about the 3 different islands
ggplot(happyfeet, aes(x = bill_depth_mm, y = body_mass_g, color = species))+
  geom_point()+
  facet_grid(year ~ island)

#you can also only add one variable:  
# facet_grid(~ col) < this will work 
# facet_grid(row ~) < this will NOT work 
# facet_grid(row ~ .) < this will work

#just as a note: a good website is colorbrewer2 
# https://colorbrewer2.org/#type=sequential&scheme=BuGn&n=3

#fff7bc
#fec44f
#d95f0e
  
ggplot(happyfeet, aes(x = flipper_length_mm, fill=species))+
  geom_histogram(binwidth=2, alpha=0.5, position = "identity")+
  labs (x = "flipper length",
        y = "Frequency",
        Title = "Penguin Flipper Lengths")+
  scale_fill_manual(values = c("orange", "purple", "green"))
  
ggplot(happyfeet, aes(x = flipper_length_mm, fill=species))+
  geom_histogram(binwidth=2, alpha=0.5, position = "identity")+
  labs (x = "flipper length",
        y = "Frequency",
        Title = "Penguin Flipper Lengths")+
  scale_fill_manual(values = c("#fff7bc", "#fec44f", "#d95f0e"))















