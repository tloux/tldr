
#' Cut a numeric vector into quantiles
#'
#' \code{cutp} is a wrapper for the base `cut` function. The vector `x` will be categorized using the percentiles provided in `p` to create break values.
#'
#' Within the `cutp` function, `p` is passed to `quantile` as the `probs` input. The computed quantiles are then used as the `breaks` in `cut`.
#'
#' The values `-Inf` and `Inf` are added to the beginning and end of the breaks vector, respectively, so quantiles for 0 and 1 do not need to be given explicitly.
#'
#' @param x A numeric vector to be discretized
#' @param p A numeric vector of probabilities
#' @param ... Arguments passed to `cut`
#'
#' @return Returns the output from `cut`. This is usually a factor unless otherwise specified.
#'
#' #' @seealso \code{\link[stats]{quantile}}; \code{\link[base]{cut}}
#'
#' @examples
#' myvals = rnorm(1000)
#' catx = cutp(x=myvals, p=c(0.25, 0.5, 0.75), labels=c('Q1', 'Q2', 'Q3', 'Q4'))
#' table(catx)
#'
#' @export

cutp = function(x, p, ...){

  brks = quantile(x=x, probs=p)
  newx = cut(x=x, breaks=c(-Inf,brks,Inf), ...)

  return(newx)
}
