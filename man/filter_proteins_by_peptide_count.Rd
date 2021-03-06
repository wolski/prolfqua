% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/tidyMS_MQ_workflow.R
\name{filter_proteins_by_peptide_count}
\alias{filter_proteins_by_peptide_count}
\title{Keep only those proteins with 2 IDENTIFIED peptides}
\usage{
filter_proteins_by_peptide_count(pdata, config)
}
\arguments{
\item{pdata}{data.frame}

\item{config}{AnalysisConfiguration}
}
\value{
list with data.frame (data) and name of new column (name)
}
\description{
Keep only those proteins with 2 IDENTIFIED peptides
}
\examples{

library(prolfqua)
library(tidyverse)

istar <- prolfqua::data_ionstar$Pep()
istar_data <- istar$data \%>\% dplyr::filter(protein_Id \%in\% sample(protein_Id, 100))
filterPep <- prolfqua::filter_proteins_by_peptide_count( istar_data ,  istar$config )
 x <- prolfqua::summarize_hierarchy(filterPep$data , istar$config)
stopifnot(x$peptide_Id_n >= istar$config$parameter$min_peptides_protein)


}
\seealso{
Other preprocessing: 
\code{\link{INTERNAL_FUNCTIONS_BY_FAMILY}},
\code{\link{normalize_log2_robscale}()}
}
\concept{preprocessing}
\keyword{internal}
