
#' Investigate association between two categorical variables
#'
#' \code{cat_compare} gives details about the association between two categorical variables.
#'
#' Strictly, x and y do not need to be factors but will be coerced into factors.
#'
#' @param x A categorical variable: the predictor or group variable, if appropriate
#' @param y A categorical variable: the outcome, if appropriate
#' @param plot Logical. Whether a mosaic plot should be drawn
#'
#' @return Returns a list including (1) two-way table of counts, (2) chi-squared test for independence, (3) Cramer's V standardized effect, and (4) ggplot2 column plot of proportions conditional on x, if requested.
#'
#' The table of counts will include missing values of both variables, but these rows/columns are discarded prior to the chi-squared test and Cramer's V calculations.
#'
#' @examples
#' v1 = rbinom(n=50, size=1, p=0.5)
#' v2 = rbinom(n=50, size=2, p=0.3 + 0.2*v1)
#' cat_compare(x=v1, y=v2, plot=TRUE)
#'
#' @export

cat_compare = function(x, y, plot=TRUE){

  mydat = data.frame(x=as.factor(x), y=as.factor(y))

  # table of counts

  tab_counts0 = table(mydat$x, mydat$y, useNA='ifany', dnn=c('x','y'))
  tab_counts = addmargins(tab_counts0)

  # chi-squared test (observed data only)

  tab_no_miss = table(mydat$x, mydat$y, useNA='no')
  chisq = chisq.test(tab_no_miss)

  # cramer's V

  min_dim = min(nrow(tab_no_miss), ncol(tab_no_miss))
  V = unname(sqrt(chisq$statistic / (sum(tab_no_miss) * (min_dim - 1))))

  # plot

  if(isFALSE(plot)){
    ret = list(counts=tab_counts, chisq=chisq, CramersV=V)

  }else{
    tmp = reshape2::melt(prop.table(tab_counts0, margin=1))
    tmp$x = as.factor(tmp$x)
    tmp$y = as.factor(tmp$y)
    names(tmp)[3] = 'prop within x'

    myplot = ggplot(data=tmp, aes(x=x, y=`prop within x`, fill=y)) +
      geom_col(position=position_dodge())

    ret = list(counts=tab_counts, chisq=chisq, CramersV=V, plot=myplot)
  }

  return(ret)
}
