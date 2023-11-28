# 1.  Loading and initializing renv ####

library(renv)

#renv::init()

#renv::snapshot()

# 2. Loading packages needed for the assignment ####

library(tidyverse)
library(GGally)

# 3. Exploring Iris ####

data(iris)

# First look at the data 

head(iris)
summary(iris)
str(iris)

# Converting data.frame to tibble.

df <- as_tibble(iris)

# Visualizing all variables with histograms, point plots, density plots and box plots between species. 

GGally::ggpairs(df, aes(color = Species))

# Dropping all NA and Looking at the mean for all variables for each species

df %>% 
  group_by(Species) %>%
  drop_na() %>%
  summarize_all(mean)

# 4. Visualizing Iris ####

# Converting df from wide to long format with three columns, species, variable and value

df_long <- tidyr::gather(df, key = "Variable", value = "Value", -Species)

# 1. Using df_long to create a plot using ggplot2. 
# 2. x = species to separate box and violin plots by species on the x axis.
# 3. y = Value which will correspond to it's species, and variable df_long format.
# 4. fill = Species to color by species. 
# 5. geom_boxplot and geom_violin to create both types of plots. Alpha = 0.5 to improve visualization.
# The boxplot and violoin plots together gives a good visualization of the distribution of data for each variable by species. 
# 6. facet_wrap to create different plots for each type of variable (petal and sepal length and width).
# 7. labs() to label title, x, and y. 
# 8. theme_bw(), down to preference. 

ggplot(df_long, aes(x = Species, y = Value, fill = Species)) +
  geom_boxplot(alpha = 0.5) +
  geom_violin(alpha = 0.5) +
  facet_wrap(~Variable, scales = "free_y", ncol = 2) +
  labs(title = "Boxplots with Violin plot overlay by Species",
       x = "Species",
       y = "Value") +
  theme_bw()
