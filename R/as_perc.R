
#' Format a proportion as a percentage
#'
#' \code{as_perc} formats a proportion as a percentage to print in an RMarkdown
#' document
#'
#' Simply multiplies \code{p} by 100 and affixes a percent sign to the end after
#' rounding.
#'
#' @param p A length-1 numeric to be interpreted as a proportion
#' @param digits Number of digits to round percentage to (default to 0)
#'
#' @return Returns a string to report a percentage to the specified number of
#'   digits.
#'
#' @examples
#' as_perc(0.2345)
#'
#' as_perc(0.000234)
#'
#' @export

as_perc = function(p, digits=0){
  
  if(length(p) > 1){
    warning('p length greater than 1, only first element will be used.')
    p = p[1]
  }
  
  if((p < 0) | (p > 1)){
    stop('p expected to be proportion between 0 and 1')
  }
  
  perc = round(p * 100, digits=digits)
  perc_text = paste0(perc, '%')
  
  return(perc_text)
}
