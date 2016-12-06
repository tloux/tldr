
#' Format a p-value for display
#' 
#' \code{write_p} formats a p-value for display in an RMarkdown document.
#' 
#' If x < 10^(-digits), then the result is the string p < 10^(-digits) in decimal notation.
#' 
#' @param x A length-1 numeric or a list-like object with element named \code{p.value} (such as an htest object)
#' @param digits Number of digits to round to (default to 2)
#' 
#' @return Returns a LaTeX-formatted string to report a p-value to the specified number of digits.
#' 
#' @examples 
#' write_p(0.2345)
#' 
#' write_p(0.000234)
#' 
#' x = rnorm(10)
#' test1 = t.test(x)
#' write_p(test1)
#' 
#' @export

write_p = function(x, digits=2) UseMethod('write_p')




# numeric method ==========================================

#' @export
write_p.numeric= function(x, digits=2){
  
  if(length(x) > 1){
    warning('Numeric length greater than 1, only first element will be used.')
    x = x[1]
  }
  
  if(x < 10^(-digits)){
    p_text = paste0('$p < ', 10^(-digits), '$')
  }else{
    p_text = paste0('$p = ', round(x, digits), '$')
  }
  
  return(p_text)
  
}




# default method (for htest and other list-like objects) ==

#' @export
write_p.default = function(x, digits=2){
  
  p = x$p.value
  
  p_text = write_p.numeric(p, digits=digits)
  
  return(p_text)
}
