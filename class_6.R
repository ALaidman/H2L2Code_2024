#Class 6 - Data Wrangling Application

#last class we talked about data wragling, now we are going to apply this to 
#some real world data 

#Let's access that data now
#first, let's load the libraries we need

library(RCurl)
library(tidyverse)

#okay, now let's grab the data 

cell_phenotypes <- getURL("https://raw.githubusercontent.com/How-to-Learn-to-Code/Rclass-DataScience/main/data/wrangling-files/cellPhenotypes.csv")
cell_proportions <- getURL("https://raw.githubusercontent.com/How-to-Learn-to-Code/Rclass-DataScience/main/data/wrangling-files/cellProportions.csv")

#let's conver the data to readable information in R
cell_phenotypes <- read.csv(text=cell_phenotypes, row.names=1)
cell_proportions <- read.csv(text=cell_proportions, row.names=1)

#let's look at the data 
view(cell_phenotypes)
view(cell_proportions)

#what is the premiss of this experiment?
## the experiment measured the proportions of different cell types in a mouse heart
## they have a control mouse cohort and a mutant mouse cohort 
## they have fractions = should be pure cell types, this serves as a control to
#know we have the right cell types based on their makeup 
## they have whole samples = test samples, they will have a range of cell types

#Let's get started! What are some questions we could ask about the data?
#first, let's check our expectations that each row for the proportions will equal to 1 

rowSums(cell_proportions)
#yep, everything adds to one 

table(cell_phenotypes$genotype)
table(cell_phenotypes$genotype, useNA = "ifany")

#okay, how are we going to merge these two sets of data? 
#cbind (combines columns) and rbind (combines rows) will blindly merge your data
#merge is a bit more smart about it 

#but both data sets don't have the same row order (eventhough they have the same 
#number of rows), so first, let's structure our data so all the rows are in same 
#order 

cell_proportions_reordered <- cell_proportions[rownames(cell_phenotypes),]
view(cell_proportions_reordered)

#okay, now let's make sure the both data sets have the same number of rows 
#this helps us be more confident that we can combine the data
nrow(cell_proportions_reordered)
nrow(cell_phenotypes)
nrow(cell_phenotypes) == nrow(cell_proportions_reordered)

#okay, let's merge the sets ----
data_bind <- cbind(cell_phenotypes, cell_proportions_reordered)
view(data_bind)

#alternatively, we can use the function merge which is a bit smarter and we can 
#merge based on names 
data_merge <- merge.data.frame(cell_phenotypes, 
                               cell_proportions_reordered, 
                               by= "row.names")
view(data_merge)
str(data_merge)
#now this looks messed up because the computer thinks 1 and then 10 and then 11
#is in order. while we wanted 1,2,3. this is why leading zeros are important 01, 02, etc. 

#BUT let's quickly look at dplyr joining functions because Justin thinks its better ----
library(dplyr)

#but we need to quickly mutate our dataset because dyplr doesn't like row names
#so, let's make a new function called row_names
cell_phenotypes$row_names <- rownames(cell_phenotypes)
cell_proportions$row_names <- rownames(cell_proportions)

data_join <- left_join(x = cell_phenotypes,
                       y= cell_proportions,
                       by = "row_names")
view(data_join)
data_join_rearranged <- relocate(data_join, row_names)
view(data_join_rearranged)

#but this is not the most tidy data set for making the graphs we want. because we would 
#have to make a ggplot for each cell type by hand. So, let's make a long dataset

#So, let's talk about pivot ----
#let's convert our data from  the wide format to the long format (look at the 
#learn how to code page for more information and pictures)
library(tidyr)
data_long <- pivot_longer(data = data_join_rearranged,
                          cols = Cardiomyocytes:Pericytes.SMC,
                          names_to = "cell.type", 
                          values_to = "proportion")
view(data_long)
#now, we can plot the X value to cell type (without having to make a separate ggplot 
#for each cell type). this will save us a lot of time

#Let's get plotting ----

library(ggplot2)

#let's first check that the fractions are pure ################################
#but row.names is not very helpful to us, so let's rename it as fractionID 
data_long <- mutate(data_long,
                    fraction_id = as.character(row_names),
                    row_names = NULL)

ggplot(data_long, aes(x = fraction_id, y = proportion))+
  geom_col(mapping = aes(fill = cell.type))
#this is telling us what each fraction is composed of - CMs, ECs, Fibroblasts, etc. 
#but this is ugly because we can't see the fraction names, so let's fix that

#one option
ggplot(data_long, aes(x = fraction_id, y = proportion))+
  geom_col(mapping = aes(fill = cell.type))+
  guides(x = guide_axis(angle = 45))+
  theme_bw()

#another option
data_long |> 
  filter(type != "whole_tissue") |> 
  ggplot(aes(x = fraction_id, y = proportion, fill = cell.type))+
  geom_bar(position="fill", stat="identity", color = "black", width = 1) +
  facet_grid(cols=vars(type), scales = "free") +
  scale_fill_manual(values = c("#66C2A5","#FC8D62", "#8DA0CB", "#E78AC3", "#A6D854")) +
  theme_minimal() +
  theme(
    axis.title.x = element_blank(), 
    legend.title = element_blank(),
    legend.position = "bottom"
  ) +
  guides(x = guide_axis(angle = 45)) +
  labs(title = "Cell type proportions in purified control samples",
       y = "Cell Type Proportion")

data_long |> 
  filter(type != "whole_tissue") |> 
  ggplot(aes(x = fraction_id, y = proportion, fill = cell.type))+
  geom_bar(position="fill", stat="identity", color = "black", width = 1)
  
#how do we build option 2?
#let's change the colors
ggplot(data_long, aes(x = fraction_id, y = proportion, fill = cell.type))+
  geom_col(mapping = aes(fill = cell.type))+
  guides(x = guide_axis(angle = 45))+
  theme_bw()+
  scale_fill_manual(values = c("#66C2A5","#FC8D62", "#8DA0CB", "#E78AC3", "#A6D854"))

#let's facet out by type
ggplot(data_long, aes(x = fraction_id, y = proportion, fill = cell.type))+
  geom_col(mapping = aes(fill = cell.type))+
  guides(x = guide_axis(angle = 45))+
  theme_bw()+
  scale_fill_manual(values = c("#66C2A5","#FC8D62", "#8DA0CB", "#E78AC3", "#A6D854"))+
  facet_grid(cols = vars(type), scales = "free")
#when you add the scales = "free" it removes the blank data in each facet 
#we can see that the purified fractions are mostly the cell type that it should be
#i.e. the purified CMs are 90% CMs 

#Okay, so our controls worked, that's great! Now, let's look at the experimental data! ###
data_long   |> 
  filter(type == "whole_tissue") |> 
  ggplot(aes(x = cell.type, y = proportion)) +
  geom_bar(stat = "summary", fun = mean, width = 0.9,  color = "black") +
  facet_grid(genotype ~ treatment, scales = "free")+
  theme_minimal() +
  theme(
    axis.title.x = element_blank(), 
    legend.title = element_blank(),
    legend.position = "bottom"
  ) +
  labs(y = "Estimated Proportion") +
  scale_fill_manual(values = c("#66C2A5","#FC8D62", "#8DA0CB", "#E78AC3", "#A6D854")) +
  guides(x = guide_axis(angle = 45))


