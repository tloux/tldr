
# create knit-able Table 1 ================================
# requires tableone
# suggests knitr

#' Create a table of descriptive statistics formatted for knitr::kable
#' 
#' \code{KreateTableOne} is a wrapper for \code{tableone::CreateTableOne} which formats the original plain text table as a data.frame of character columns. This can be printed in an RMarkdown document in a number of ways, e.g., using \code{knitr::kable}.
#' 
#' This is a very hacky function. If used within an RMarkdown document, KreateTableOne should be called in a code chunk with \code{results=hide} to hide the plain test results printed from \code{tableone::CreateTableOne}. The resulting data frame should be saved as an object and used in a second code chunk with \code{results=TRUE} (the RMarkdown default) for formatted printing. Suggestions for improvement are welcomed.
#' 
#' The function is written to work with \code{knitr::kable}, but should be able to work with other functions such as \code{xtable::xtable}.
#' 
#' @param x The data set to be passed to the \code{data} parameter of \code{tableone::CreateTableOne}
#' @param ... Other parameters to be passed to \code{tableone::CreateTableOne}
#' 
#' @return Returns a data frame of character columns.
#' 
#' @seealso \code{\link[tableone]{CreateTableOne}}
#' 
#' @examples 
#' table1 = KreateTableOne(x=mtcars, strata='am', factorVars='vs')
#' table1
#' 
#' @export

KreateTableOne = function(x, ...){
  t1 = tableone::CreateTableOne(data=x, ...)
  t2 = print(t1, quote=TRUE)
  rownames(t2) = gsub(pattern='\\"', replacement='', rownames(t2))
  colnames(t2) = gsub(pattern='\\"', replacement='', colnames(t2))
  return(t2)
}
