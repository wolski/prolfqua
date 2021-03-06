% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/tidyMS_R6_AnalysisConfiguration.R
\name{spreadValueVarsIsotopeLabel}
\alias{spreadValueVarsIsotopeLabel}
\title{spreads isotope label heavy light into two columns}
\usage{
spreadValueVarsIsotopeLabel(resData, config)
}
\description{
spreads isotope label heavy light into two columns
}
\examples{
library(prolfqua)

bb <- prolfqua::data_ionstar$filtered()
stopifnot(nrow(bb$data) == 25780)
configur <- bb$config$clone(deep=TRUE)
data <- bb$data

x<-spreadValueVarsIsotopeLabel(data,configur)
head(x)

bb <- prolfqua::data_skylineSRM_HL_A
configur <- bb$config_f()
data <- bb$analysis(bb$data, configur)

bb <- prolfqua::data_skylineSRM_HL_A
conf <- bb$config_f()
analysis <- bb$analysis(bb$data, bb$config_f())
x <- spreadValueVarsIsotopeLabel(analysis, conf)
head(x[,5:ncol(x)])

}
\seealso{
Other configuration: 
\code{\link{AnalysisConfiguration}},
\code{\link{AnalysisParameters}},
\code{\link{AnalysisTableAnnotation}},
\code{\link{INTERNAL_FUNCTIONS_BY_FAMILY}},
\code{\link{R6extractValues}()},
\code{\link{complete_cases}()},
\code{\link{make_interaction_column}()},
\code{\link{make_reduced_hierarchy_config}()},
\code{\link{sample_subset}()},
\code{\link{separate_factors}()},
\code{\link{separate_hierarchy}()},
\code{\link{setup_analysis}()},
\code{\link{table_factors}()}
}
\concept{configuration}
\keyword{internal}
