# Feature Selection using Genetic Algorithms in R

This script select the 'best' subset of variables based on genetic algorithms in R. 

It uses a custom fitness function for binary-class classification. Please modify it to use in other scenarios.

This sctipt is realated to the blog post: [Feature Selection using Genetic Algorithms in R](https://blog.datascienceheroes.com/feature-selection-using-genetic-algorithms-in-r/).

# How to run the example? 

The code is ready to calculate the best subset for a cancer dataset (`data_breast_cancer2.csv`), included in the repo. This is in `var_sel_gen_alg.R`.

The initial data preparation removes the `NA`, and it converts the target variable (`data_y`) into a factor in order to create the predictive model. Both are conditions for the Random Forest that is built behind, using `caret` package.

You can find how the predictive model is created in the function `get_roc_metric`, inside the `lib_ga.R` file. And it is, as the name suggests, prepared for a binary classification problem.

My suggestion before applying with your data is, use the function `get_roc_metric` directly with your current dataset, and see if it ends ok. If so, proceed to apply the GA procedure.

My idea was to encapsulate the fitness function so you can adjust it better for your purposes. For example, if you want to return `Kappa` statistic (multi-class target), or RMSE (regression-target). You have to replace `get_roc_metric` function.

--

Feel free to share your insights, have fun!

[Twitter](https://twitter.com/pabloc_ds)

![](https://blog.datascienceheroes.com/content/images/2019/01/evolutionary_algortihm.gif)
