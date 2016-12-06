
#' Report a hypothesis test inline
#' 
#' \code{inline_test} formats the results of an htest object into LaTeX to be presented inline in an RMarkdown document.
#' 
#' This function currently only supports t tests and chi-squared tests. Suggestions and requests are welcomed.
#' 
#' \code{inline_test_p} is a wrapper for \code{inline_test} to report only the p-value (sets all non-p-value logicals to FALSE).
#' 
#' @param test An htest object
#' @param stat Logical, whether to report test statistic (default TRUE)
#' @param pval Logical, whether to report p-value (default TRUE)
#' @param digits Number of digits to round to (default to 2)
#' 
#' @return Returns a LaTeX-formatted hypothesis test result for use in RMarkdown document.
#' 
#' @examples
#' x = rnorm(20)
#' test1 = t.test(x)
#' inline_test(test1)
#' inline_test_p(test1)
#' 
#' @export

inline_test = function(test, stat=TRUE, pval=TRUE, digits=2){
  
  
  # test statitic
  
  if(stat){
    
    # t tests
    
    if(grepl(pattern='t-test', x=test$method)){
      
      stat_text = paste0('$t(', round(test$parameter,1),') = ', 
                         round(test$statistic, digits), '$')
    }else 
    
    # chi-sq tests
    
    if(grepl(pattern='Chi-squared', x=test$method)){
      
      stat_text = paste0('$\\chi^2(', test$parameter, ') = ', 
                         round(test$statistic, digits), '$')
    }else{
      stop('Test not accommodated. Please request function update.')
    }
  }else{
    stat_text = NULL
  }
  
  
  # p-value for all tests
  
  if(pval){
    p_text = write_p(x=test, digits=digits)
  }else{
    p_text = NULL
  }
  
  
  # text output
  
  strng = paste(c(stat_text, p_text), collapse=', ')
  return(strng)
}




# wrapper for just p-value ================================

#' @rdname inline_test
#' @export

inline_test_p = function(test, digits=2){
  inline_test(test, stat=FALSE, digits=digits)
}
