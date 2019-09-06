
#' Compare a numerical vairable across levels of a categorical variable
#'
#' \code{cont_compare} gives details about the distribution of a numeric variable ascorss subsets of the dataset
#'
#' @param y A numerical variable
#' @param grp A catgegorical variable
#' @param plot Type of plot to produce
#' @param print_plot Whether plot should be printed to screen. Plot will always be saved as part of output list.
#'
#' @return Returns a list including (1) group-wise summary statistics, (2) an ANOVA decomposition, (3) eta-squared effect size, and (4) a ggplot2 object, if requested.
#'
#' @examples
#' v1 = rbinom(n=50, size=1, p=0.5)
#' v2 = rnorm(50)
#' cat_compare(y=v2, grp=v1, plot='density')
#'
#' @export

cont_compare = function(y, grp, plot=c('density','boxplot','none')){

  mydat = data.frame(grp=as.character(grp), y)

  # group-wise summary statistics

  grps = sort(unique(mydat$grp))

  sum_tab = t(sapply(grps, function(g) summary(mydat$y[mydat$grp==g])))
  rownames(sum_tab) = grps

  # ANOVA

  decomp = summary(aov(y ~ grp, data=mydat))

  # eta-squared

  eta_sq = decomp[[1]]$`Sum Sq`[1] / sum(decomp[[1]]$`Sum Sq`)

  # plot

  plot = plot[1]

  if(plot == 'none'){
    ret = list(sum_tab, decomp, eta_sq)

  }else{
    if(plot=='density'){
      myplot = ggplot2::ggplot(data=mydat, aes(x=y, fill=grp)) +
        ggplot2::geom_density(alpha=0.5) +
        ggplot2::geom_rug(aes(color=grp)) +
        ggplot2::facet_grid(grp ~ .) +
        ggplot2::theme_minimal() +
        ggplot2::theme(legend.position="none")
    }

    if(plot == 'boxplot'){
      myplot = ggplot2::ggplot(data=mydat, aes(y=y, x=grp, fill=grp)) +
        ggplot2::geom_boxplot(alpha=0.5) +
        ggplot2::theme_minimal() +
        ggplot2::theme(legend.position='none')
    }

    ret = list(sum_tab, decomp, eta_sq, myplot)
  }

  return(ret)
}
