####################################################################
## Script to select best variables for a classification mode using genetic algorithms. 
## Based on `GA` library with custom fitness function. 
## This script is explained in the post: 
## Contact: https://twitter.com/pabloc_ds
####################################################################

# Install packages if missing
list.of.packages <- c("parallel", "doParallel", "caret", "randomForest", "funModeling", "tidyverse", "GA")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)

# Load libraries
library(caret)
library(randomForest)
library(funModeling)
library(tidyverse)
library(GA)
source("lib_ga.R")

data=read_delim("data_breast_cancer2.csv", delim = ",")  

# Data preparation
data2=na.omit(data) # <- use with care...

data_y=as.factor(data2$diagnosis)
data_x=select(data2, -diagnosis, -id)

# GA parameters
param_nBits=ncol(data_x)
col_names=colnames(data_x)

# Executing the GA 
# Executing the GA 
ga_GA_1 = ga(fitness = function(vars) custom_fitness(vars = vars, 
                                                     data_x =  data_x, 
                                                     data_y = data_y, 
                                                     p_sampling = 0.7), # custom fitness function
             type = "binary", # optimization data type
             crossover=gabin_uCrossover,  # cross-over method
             elitism = 3, # number of best ind. to pass to next iteration
             pmutation = 0.03, # mutation rate prob
             popSize = 50, # the number of indivduals/solutions
             nBits = param_nBits, # total number of variables
             names=col_names, # variable name
             run=5, # max iter without improvement (stopping criteria)
             maxiter = 50, # total runs or generations
             monitor=plot, # plot the result at each iteration
             keepBest = TRUE, # keep the best solution at the end
             parallel = T, # allow parallel procesing
             seed=84211 # for reproducibility purposes
)


# Checking the results
summary(ga_GA_1)

# Following line will return the variable names of the final and best solution
best_vars_ga=col_names[ga_GA_1@solution[1,]==1]

# Checking the variables of the best solution...
best_vars_ga

# Checking the accuracy
get_accuracy_metric(data_tr_sample = data_x, target = data_y, best_vars_ga)
