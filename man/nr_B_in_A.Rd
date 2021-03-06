% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/tidyMS_R6_TransitionCorrelations.R
\name{nr_B_in_A}
\alias{nr_B_in_A}
\title{Compute nr of B per A}
\usage{
nr_B_in_A(pdata, config, merge = TRUE)
}
\arguments{
\item{pdata}{data.frame}

\item{config}{AnalysisConfiguration}
}
\description{
Compute nr of B per A
}
\examples{
library(tidyverse)
bb <- prolfqua::data_ionstar$filtered()
stopifnot(nrow(bb$data) == 25780)
config <- bb$config$clone(deep=TRUE)
data <- bb$data \%>\% select(-all_of("nr_peptide_Id_IN_protein_Id"))
hierarchy <- config$table$hierarchyKeys()
res <- nr_B_in_A(data, config)

res$data \%>\%
  dplyr::select_at(c(config$table$hkeysDepth(),  res$name)) \%>\%
  distinct() \%>\%
  dplyr::pull() \%>\% table()


bb <- prolfqua::data_skylineSRM_HL_A
config <- bb$config_f()
resDataStart <- bb$analysis(bb$data, bb$config_f())

nr_B_in_A(resDataStart, config)
nr_B_in_A(resDataStart, config, merge = FALSE)
config$table$hierarchyDepth <- 2
nr_B_in_A(resDataStart, config, merge = FALSE)

bb <- prolfqua::data_IonstarProtein_subsetNorm
nr_B_in_A(bb$data, bb$config)
undebug(nr_B_in_A)
}
\keyword{internal}
