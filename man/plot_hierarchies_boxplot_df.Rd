% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/tidyMS_plotting.R
\name{plot_hierarchies_boxplot_df}
\alias{plot_hierarchies_boxplot_df}
\title{generates peptide level plots for all Proteins}
\usage{
plot_hierarchies_boxplot_df(
  pdata,
  config,
  hierarchy = config$table$hkeysDepth(),
  facet_grid_on = NULL
)
}
\arguments{
\item{pdata}{data.frame}

\item{config}{AnalysisConfiguration}

\item{facet_grid_on}{default NULL}

\item{hiearchy}{e.g. protein_Id default hkeysDepth}
}
\description{
generates peptide level plots for all Proteins
}
\examples{

 iostar <- prolfqua::data_ionstar$filtered()
 iostar$data <- iostar$data \%>\%
   dplyr::filter(protein_Id \%in\% sample(protein_Id, 2))
 unique(iostar$data$protein_Id)

 res <- plot_hierarchies_boxplot_df(iostar$data,iostar$config)
 res$boxplot[[1]]
 res <- plot_hierarchies_boxplot_df(iostar$data,iostar$config,iostar$config$table$hierarchyKeys()[1])
 res$boxplot[[1]]
 res <- plot_hierarchies_boxplot_df(iostar$data,iostar$config,
                                    iostar$config$table$hierarchyKeys()[1],
                                    facet_grid_on = iostar$config$table$hierarchyKeys()[2])
 res$boxplot[[1]]

 iostar <- prolfqua::data_IonstarProtein_subsetNorm
 iostar$data <- iostar$data \%>\%
   dplyr::filter(protein_Id \%in\% sample(protein_Id, 100))
 unique(iostar$data$protein_Id)

 res <- plot_hierarchies_boxplot_df(iostar$data,iostar$config)
 res$boxplot[[1]]
 res <- plot_hierarchies_boxplot_df(iostar$data,iostar$config,
                                    iostar$config$table$hierarchyKeys()[1])
 res$boxplot[[1]]
 res <- plot_hierarchies_boxplot_df(iostar$data,iostar$config,
                                    iostar$config$table$hierarchyKeys()[1],
                                    facet_grid_on = iostar$config$table$hierarchyKeys()[2])
 res$boxplot[[1]]
}
\seealso{
Other plotting: 
\code{\link{Contrasts_Plotter}},
\code{\link{INTERNAL_FUNCTIONS_BY_FAMILY}},
\code{\link{medpolishPlydf}()},
\code{\link{missigness_histogram}()},
\code{\link{missingness_per_condition_cumsum}()},
\code{\link{missingness_per_condition}()},
\code{\link{plot_NA_heatmap}()},
\code{\link{plot_aggregation}()},
\code{\link{plot_heatmap_cor}()},
\code{\link{plot_heatmap}()},
\code{\link{plot_hierarchies_add_quantline}()},
\code{\link{plot_hierarchies_line_df}()},
\code{\link{plot_hierarchies_line}()},
\code{\link{plot_intensity_distribution_violin}()},
\code{\link{plot_pca}()},
\code{\link{plot_raster}()},
\code{\link{plot_sample_correlation}()}
}
\concept{plotting}
\keyword{internal}
