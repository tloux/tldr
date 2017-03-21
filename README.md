
<!-- README.md is generated from README.Rmd. Please edit that file -->
This package gives a number of functions to aid reporting statistical results in an RMarkdown file. Functions will return character strings to report p-values, confidence intervals, and hypothesis test and regression results. Strings will be LaTeX-formatted as necessary and will knit pretty in an RMarkdown document. The package also provides a wrapper for the CreateTableOne function in the tableone package to make the results knitable.

`inline` and `write` functions
------------------------------

-   `inline_test()`
-   `inline_reg()`
-   `inline_coef()`
-   `inline_anova()`
-   `write_int()`
-   `write_p()`

Suppose we have the following data set and some inferential results:

``` r
x = rnorm(50)
y = rnorm(50)
a = sample(letters[1:3], size=50, replace=TRUE)
b = sample(letters[1:3], size=50, replace=TRUE)

test1 = t.test(x)
test2 = chisq.test(table(a,b))
model1 = lm(y ~ x)
model2 = lm(y ~ a)
```

We can then report the results of the hypothesis test inline using `inline_test(test1)` and get the following: *t*(49)=0.73, *p* = 0.47. Simiarly, `inline_test(test2)` will report the results of the chi-squared test: *χ*<sup>2</sup>(4)=6.6, *p* = 0.16. So far `inline_test` only works for *t* and chi-squared tests, but the goal is to add more functionality - requests gladly accepted.

The regression results can be reported with `inline_reg(model1)` and `inline_coef(model1, 'x')` to get *R*<sup>2</sup> = 0.03, *F*(1, 48)=1.64, *p* = 0.21 and *b* = 0.17, *t*(48)=1.28, *p* = 0.21, respectively. In addition, `inline_anova(model2)` will report the ANOVA F statistic and relevant results: *F*(2, 47)=0.39, *p* = 0.68. So far `inline_reg` and `inline_coef` currently work for `lm` and `glm` objects; `inline_anova` only works for `lm` objects.

We can also report the confidence intervals using `write_int()` with a length-2 vector of interval endpoints. For example, `write_int(c(3.04, 4.7))` and `write_int(text1$conf.int)` yield (3.04, 4.7) and (-0.19, 0.41), respecively.

P-values can be reported using `write_p()`. This function will take either a numeric value or a list-like object with an element named `p.value`. For example, `write_p(0.00002)` gives *p* &lt; 0.01 and `write_p(test1)` gives *p* = 0.47.

See the help files of all functions described above for more details and options. For example, all test and regression reporting functions have wrappers ending in `_p` which report only the p-value of the input.

`KreateTableOne`
----------------

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
