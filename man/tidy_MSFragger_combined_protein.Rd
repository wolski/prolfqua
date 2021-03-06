% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/tidyMSFragger.R
\name{tidy_MSFragger_combined_protein}
\alias{tidy_MSFragger_combined_protein}
\title{read MSFragger combined protein file}
\usage{
tidy_MSFragger_combined_protein(combprot)
}
\description{
read MSFragger combined protein file
}
\examples{

if(FALSE){
  unzip(inputMQfile, list = TRUE)$Name
  protein <- as_tibble(read.csv(unz(inputMQfile,"IonstarWithMSFragger/combined_protein.tsv"),
                                header = TRUE, sep = "\t", stringsAsFactors = FALSE))
  tidy_MSFragger_combined_protein(protein)
}

}
\seealso{
Other MSFragger: 
\code{\link{INTERNAL_FUNCTIONS_BY_FAMILY}},
\code{\link{tidy_MSFragger_MSstats_csv}()}
}
\concept{MSFragger}
\keyword{internal}
