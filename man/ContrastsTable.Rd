% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/tidyMS_R6Contrast.R
\name{ContrastsTable}
\alias{ContrastsTable}
\title{ContrastTable (place holder future baseclass?)}
\description{
ContrastTable (place holder future baseclass?)

ContrastTable (place holder future baseclass?)
}
\examples{

library(prolfqua)
library(tidyverse)
bb <- prolfqua::data_ionstar$normalized()
configur <- bb$config$clone(deep=TRUE)
configur$table$hierarchyDepth <- 2
data <- bb$data
lfqdata <- LFQData$new(data, configur)
Contrasts <- c("dilution.b-a" = "dilution.b - dilution.a",
"dilution.c-e" = "dilution.c - dilution.b")
tmp <- ContrastsSimpleImpute$new(lfqdata, contrasts = Contrasts)
ctr <- tmp$get_contrasts()
xcx <- ContrastsTable$new(ctr, subject_Id = tmp$subject_Id, modelName = tmp$modelName)
xcx$get_Plotter()$volcano()

}
\seealso{
\code{\link{summary_ROPECA_median_p.scaled}}

Other modelling: 
\code{\link{ContrastsModerated}},
\code{\link{ContrastsROPECA}},
\code{\link{ContrastsSimpleImpute}},
\code{\link{Contrasts_Plotter}},
\code{\link{Contrasts}},
\code{\link{INTERNAL_FUNCTIONS_BY_FAMILY}},
\code{\link{LR_test}()},
\code{\link{Model}},
\code{\link{addContrastResults}()},
\code{\link{build_model}()},
\code{\link{get_complete_model_fit}()},
\code{\link{get_imputed_contrasts}()},
\code{\link{get_model_coefficients}()},
\code{\link{get_p_values_pbeta}()},
\code{\link{isSingular_lm}()},
\code{\link{linfct_all_possible_contrasts}()},
\code{\link{linfct_factors_contrasts}()},
\code{\link{linfct_from_model}()},
\code{\link{linfct_matrix_contrasts}()},
\code{\link{model_analyse}()},
\code{\link{moderated_p_limma_long}()},
\code{\link{moderated_p_limma}()},
\code{\link{my_contest}()},
\code{\link{my_contrast_V1}()},
\code{\link{my_contrast_V2}()},
\code{\link{my_contrast}()},
\code{\link{my_glht}()},
\code{\link{pivot_model_contrasts_2_Wide}()},
\code{\link{plot_lmer_model_and_data_TWO}()},
\code{\link{plot_lmer_model_and_data}()},
\code{\link{plot_lmer_peptide_noRandom_TWO}()},
\code{\link{plot_lmer_peptide_noRandom}()},
\code{\link{plot_lmer_peptide_predictions}()},
\code{\link{plot_lmer_predicted_interactions}()},
\code{\link{strategy_glm}()},
\code{\link{strategy_lmer}()},
\code{\link{strategy_lm}()},
\code{\link{summary_ROPECA_median_p.scaled}()}
}
\concept{modelling}
\section{Methods}{
\subsection{Public methods}{
\itemize{
\item \href{#method-new}{\code{ContrastsTable$new()}}
\item \href{#method-get_contrasts_sides}{\code{ContrastsTable$get_contrasts_sides()}}
\item \href{#method-get_linfct}{\code{ContrastsTable$get_linfct()}}
\item \href{#method-get_contrasts}{\code{ContrastsTable$get_contrasts()}}
\item \href{#method-get_Plotter}{\code{ContrastsTable$get_Plotter()}}
\item \href{#method-to_wide}{\code{ContrastsTable$to_wide()}}
\item \href{#method-write}{\code{ContrastsTable$write()}}
\item \href{#method-clone}{\code{ContrastsTable$clone()}}
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-new"></a>}}
\if{latex}{\out{\hypertarget{method-new}{}}}
\subsection{Method \code{new()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{ContrastsTable$new(
  contrastsdf,
  subject_Id = "protein_Id",
  modelName = "ContrastTable"
)}\if{html}{\out{</div>}}
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-get_contrasts_sides"></a>}}
\if{latex}{\out{\hypertarget{method-get_contrasts_sides}{}}}
\subsection{Method \code{get_contrasts_sides()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{ContrastsTable$get_contrasts_sides()}\if{html}{\out{</div>}}
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-get_linfct"></a>}}
\if{latex}{\out{\hypertarget{method-get_linfct}{}}}
\subsection{Method \code{get_linfct()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{ContrastsTable$get_linfct()}\if{html}{\out{</div>}}
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-get_contrasts"></a>}}
\if{latex}{\out{\hypertarget{method-get_contrasts}{}}}
\subsection{Method \code{get_contrasts()}}{
get contrasts
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{ContrastsTable$get_contrasts(all = FALSE)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{all}}{should all columns be returned (default FALSE)}

\item{\code{global}}{use a global linear function (determined by get_linfct)}
}
\if{html}{\out{</div>}}
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-get_Plotter"></a>}}
\if{latex}{\out{\hypertarget{method-get_Plotter}{}}}
\subsection{Method \code{get_Plotter()}}{
get \code{\link{Contrast_Plotter}}
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{ContrastsTable$get_Plotter()}\if{html}{\out{</div>}}
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-to_wide"></a>}}
\if{latex}{\out{\hypertarget{method-to_wide}{}}}
\subsection{Method \code{to_wide()}}{
convert to wide format
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{ContrastsTable$to_wide(columns = c("p.value", "FDR"))}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{columns}}{value column default beta.based.significance}
}
\if{html}{\out{</div>}}
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-write"></a>}}
\if{latex}{\out{\hypertarget{method-write}{}}}
\subsection{Method \code{write()}}{
write results
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{ContrastsTable$write(path, filename, format = "xlsx")}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{path}}{directory}

\item{\code{format}}{default xlsx \code{\link{lfq_write_table}}}
}
\if{html}{\out{</div>}}
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-clone"></a>}}
\if{latex}{\out{\hypertarget{method-clone}{}}}
\subsection{Method \code{clone()}}{
The objects of this class are cloneable with this method.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{ContrastsTable$clone(deep = FALSE)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{deep}}{Whether to make a deep clone.}
}
\if{html}{\out{</div>}}
}
}
}
