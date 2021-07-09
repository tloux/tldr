
#' Format an interval for display
#'
#' \code{write_int} formats a numeric input into a character interval to be printed, e.g., in an RMarkdown document.
#'
#' @param x A length-2 numeric vector consisting of the endpoints of the interval or a 2-column matrix with endpoints of intervals in each row.
#' @param delim The bracket delimiters to surround the interval. Must be either a round bracket, square bracket, curly bracket, or angled bracket.
#' @param digits Number of digits to round to (default to 2). Will keep trailing zeros.
#'
#' @return Returns a character string of the form "(x[1], x[2])" (or supplied bracket delimiter) or a character vector of multiple formatted intervals if x is a matrix.
#'
#' @examples
#' write_int(x=c(1.2, 2.345))
#' write_int(x=c(1.2, 2.345), delim='[')
#'
#' @export

write_int = function(x, delim='(', digits=2){
  UseMethod('write_int')
}




#' @export
write_int.numeric = function(x, delim='(', digits=2){

  if(length(x) != 2) stop('x must be length 2.')

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




#' @export
write_int.matrix = function(x, delim='(', digits=2){

  if(ncol(x) != 2) stop('Matrix must have exactly 2 columns')

  ints = sapply(1:nrow(x), function(i){

    mypair = x[i, ]
    myint = write_int.numeric(x=mypair, delim=delim, digits=digits)

    return(myint)
  })

  return(ints)
}
