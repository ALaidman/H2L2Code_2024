#Class 4 Homework 

#First, load the libraries we want
library(palmerpenguins)
library(tidyverse)

#and let's make a working copy of the data 
happyfeet <- penguins

head(happyfeet)

ggplot(happyfeet, aes(x=flipper_length_mm, y=body_mass_g, color=species,
                      shape=species))+
  geom_point()+
  labs(x = "Flipper Length (mm)",
       y = "Body Mass (g)",
       title = "Penguin Size, Palmer Station LTER",
       subtitle = "Flipper length and body mass for Adelie, Chinstrap, Gentoo")+
  facet_grid(~ island)


ggplot(happyfeet, aes(x=flipper_length_mm, fill=species))+
  geom_histogram(alpha=0.5, position = "identity", binwidth=5)+
  labs(x = "Flipper Length (mm)",
       y = "Frequency",
       title = "Penguin Flipper Lengths")+
  facet_grid(year ~ .)+
  scale_fill_manual(values = c("#fff7bc", "#fec44f", "#d95f0e"))


