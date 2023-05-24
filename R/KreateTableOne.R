
# create knit-able Table 1 ================================
# requires tableone
# suggests knitr

#' Create a table of descriptive statistics formatted for knitr::kable
#'
#' \code{KreateTableOne} is a wrapper for \code{tableone::CreateTableOne} which
#' formats the original plain text table as a data.frame of character columns.
#' \code{KnitableTableOne} is a wrapper for \code{tableone::print.TableOne} which
#' allows for more versatility in printing options. The output of both functions
#' can be printed in an RMarkdown document in a number of ways, e.g., using
#' \code{knitr::kable}. \code{svyKreateTabeOne} does the same with
#' \code{tableone::svyCreateTableOne} for complex survey data.
#'
#' These are very hacky functions. If used within an RMarkdown document,
#' KreateTableOne and KnitableTableOne should be called in a code chunk with
#' \code{results='hide'} to hide the plain test results printed from
#' \code{tableone::CreateTableOne}. The resulting data frame should be saved
#' as an object and used in a second code chunk for formatted printing.
#' Suggestions for improvement are welcomed.
#'
#' The function is written to work with \code{knitr::kable}, but should be able
#' to work with other functions such as \code{xtable::xtable}.
#'
#' @param x A TableOne object created from \code{tableone::CreateTableOne}.
#' @param ... Parameters to be passed to \code{tableone::CreateTableOne}
#' (\code{KreateTableOne}) or \code{tableone::print.TableOne} (\code{KnitableTableOne}).
#'
#' @return Returns a data frame of character columns.
#'
#' @seealso \code{\link[tableone]{CreateTableOne}} \code{\link[tableone]{print.TableOne}}
#'
#' @examples
#' table1 = KreateTableOne(data=mtcars, strata='am', factorVars='vs')
#' table1
#' knitr::kable(table1)
#'
#' @export

KreateTableOne = function(...){
  t1 = tableone::CreateTableOne(...)
  t2 = print(t1, quote=TRUE)
  rownames(t2) = gsub(pattern='\\"', replacement='', rownames(t2))
  colnames(t2) = gsub(pattern='\\"', replacement='', colnames(t2))
  return(t2)
}


#' @rdname KreateTableOne

svyKreateTableOne = function(...){
  t1 = tableone::svyCreateTableOne(...)
  t2 = print(t1, quote=TRUE)
  rownames(t2) = gsub(pattern='\\"', replacement='', rownames(t2))
  colnames(t2) = gsub(pattern='\\"', replacement='', colnames(t2))
  return(t2)
}

#' @rdname KreateTableOne

KnitableTableOne = function(x, ...){
  t2 = print(x, quote=TRUE, ...)
  rownames(t2) = gsub(pattern='\\"', replacement='', rownames(t2))
  colnames(t2) = gsub(pattern='\\"', replacement='', colnames(t2))
  return(t2)
}
