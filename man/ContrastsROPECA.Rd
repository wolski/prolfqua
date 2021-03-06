% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/tidyMS_R6Contrast.R
\name{ContrastsROPECA}
\alias{ContrastsROPECA}
\title{ROPECA reproducibility-optimization method}
\description{
ROPECA reproducibility-optimization method

ROPECA reproducibility-optimization method
}
\details{
ROPECA optimizes the reproducibility of statistical testing
 on peptide-level and aggregates the peptide-level changes
  to determine differential protein-level expression.
}
\examples{

istar <- prolfqua::data_ionstar$normalized()
istar_data <- dplyr::filter(istar$data ,protein_Id \%in\% sample(protein_Id, 100))
modelFunction <-
  strategy_lm("transformedIntensity  ~ dilution.")
pepIntensity <- istar_data
config <- istar$config$clone(deep = TRUE)
config$table$hierarchyDepth <- 2
config$table$hkeysDepth()

mod <- build_model(
 pepIntensity,
 modelFunction,
 subject_Id = config$table$hkeysDepth())

 Contr <- c("dil.b_vs_a" = "dilution.a - dilution.b")


 contr <- prolfqua::Contrasts$new(mod, Contr)
 dim(contr$get_contrasts())
 contrM <- prolfqua::ContrastsModerated$new(contr)
 dim(contrM$get_contrasts())
 contrast <- prolfqua::ContrastsROPECA$new(contrM)
 contrast$get_contrasts()
 #ContrastsROPECA$debug("to_wide")
 contrast <- prolfqua::ContrastsROPECA$new(contr)
 tmp <- contrast$get_contrasts()
 dim(tmp)
 pl <- contrast$get_Plotter()
 contrast$to_wide()
 pl$histogram()
 pl$ma_plot()

}
\seealso{
\code{\link{summary_ROPECA_median_p.scaled}}

Other modelling: 
\code{\link{ContrastsModerated}},
\code{\link{ContrastsSimpleImpute}},
\code{\link{ContrastsTable}},
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
\item \href{#method-new}{\code{ContrastsROPECA$new()}}
\item \href{#method-get_contrasts_sides}{\code{ContrastsROPECA$get_contrasts_sides()}}
\item \href{#method-get_linfct}{\code{ContrastsROPECA$get_linfct()}}
\item \href{#method-get_contrasts}{\code{ContrastsROPECA$get_contrasts()}}
\item \href{#method-get_Plotter}{\code{ContrastsROPECA$get_Plotter()}}
\item \href{#method-to_wide}{\code{ContrastsROPECA$to_wide()}}
\item \href{#method-write}{\code{ContrastsROPECA$write()}}
\item \href{#method-clone}{\code{ContrastsROPECA$clone()}}
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-new"></a>}}
\if{latex}{\out{\hypertarget{method-new}{}}}
\subsection{Method \code{new()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{ContrastsROPECA$new(
  Contrast,
  modelName = "ROPECA",
  p.adjust = prolfqua::adjust_p_values
)}\if{html}{\out{</div>}}
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-get_contrasts_sides"></a>}}
\if{latex}{\out{\hypertarget{method-get_contrasts_sides}{}}}
\subsection{Method \code{get_contrasts_sides()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{ContrastsROPECA$get_contrasts_sides()}\if{html}{\out{</div>}}
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-get_linfct"></a>}}
\if{latex}{\out{\hypertarget{method-get_linfct}{}}}
\subsection{Method \code{get_linfct()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{ContrastsROPECA$get_linfct()}\if{html}{\out{</div>}}
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-get_contrasts"></a>}}
\if{latex}{\out{\hypertarget{method-get_contrasts}{}}}
\subsection{Method \code{get_contrasts()}}{
get contrasts
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{ContrastsROPECA$get_contrasts(all = FALSE)}\if{html}{\out{</div>}}
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
\if{html}{\out{<div class="r">}}\preformatted{ContrastsROPECA$get_Plotter()}\if{html}{\out{</div>}}
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-to_wide"></a>}}
\if{latex}{\out{\hypertarget{method-to_wide}{}}}
\subsection{Method \code{to_wide()}}{
convert to wide format
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{ContrastsROPECA$to_wide(
  columns = c("beta.based.significance", "FDR.beta.based.significance")
)}\if{html}{\out{</div>}}
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
\if{html}{\out{<div class="r">}}\preformatted{ContrastsROPECA$write(path, filename, format = "xlsx")}\if{html}{\out{</div>}}
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
\if{html}{\out{<div class="r">}}\preformatted{ContrastsROPECA$clone(deep = FALSE)}\if{html}{\out{</div>}}
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
