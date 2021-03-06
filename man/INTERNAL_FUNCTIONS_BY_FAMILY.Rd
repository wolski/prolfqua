% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/A_dataset_docu.R
\name{INTERNAL_FUNCTIONS_BY_FAMILY}
\alias{INTERNAL_FUNCTIONS_BY_FAMILY}
\title{Internal Functions by category}
\description{
Internal Functions by category
}
\seealso{
Other configuration: 
\code{\link{AnalysisConfiguration}},
\code{\link{AnalysisParameters}},
\code{\link{AnalysisTableAnnotation}},
\code{\link{R6extractValues}()},
\code{\link{complete_cases}()},
\code{\link{make_interaction_column}()},
\code{\link{make_reduced_hierarchy_config}()},
\code{\link{sample_subset}()},
\code{\link{separate_factors}()},
\code{\link{separate_hierarchy}()},
\code{\link{setup_analysis}()},
\code{\link{spreadValueVarsIsotopeLabel}()},
\code{\link{table_factors}()}

Other concrete_configuration: 
\code{\link{create_config_MQ_peptide}()},
\code{\link{create_config_MSFragger_MSstats}()},
\code{\link{create_config_Skyline}()},
\code{\link{create_config_Spectronaut_Peptide}()}

Other summary: 
\code{\link{hierarchy_counts_sample}()},
\code{\link{hierarchy_counts}()},
\code{\link{nr_B_in_A_per_sample}()},
\code{\link{summarize_hierarchy}()}

Other aggregation: 
\code{\link{aggregateTopNIntensities}()},
\code{\link{aggregate_intensity}()},
\code{\link{intensity_summary_by_hkeys}()},
\code{\link{medpolishPlydf_config}()},
\code{\link{medpolishPlydf}()},
\code{\link{medpolishPly}()},
\code{\link{medpolish_protein_quants}()},
\code{\link{plot_aggregation}()},
\code{\link{plot_hierarchies_add_quantline}()},
\code{\link{plot_hierarchies_line_df}()},
\code{\link{plot_hierarchies_line}()},
\code{\link{summarizeRobust_config}()},
\code{\link{summarizeRobust}()}

Other plotting: 
\code{\link{Contrasts_Plotter}},
\code{\link{medpolishPlydf}()},
\code{\link{missigness_histogram}()},
\code{\link{missingness_per_condition_cumsum}()},
\code{\link{missingness_per_condition}()},
\code{\link{plot_NA_heatmap}()},
\code{\link{plot_aggregation}()},
\code{\link{plot_heatmap_cor}()},
\code{\link{plot_heatmap}()},
\code{\link{plot_hierarchies_add_quantline}()},
\code{\link{plot_hierarchies_boxplot_df}()},
\code{\link{plot_hierarchies_line_df}()},
\code{\link{plot_hierarchies_line}()},
\code{\link{plot_intensity_distribution_violin}()},
\code{\link{plot_pca}()},
\code{\link{plot_raster}()},
\code{\link{plot_sample_correlation}()}

Other utilities: 
\code{\link{get_UniprotID_from_fasta_header}()},
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

Other modelling: 
\code{\link{ContrastsModerated}},
\code{\link{ContrastsROPECA}},
\code{\link{ContrastsSimpleImpute}},
\code{\link{ContrastsTable}},
\code{\link{Contrasts_Plotter}},
\code{\link{Contrasts}},
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

Other workflows: 
\code{\link{workflow_DIA_NA_preprocessing}()},
\code{\link{workflow_corr_filter_impute}()},
\code{\link{workflow_correlation_preprocessing_protein_intensities}()}

Other vignetteHelpers: 
\code{\link{render_MQSummary_rmd}()},
\code{\link{render_SummarizeFiltering_rmd}()}

Other deprecated: 
\code{\link{compute_roc}()},
\code{\link{intensity_summary_by_hkeys}()},
\code{\link{medpolish_protein_quants}()},
\code{\link{workflow_DIA_NA_preprocessing}()},
\code{\link{workflow_correlation_preprocessing_protein_intensities}()}

Other preprocessing: 
\code{\link{filter_proteins_by_peptide_count}()},
\code{\link{normalize_log2_robscale}()}

Other benchmarking: 
\code{\link{Benchmark}},
\code{\link{ionstar_bench_preprocess}()},
\code{\link{ms_bench_auc}()}

Other MaxQuant: 
\code{\link{plot_MQ_intensity_vs_retention_time}()},
\code{\link{tidyMQ_Evidence}()},
\code{\link{tidyMQ_PeptideProtein}()},
\code{\link{tidyMQ_Peptides}()},
\code{\link{tidyMQ_ProteinGroups}()},
\code{\link{tidyMQ_allPeptides}()},
\code{\link{tidyMQ_from_Sites}()},
\code{\link{tidyMQ_from_modSpecific_to_peptide}()},
\code{\link{tidyMQ_merged}()},
\code{\link{tidyMQ_modificationSpecificPeptides}()},
\code{\link{tidyMQ_top_protein_name}()}

Other MSFragger: 
\code{\link{tidy_MSFragger_MSstats_csv}()},
\code{\link{tidy_MSFragger_combined_protein}()}

Other stats: 
\code{\link{compute_pooled}()},
\code{\link{lfq_power_t_test_proteins}()},
\code{\link{lfq_power_t_test_quantiles_V2}()},
\code{\link{lfq_power_t_test_quantiles}()},
\code{\link{plot_stat_density_median}()},
\code{\link{plot_stat_density}()},
\code{\link{plot_stat_violin_median}()},
\code{\link{plot_stat_violin}()},
\code{\link{plot_stdv_vs_mean}()},
\code{\link{poolvar}()},
\code{\link{summarize_stats_all}()},
\code{\link{summarize_stats_quantiles}()},
\code{\link{summarize_stats}()}
}
\concept{MSFragger}
\concept{MaxQuant}
\concept{aggregation}
\concept{benchmarking}
\concept{concrete_configuration}
\concept{configuration}
\concept{deprecated}
\concept{modelling}
\concept{plotting}
\concept{preprocessing}
\concept{stats}
\concept{summary}
\concept{transitionCorrelation}
\concept{utilities}
\concept{vignetteHelpers}
\concept{workflows}
