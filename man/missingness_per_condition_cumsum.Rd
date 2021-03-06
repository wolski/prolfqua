% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/tidyMS_missigness.R
\name{missingness_per_condition_cumsum}
\alias{missingness_per_condition_cumsum}
\title{cumulative sums of missing}
\usage{
missingness_per_condition_cumsum(
  x,
  config,
  factors = config$table$fkeysDepth()
)
}
\description{
cumulative sums of missing
}
\examples{


bb <- prolfqua::data_ionstar$filtered()
stopifnot(nrow(bb$data) == 25780)
configur <- bb$config$clone(deep=TRUE)
data <- bb$data

res <- missingness_per_condition_cumsum(data,configur)
stopifnot("ggplot" \%in\% class(res$figure))
print(res$figure)
res$data
}
\seealso{
Other plotting: 
\code{\link{Contrasts_Plotter}},
\code{\link{INTERNAL_FUNCTIONS_BY_FAMILY}},
\code{\link{medpolishPlydf}()},
\code{\link{missigness_histogram}()},
\code{\link{missingness_per_condition}()},
\code{\link{plot_NA_heatmap}()},
\code{\link{plot_aggregation}()},
\code{\link{plot_heatmap_cor}()},
\code{\link{plot_heatmap}()},
\code{\link{plot_hierarchies_add_quantline}()},
\code{\link{plot_hierarchies_boxplot_df}()},
\code{\link{plot_hierarchies_line_df}()},
\code{\link{plot_hierarchies_line}()},
\code{\link{plot_intensity_distribution_violin}()},
\code{\link{plot_pca}()},
\code{\link{plot_raster}()},
\code{\link{plot_sample_correlation}()}

Other imputation: 
\code{\link{aggregate_contrast}()},
\code{\link{get_contrast}()},
\code{\link{missigness_histogram}()},
\code{\link{missigness_impute_factors_interactions}()},
\code{\link{missingness_per_condition}()}
}
\concept{imputation}
\concept{plotting}
\keyword{internal}
