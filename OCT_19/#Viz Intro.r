#Viz Intro
install.packages(c("tidyverse", "palmerpenguins")) # for ggplot2 and others and for the penguins dataset
library(tidyverse)
library(palmerpenguins)

my_df <- penguins
View(my_df)

# create a bar plot of species. ALl abrs same color
ggplot(my_df, mapping=aes(x=species)) +
    geom_bar( fill='green')

#create a bar plot of species, Different color bars
ggplot(my_df, aes(x=species, fill=species)) +
    geom_bar()

# create a bar plot of species. Differentiate by island
ggplot(my_df, aes(y=species, fill=island)) +
    geom_bar() 

#create a histogram of body mass
ggplot(my_df, aes(x=body_mass_g)) +
    geom_histogram(bins=20)

#create a density of body mass
ggplot(my_df, aes(x=body_mass_g, fill=species)) +
    geom_density(alpha=0.3)

# any apparent relation between
ggplot(my_df, aes(x=body_mass_g,y=bill_length_mm)) +
    geom_point()
