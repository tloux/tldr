
# report regression coefficient ===========================

#' Report the coefficient from a regression model inline
#' 
#' \code{inline_coef} presents the resuts of a coefficient from a \code{lm} or \code{glm} model in LaTeX format to be reported inline in an RMarkdown document.
#' 
#' This function currently only supports \code{lm} and \code{glm} objects. Suggestions and requests are welcomed.
#' 
#' \code{inline_coef_p} is a wrapper for \code{inline_coef} to report only the p-value (sets all non-p-value logicals to FALSE).
#' 
#' @param model A regression model
#' @param variable A character string giving the name of the variable to be reported
#' @param coef Logical, whether the coefficient value is to be reported (default TRUE)
#' @param stat Logical, whether the test statistic for the coefficient should be reported (default TRUE)
#' @param pval Logical, whether the p-value for the coefficient should be reported (default TRUE)
#' @param digits Number of digits to round to (default to 2)
#' 
#' @return Returns a LaTeX-formatted result for use in RMarkdown document.
#' 
#' @examples
#' x1 = rnorm(20)
#' x2 = rnorm(20)
#' y = x1 + x2 + rnorm(20)
#' model1 = lm(y ~ x1 + x2)
#' inline_coef(model1, 'x1')
#' inline_coef_p(model1, 'x1')
#' 
#' @export

inline_coef = function(model, variable, coef=TRUE, stat=TRUE, pval=TRUE, digits=2){
  UseMethod('inline_coef')
}




# lm method ===============================================

#' @export
inline_coef.lm = function(model, variable, coef=TRUE, stat=TRUE, pval=TRUE, digits=2){
  
  info = summary(model)$coefficients
  
  
  # coefficient
  
  if(coef){
    b = round(info[variable,'Estimate'], digits)
    b_text = paste0('$b = ', b, '$')  
  }else{
    b_text = NULL
  }
  
  
  # test statistic
  
  if(stat){
    t = round(info[variable,'t value'], digits)
    df = model$df.residual
    stat_text = paste0('$t(', df, ') = ', t, '$')
  }else{
    stat_text = NULL
  }
  
  
  # p-value
  
  if(pval){
    p = round(info[variable,'Pr(>|t|)'], digits)
    p_text = write_p(x=p, digits=digits)
  }else{
    p_text = NULL
  }
  
  
  # text output
  
  strng = paste(c(b_text, stat_text, p_text), collapse=', ')
  return(strng)
}




# glm method ==============================================

#' @export
inline_coef.glm = function(model, variable, coef=TRUE, stat=TRUE, pval=TRUE, digits=2){
  
  info = summary(model)$coefficients
  
  
  # coefficient
  
  if(coef){
    b = round(info[variable,'Estimate'], digits)
    b_text = paste0('$b = ', b, '$')
  }else{
    b_text = NULL
  }
  
  
  # test statistic
  
  if(stat){
    z = round(info[variable,'z value'], digits)
    stat_text = paste0('$z = ', z, '$')
  }else{
    stat_text = NULL
  }
  
  
  # p-value
  
  if(pval){
    p = round(info[variable,'Pr(>|z|)'], digits)
    p_text = write_p(x=p, digits=digits)
  }else{
    p_text = NULL
  }
  
  
  # text output
  
  strng = paste(c(b_text, stat_text, p_text), collapse=', ')
  return(strng)
}


# wrapper for just p-value ================================

#' @rdname inline_coef
#' @export

inline_coef_p = function(model, variable, digits=2){
  inline_coef(model, variable, coef=FALSE, stat=FALSE, digits=digits)
}
