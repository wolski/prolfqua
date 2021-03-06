% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/tidyMS_R6_AnalysisConfiguration.R
\name{setup_analysis}
\alias{setup_analysis}
\title{Extracts columns relevant for a configuration from a data frame
and create new columns i sampleName column etc.}
\usage{
setup_analysis(data, configuration, cc = TRUE)
}
\arguments{
\item{data}{data.frame}

\item{cc}{complete cases default TRUE}

\item{config}{AnlalysisConfiguration}
}
\description{
Extracts columns relevant for a configuration from a data frame
and create new columns i sampleName column etc.
}
\examples{


skylineconfig <- create_config_Skyline(isotopeLabel = "Isotope.Label.Type",
 ident_qValue = "Detection.Q.Value")
skylineconfig$table$factors[["Time"]] = "Sampling.Time.Point"

sample_analysis <- setup_analysis(prolfqua::data_skylinePRMSample_A$data, skylineconfig)

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
\code{\link{spreadValueVarsIsotopeLabel}()},
\code{\link{table_factors}()}
}
\concept{configuration}
\keyword{internal}
