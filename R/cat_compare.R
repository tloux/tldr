
#' Investigate association bewtween two categorical variables
#' 
#' \code{cat_compare} gives details about the association between two categorical variables.
#' 
#' Strictly, x and y do not need to be characters or factors. Either or both may be numerical, but it will be assumed the numbers are coded categories. 
#' 
#' @param y A categorical variable: the outcome, if appropriate
#' @param x A catgegorical variable: the predictor or group variable, if appropriate
#' @param title The main title of the mosaic plot
#' @param digits Number of digits which proportion table should be round to (default to 2)
#' @param plot Logical. Whether a mosaic plot should be drawn
#' 
#' @return Returns a list including (1) a two-way table of counts, (2) a two-way table of proportions conditional on x (columns), (3) a chi-squared test for independence between x and y, and (4) Cramer's V for the association between x and y.
#' 
#' The two tables will include missing values of both variables, but these rows/columns are discarded prior to the chi-squared test and Cramer's V calculations.
#' 
#' @examples
#' v1 = rbinom(n=50, size=1, p=0.5)
#' v2 = rbinom(n=50, size=2, p=0.3 + 0.2*v1)
#' cat_compare(y=v2, x=v1, title='A cat_compare example', digits=3, plot=TRUE)
#' 
#' @export

cat_compare = function(y, x, title='', digits=2, plot=TRUE){
  
  t1 = table(y, x, useNA='ifany', dnn=NULL)
  t2 = round(prop.table(t1, margin=2), digits)
  
  exclude_missing = table(y, x, useNA='no', dnn=NULL)
  
  chisq = chisq.test(exclude_missing)
  min_dim = min(nrow(exclude_missing), ncol(exclude_missing))
  V = unname(sqrt(chisq$statistic / (sum(exclude_missing) * (min_dim - 1))))
  
  if(plot){
    mosaicplot(t(exclude_missing), main=title, color=blues9[(9-nrow(t2)+1):9])
  }
  
  list(n=t1, p=t2, chisq=chisq, CramersV=V)
}
