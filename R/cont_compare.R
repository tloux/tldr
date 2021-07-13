
#' Compare a numerical variable across levels of a categorical variable
#'
#' Deprecated. Use `\code{\link{num_compare}}` instead.
#'
#' @param y A numerical variable
#' @param grp A categorical variable
#' @param plot Type of plot to produce
#'
#' @export

cont_compare = function(y, grp, plot=c('density','boxplot','none')){

  .Deprecated("num_compare")

  mydat = data.frame(grp=as.character(grp), y)

  # group-wise summary statistics

  grps = sort(unique(mydat$grp))

  sum_tab = t(sapply(grps, function(g) summary(mydat$y[mydat$grp==g])))
  rownames(sum_tab) = grps

  # ANOVA

  decomp = stats::aov(y ~ grp, data=mydat)

  # eta-squared

  sumdecomp = summary(decomp)
  eta_sq = sumdecomp[[1]]$`Sum Sq`[1] / sum(sumdecomp[[1]]$`Sum Sq`)

  # plot

  plot = plot[1]

  if(plot == 'none'){
    ret = list(summary_stats=sum_tab, anova=decomp, eta_sq=eta_sq)

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

    ret = list(summary_stats=sum_tab, anova=decomp, eta_sq=eta_sq, plot=myplot)
  }

  return(ret)
}
