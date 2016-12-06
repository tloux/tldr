
# report regression fit ===================================

#' Report the fit of a regression model inline
#' 
#' \code{inline_reg} presents the fit of a coefficient from a \code{lm} or \code{glm} model in LaTeX format to be reported inline in an RMarkdown document.
#' 
#' For \code{lm} objects, results include R-squared, the F statistic, and the p-value. For \code{glm} objects, results include the chi-squared statistic and the p-value.
#' 
#' This function currently only supports \code{lm} and \code{glm} objects. Suggestions and requests are welcomed.
#' 
#' \code{inline_reg_p} is a wrapper for \code{inline_reg} to report only the p-value (sets all non-p-value logicals to FALSE). \code{inline_anova} is a wrapper to report a one-way ANOVA result in which \code{fit} is set to FALSE and other logical inputs (\code{stat}, \code{pval}, and \code{digits}) are allowed to be user-defined.
#' 
#' @param model A regression model
#' @param fit Logical, whether the regression fit is to be reported (default TRUE, only applicable to \code{lm} objects)
#' @param stat Logical, whether the test statistic for the coefficient should be reported (default TRUE)
#' @param pval Logical, whether the p-value for the coefficient should be reported (default TRUE)
#' @param digits Number of digits to round to (default to 2)
#' 
#' @return Returns a LaTeX-formatted result for use in RMarkdown document.
#' 
#' @examples
#' x1 = rnorm(20)
#' y1 = x1 + rnorm(20)
#' model1 = lm(y1 ~ x1)
#' inline_reg(model1)
#' 
#' x2 = rnorm(20)
#' y2 = rbinom(n=20, size=1, prob=pnorm(x2))
#' model2 = glm(y2 + x2, family=binomial('logit'))
#' inline_reg(model2)
#' 
#' @export

inline_reg = function(model, fit=TRUE, stat=TRUE, pval=TRUE, digits=2){
  UseMethod('inline_reg')
}




# lm method ===============================================

#' @export
inline_reg.lm = function(model, fit=TRUE, stat=TRUE, pval=TRUE, digits=2){
  
  info = summary(model)
  fstat = info$fstatistic
  
  
  # fit (R-squared)
  
  if(fit){
    rsq = round(info$r.sq, digits)
    fit_text = paste0('$R^2 = ', rsq, '$')
  }else{
    fit_text = NULL
  }
  
  
  # F statistic
  
  if(stat){
    stat_text = paste0('$F(', fstat[2], ',', fstat[3], ') = ', 
                       round(fstat[1],digits), '$')  
  }else{
    stat_text = NULL
  }
  
  
  # p-value
  
  if(pval){
    p = 1 - pf(fstat[1], df1=fstat[2], df2=fstat[3])
    p_text = write_p(x=p, digits=digits)
  }else{
    p_text = NULL
  }
  
  
  # text output
  
  strng = paste(c(fit_text, stat_text, p_text), collapse=', ')
  return(strng)
}




# glm method ==============================================

#' @export
inline_reg.glm = function(model, fit=TRUE, stat=TRUE, pval=TRUE, digits=2){
  
  info = summary(model)
  chistat = info$null.deviance - info$deviance
  df = info$df.null - info$df.residual
  
  
  # chi^2 statistic
  
  if(stat){
    stat_text = paste0('$\\chi^2(', df, ') = ', round(chistat, digits), '$')  
  }else{
    stat_text = NULL
  }
  
  
  # p-value
  
  if(pval){
    p = 1 - pchisq(chistat, df=df)
    p_text = write_p(x=p, digits=digits)
  }else{
    p_text = NULL
  }
  
  
  # text output
  
  strng = paste(c(stat_text, p_text), collapse=', ')
  return(strng)
}




# wrapper for just p-value ================================

#' @rdname inline_reg
#' @export

inline_reg_p = function(model, digits=2){
  inline_reg(model, fit=FALSE, stat=FALSE, digits=digits)
}




# wrapper for one-way ANOVA (sets fit=FALSE) ==============

#' @rdname inline_reg
#' @export

inline_anova = function(model, stat=TRUE, pval=TRUE, digits=2){
  inline_reg(model, fit=FALSE, stat=stat, pval=pval, digits=digits)
}