
#' Format an interval for display
#'
#' \code{write_int} formats a numeric input into an interval to be printed, e.g., in an RMarkdown document.
#'
#' If a matrix is provided, the values in each row will be used to create a formatted interval.
#'
#' @param x A length-2 numeric vector consisting of the endpoints of the interval or an n-row by 2-column matrix of endpoints.
#' @param delim The bracket delimiters to surround the interval. Must be either a round bracket, square bracket, curly bracket, or angled bracket.
#' @param digits Number of digits to round to (default to 2). Will keep trailing zeros.
#'
#' @return Returns a character string of the form "(x[1], x[2])" (or supplied bracket delimiter).
#'
#' @examples
#' write_int(x=c(1.2, 2.345))
#' write_int(x=c(1.2, 2.345), delim='[')
#'
#' @export

write_int = function(x, delim='(', digits=2){
  UseMethod('write_int')
}




# numeric input ===========================================

#' @export
write_int.numeric = function(x, delim='(', digits=2){

  if(!(delim %in% c('(', '[', '{', '<'))) stop('delim must be one of "(", "[", "{", or "<".')

  if(delim == '('){
    delim1 = '('
    delim2 = ')'
  }else if(delim == '['){
    delim1 = '['
    delim2 = ']'
  }else if(delim == '{'){
    delim1 = '{'
    delim2 = '}'
  }else if(delim == '<'){
    delim1 = '<'
    delim2 = '>'
  }


  spr_fmt = paste0('%.', digits, 'f')
  strng = paste0(delim1, sprintf(spr_fmt, x[1]), ', ',
                 sprintf(spr_fmt, x[2]), delim2)

  return(strng)
}




# matrix input ============================================

#' @export
write_int.matrix = function(x, delim='(', digits=2){

  if(ncol(x) != 2) stop('Matrix must have exactly two columns.')

  cis = sapply(1:nrow(x), function(i){

    endpts = as.numeric(x[i, ])
    ci = write_int.numeric(x=endpts, delim=delim, digits=digits)
    return(ci)
  })

  return(cis)
}
