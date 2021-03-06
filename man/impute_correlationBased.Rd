% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/tidyMS_R6_TransitionCorrelations.R
\name{impute_correlationBased}
\alias{impute_correlationBased}
\title{imputation based on correlation assumption}
\usage{
impute_correlationBased(x, config)
}
\description{
imputation based on correlation assumption
}
\examples{
library(prolfqua)
library(tidyverse)

bb <- prolfqua::data_ionstar$normalized()
config <- bb$config$clone(deep=TRUE)
data <- bb$data
mean(is.na(data$peptide.intensity))
dataI <- impute_correlationBased(data, config)
dim(dataI)
stopifnot(dim(dataI) == c(dim(data)+c(0,1)))
stopifnot(mean(is.na(dataI$srm_ImputedIntensity)) <= mean(is.na(data$peptide.intensity)))

}
\keyword{internal}
