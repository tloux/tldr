
#' Compare a numerical variable across levels of a categorical variable
#'
#' \code{num_compare} gives details about the distribution of a numeric variable across subsets of the dataset
#'
#' @param y A numerical variable
#' @param grp A categorical variable
#' @param plot Type of plot to produce
#' @param print_plot Whether plot should be printed to screen. Plot will always be saved as part of output list if `plot` is not `'none'`.
#'
#' @return Returns a list including (1) group-wise summary statistics, (2) ANOVA decomposition, (3) eta-squared effect size, and (4) ggplot2 object, if requested.
#'
#' @examples
#' v1 = rbinom(n=50, size=1, p=0.5)
#' v2 = rnorm(50)
#' cat_compare(y=v2, grp=v1, plot='density')
#'
#' @export

num_compare = function(y, grp, plot=c('density','boxplot','none')){

  mydat = data.frame(grp=as.character(grp), y)

  # group-wise summary statistics

  grps = sort(unique(mydat$grp))

  sum_tab = t(sapply(grps, function(g){

    ysubset = mydat$y[mydat$grp==g]

    yn = length(ysubset)
    yobs = sum(!is.na(ysubset))
    ymis = length(ysubset) - yobs
    ymn = mean(ysubset, na.rm=TRUE)
    ysd = sd(ysubset, na.rm=TRUE)
    ymed = median(ysubset, na.rm=TRUE)
    yq1 = unname(quantile(ysubset, probs=0.25, na.rm=TRUE))
    yq3 = unname(quantile(ysubset, probs=0.75, na.rm=TRUE))

    ret = c('n'=yn, 'obs'=yobs, 'mis'=ymis,
            'mean'=ymn, 'stdev'=ysd,
            'med'=ymed, 'q1'=yq1, 'q3'=yq3)
  }))

  # ANOVA

  decomp = aov(y ~ grp, data=mydat)

  # eta-squared

  eta_sq = decomp[[1]]$`Sum Sq`[1] / sum(decomp[[1]]$`Sum Sq`)

  # plot

  plot = plot[1]

  if(plot == 'none'){
    ret = list(summary_stats=sum_tab, decomp=decomp, eta_sq=eta_sq)

  }else{
    if(plot=='density'){
      myplot = ggplot2::ggplot(data=mydat, ggplot2::aes(x=y, fill=grp)) +
        ggplot2::geom_density(alpha=0.5) +
        ggplot2::geom_rug(ggplot2::aes(color=grp)) +
        ggplot2::facet_grid(grp ~ .) +
        ggplot2::theme_minimal() +
        ggplot2::theme(legend.position="none")
    }

    if(plot == 'boxplot'){
      myplot = ggplot2::ggplot(data=mydat, ggplot2::aes(y=y, x=grp, fill=grp)) +
        ggplot2::geom_boxplot(alpha=0.5) +
        ggplot2::theme_minimal() +
        ggplot2::theme(legend.position='none')
    }

    ret = list(summary_stats=sum_tab, decomp=decomp, eta_sq=eta_sq, plot=myplot)
  }

  return(ret)
}
