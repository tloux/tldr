
<!-- README.md is generated from README.Rmd. Please edit that file -->
This package gives a number of functions to aid reporting statistical results in an RMarkdown file. Functions will return character strings to report p-values, confidence intervals, and hypothesis test and regression results. Strings will be LaTeX-formatted as necessary and will knit pretty in an RMarkdown document. The package also provides a wrapper for the CreateTableOne function in the tableone package to make the results knitable.

Suppose we have the following data set and some inferential results:

``` r
x = rnorm(50)
test1 = t.test(x)
```

We can then report the results of the hypothesis test inline using `inline_test(test1)` and get the following: *t*(49)=1.07, *p* = 0.29. We can also report the confidence interval using `write_int(test1$conf.int)` to get: (-0.14, 0.47).

Similar functions include:

-   `inline_reg` to report the fit of a regression model
-   `inline_coef` to report the coefficient of a regression model
-   `write_p` to format a numeric as a p-value

The package also provides the function `KreateTableOne`, a wrapper for `CreateTableOne` from the `tableone` package which makes the results knitable. First use `KreateTableOne` in an R chunk with `results='hide'` (or ouside the RMarkdown document), then recall the saved data frame in a new chunk. For example:

``` r
table1 = KreateTableOne(x=mtcars, strata='am', 
                        factorVars='vs')
colnames(table1)[1:2] = c('am = 0', 'am = 1')
```

Then

``` r
knitr::kable(table1[, 1:3], align='r')
```

|                  |           am = 0|          am = 1|          p|
|------------------|----------------:|---------------:|----------:|
| n                |               19|              13|           |
| mpg (mean (sd))  |     17.15 (3.83)|    24.39 (6.17)|  &lt;0.001|
| cyl (mean (sd))  |      6.95 (1.54)|     5.08 (1.55)|      0.002|
| disp (mean (sd)) |  290.38 (110.17)|  143.53 (87.20)|  &lt;0.001|
| hp (mean (sd))   |   160.26 (53.91)|  126.85 (84.06)|      0.180|
| drat (mean (sd)) |      3.29 (0.39)|     4.05 (0.36)|  &lt;0.001|
| wt (mean (sd))   |      3.77 (0.78)|     2.41 (0.62)|  &lt;0.001|
| qsec (mean (sd)) |     18.18 (1.75)|    17.36 (1.79)|      0.206|
| vs = 1 (%)       |         7 (36.8)|        7 (53.8)|      0.556|
| am (mean (sd))   |      0.00 (0.00)|     1.00 (0.00)|  &lt;0.001|
| gear (mean (sd)) |      3.21 (0.42)|     4.38 (0.51)|  &lt;0.001|
| carb (mean (sd)) |      2.74 (1.15)|     2.92 (2.18)|      0.754|
