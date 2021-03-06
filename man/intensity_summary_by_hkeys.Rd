% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/tidyMS_aggregation.R
\name{intensity_summary_by_hkeys}
\alias{intensity_summary_by_hkeys}
\title{Summarizes the intensities within hierarchy}
\usage{
intensity_summary_by_hkeys(data, config, func)
}
\arguments{
\item{func}{- a function working on a matrix of intensities for each protein.}
}
\value{
retuns function object
}
\description{
Summarizes the intensities within hierarchy
}
\examples{

library(prolfqua)
library(tidyverse)
bb <- prolfqua::data_ionstar$filtered()
stopifnot(nrow(bb$data) == 25780)
config <- bb$config$clone(deep = TRUE)
data <- bb$data
x <- intensity_summary_by_hkeys(data, config, func = medpolishPly)

res <- x("unnest")
x("unnest")$data \%>\% dplyr::select(config$table$hierarchyKeys()[1] , "medpolish")
config <- bb$config$clone(deep = TRUE)
config$table$hierarchyDepth <- 1
x <- intensity_summary_by_hkeys(data, config, func = medpolishPly)

x("unnest")$data
xnested <- x()
dd <- x(value = "plot")

dd$medpolishPly[[1]]

dd$plot[[2]]

# example how to add peptide count information

tmp <- summarize_hierarchy(data, config)
tmp <- inner_join(tmp, x("wide")$data, by = config$table$hkeysDepth())

}
\seealso{
Other aggregation: 
\code{\link{INTERNAL_FUNCTIONS_BY_FAMILY}},
\code{\link{aggregateTopNIntensities}()},
\code{\link{aggregate_intensity}()},
\code{\link{medpolishPlydf_config}()},
\code{\link{medpolishPlydf}()},
\code{\link{medpolishPly}()},
\code{\link{medpolish_protein_quants}()},
\code{\link{plot_aggregation}()},
\code{\link{plot_hierarchies_add_quantline}()},
\code{\link{plot_hierarchies_line_df}()},
\code{\link{plot_hierarchies_line}()},
\code{\link{summarizeRobust_config}()},
\code{\link{summarizeRobust}()}

Other deprecated: 
\code{\link{INTERNAL_FUNCTIONS_BY_FAMILY}},
\code{\link{compute_roc}()},
\code{\link{medpolish_protein_quants}()},
\code{\link{workflow_DIA_NA_preprocessing}()},
\code{\link{workflow_correlation_preprocessing_protein_intensities}()}
}
\concept{aggregation}
\concept{deprecated}
\keyword{internal}
