% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/utilities.R
\name{get_UniprotID_from_fasta_header}
\alias{get_UniprotID_from_fasta_header}
\title{Extracts uniprot ID}
\usage{
get_UniprotID_from_fasta_header(df, idcolumn = "protein_Id")
}
\arguments{
\item{obj}{data.frame}

\item{idcol}{columns to extrac uniprot id's from}
}
\value{
data.frame
}
\description{
Extracts uniprot ID
}
\seealso{
Other utilities: 
\code{\link{INTERNAL_FUNCTIONS_BY_FAMILY}},
\code{\link{jackknifeMatrix}()},
\code{\link{matrix_to_tibble}()},
\code{\link{multigroupVolcano}()},
\code{\link{my_jackknife}()},
\code{\link{pairs_smooth}()},
\code{\link{pairs_w_abline}()},
\code{\link{panel.cor}()},
\code{\link{panel.hist}()},
\code{\link{removeNArows}()},
\code{\link{split2table}()},
\code{\link{table_facade.list}()},
\code{\link{table_facade}()}
}
\concept{utilities}
\keyword{internal}
