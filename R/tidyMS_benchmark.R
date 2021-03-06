#' prepare benchmark data
#' @export
#' @family benchmarking
#' @param data analysis results
ionstar_bench_preprocess <- function(data, idcol = "protein_Id") {
  tmp <- data %>%
    ungroup() %>%
    mutate(species  = case_when(
      grepl("HUMAN", !!sym(idcol)) ~ "HUMAN",
      grepl("ECOLI", !!sym(idcol)) ~ "ECOLI",
      TRUE ~ "OTHER"
    ))
  res <- tmp %>% dplyr::filter(!.data$species == "OTHER")
  res <- res %>% mutate(TP = (.data$species == "ECOLI"))
  return(list(data = res , table = table(tmp$species)))
}


# adds FDR, TPR and FDP to data.
# @param data
# @param TP_col column name of TP (TRUE, FALSE)
# @param arrangeby - by which column to sort.
# @param desc  descending or ascending.
# FDP - false discovery proportion (Q in Benjamini Hochberg table)
# FPR - false positive rate
# TPR - true positive rate
# TP_hits - true positives
#
.ms_bench_add_FPRTPR <- function(data,
                                 TP_col = "TP",
                                 arrangeby = "estimate",
                                 desc = TRUE) {
  #data <- est

  data <- if (!desc) {
    data %>% arrange(!!sym(arrangeby))
  } else{
    data %>% arrange(desc(!!sym(arrangeby)))
  }
  data <- data %>% select(scorecol = !!sym(arrangeby) , !!sym(TP_col))
  data$what <- arrangeby

  if (TRUE) { # drop missing so that TPR goes up to 1.
    data <- na.omit(data)
    data$F_ <- sum(!data$TP)
    data$T_ <- sum(data$TP)
  }else{
    data$F_ <- sum(!data$TP)
    data$T_ <- sum(data$TP)
    data <- na.omit(data)
  }



  data <- data %>% mutate(
    R = 1:dplyr::n()
    , FDP = dplyr::cummean(!.data$TP)
    , TP_hits = cumsum(.data$TP)
    , FN_hits = .data$T_ - .data$TP_hits
    , FP_hits = cumsum(!.data$TP)
    , TN_hits = .data$F_ - .data$FP_hits
    , FPR = .data$FP_hits / .data$F_
    , TPR  = .data$TP_hits / .data$T_
    , ACC = (.data$TP_hits + .data$TN_hits) / (.data$T_ + .data$F_)
    , FDP_ = .data$FDP * 1/max(.data$FDP)
  ) %>% ungroup
  return(data)
}


#' computes auc and pauc given output from ms_bench_add_FPRTPR
#' using trapez rule
#' @keywords internal
#' @family benchmarking
#' @export
#' @param FPR array of FPR
#' @param TPR array of corresponding TPR
#' @param fpr_threshold default = 1
#'
ms_bench_auc <- function(FPR, TPR, fpr_threshold = 1) {
  # make sure that sorted.
  oFPR <- order(FPR)
  FPR <- FPR[oFPR]
  TPR <- TPR[oFPR]

  idx <- FPR < fpr_threshold
  TPR <- TPR[idx]
  FPR <- FPR[idx]
  #integrate
  res <- 1 / 2 * sum(diff(FPR) * (head(TPR,-1) + tail(TPR,-1)))
  return(res / fpr_threshold * 100)
}


# scale_probabilities
# @param toscale columns to scale
# @param estimate fold change column
.scale_probabilities <-
  function(est ,toscale , fcestimate = "estimate") {
    addScaledP <- function(data , fcestimate , scale) {
      scaled.p = paste0("scaled.", scale)
      data <-
        data %>% dplyr::mutate(!!scaled.p := ifelse(!!sym(fcestimate) > 0,
                                                    1 - !!sym(scale) , !!sym(scale) - 1))
      return(data)
    }

    for (scale in toscale) {
      message(scale)
      est <- addScaledP(est, fcestimate = fcestimate , scale = scale)
    }
    return(est)
  }


# do_confusion
do_confusion <-
  function(data,
           arrangeby = list(list(sc = "estimate", desc = TRUE),
                            list(sc = "statistic", desc = TRUE),
                            list(sc = "scaled.p.value" , desc = TRUE))) {
    # TODO add to prolfqua
    est <- data %>% ungroup %>%
      dplyr::select_at(c("TP",
                         purrr::map_chr(arrangeby, "sc")))
    res <- list()
    for (arrange in arrangeby) {
      score <- arrange$sc
      res[[score]] <-
        .ms_bench_add_FPRTPR(est,
                             TP_col = "TP",
                             arrangeby = score,
                             desc = arrange$desc)
    }
    all <- bind_rows(res)
    return(all)
  }

# do_confusion for each contrast
do_confusion_c <- function(
  data,
  contrast = "contrast",
  arrangeby = list(list(sc = "scaled.p.value", desc = FALSE))) {

  txx <- data %>% group_by_at(contrast) %>% nest()
  txx <- txx %>% mutate(out  = map(data,
                                   do_confusion,
                                   arrangeby = arrangeby))
  xx <- txx  %>% select_at(c(contrast, "out")) %>%
    unnest("out") %>%
    ungroup()

  # computes FDR FDP for all contrasts
  xy <- do_confusion(data, arrangeby = arrangeby)
  xy <- xy %>% dplyr::mutate(!!contrast := "all")
  #xy <- tibble::add_column(data, contrast = "all", .before = 1)
  xx <- dplyr::bind_rows(xy, xx)
  return(xx)
}

.plot_FDPvsTPR <- function(pStats, xlim, contrast = "contrast"){
  p1 <-
    ggplot(pStats , ggplot2::aes(x = .data$FDP, y = .data$TPR, color = .data$what)) +
    ggplot2::geom_path()  +
    ggplot2::labs(tag = "C") + xlim(0, xlim) +
    ggplot2::facet_wrap(as.formula(paste0("~",contrast )))
  return(p1)
}

# Visualizes data frame with columns FPR, TPR, FDP
.plot_ROC <-
  function(pStats, fpr_lim = 0.2, contrast= "contrast") {
    p2 <-
      ggplot(pStats , aes(x = FPR, y = TPR, color = what)) +
      geom_path()  +
      xlim(0, xlim = fpr_lim) +
      facet_wrap( as.formula(paste0("~",contrast )) )

    rocp = p2
  }

.partial_AUC_summary <- function(pStats, model_description = "mixed effects model",
                                 contrast = "contrast"){
  summaryS <- pStats %>% dplyr::group_by(!!sym(contrast), .data$what) %>%
    dplyr::summarize(
      AUC = ms_bench_auc(.data$FPR, .data$TPR),
      pAUC_10 =  ms_bench_auc(.data$FPR, .data$TPR, 0.1),
      pAUC_20 = ms_bench_auc(.data$FPR, .data$TPR, 0.2)
    )

  ftable <- list(content = summaryS,
                 caption = paste0("AUC, and pAUC at 0.1 and 0.2 FPR for ", model_description),
                 digits = 2)
  # TODO replace melt
  sumd <- tidyr::pivot_longer(summaryS, cols = matches("^AUC|^pAUC"), names_to = "AUC")
  #sumd <- reshape2::melt(summaryS)
  barp <- ggplot(sumd, aes(x = !!sym(contrast) , y = .data$value,
                           color = NULL ,
                           fill = .data$what)) +
    geom_bar(stat = "identity", position = position_dodge()) +
    facet_wrap(~AUC, scales = "free") +
    theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
    coord_cartesian(ylim = c(floor(min(sumd$value) / 10) * 10, 100))

  res <- list(
    barp = barp,
    ftable = ftable)
}

# summarise_missing_contrasts
#' @examples
#' ttd <- ionstar_bench_preprocess(prolfqua::data_benchmarkExample)
#' x <- .summarise_missing_contrasts(ttd$data)
#' x2 <- as_tibble(x$summary)
#'
#debug(.summarise_missing_contrasts)
.summarise_missing_contrasts <- function(data,
                                         hierarchy = c("protein_Id"),
                                         contrast = "contrast",
                                         what = "statistic") {
  data <- tidyr::complete(
    data,
    tidyr::nesting(!!!syms(contrast)),
    tidyr::nesting(!!!syms(hierarchy))
  )

  xxA <- data |>
    group_by_at(hierarchy) |>
    summarize(n = n(), nr_na = sum(is.na(!!sym(what))))
  summary <- xxA |> group_by(nr_na) |> summarize(n = n())

  colnames(summary) <- c("nr_missing", paste(hierarchy, collapse = "_"))
  return(list(summary = summary, nr_na = xxA))
}

# plot score distributions by species
.plot_score_distribution <- function(data,
                                     score = list(list(score = "estimate",xlim = c(-1,2) ),
                                                 list(score = "statistic", xlim = c(-3,10) )),
                                     contrast = "contrast",
                                     species = "species" ,
                                     annot = "peptide level statistics density"){
  plots <- list()
  for (i in score) {
    xlim = i$xlim
    score = i$score
    plots[[score]] <- data %>% ggplot(aes(x = !!sym(score),
                                          y = !!sym(contrast),
                                          color = !!sym(species))) +
      ggridges::geom_density_ridges(alpha = 0.1) + xlim(xlim)
  }
  fig <- ggpubr::ggarrange(plotlist = plots,
                           nrow = 1,
                           common.legend = TRUE,
                           legend = "bottom")

  fig <- ggpubr::annotate_figure(fig, bottom = ggpubr::text_grob(annot, size = 10))
  return(fig)
}

# Benchmark ----
#' Benchmark R6 class
#'
#' @export
#' @family benchmarking
#' @examples
#' library(ggpubr)
#' library(prolfqua)
#' ttd <- ionstar_bench_preprocess(dplyr::filter(prolfqua::data_benchmarkExample, !is.na(statistic)))
#' medpol_benchmark <- make_benchmark(ttd$data,
#'                                    model_description = "med. polish and lm. density",
#'                                    model_name = "prot_med_lm"
#' )
#' medpol_benchmark$plot_score_distribution()
#' #Benchmark$debug("pAUC_summaries")
#' benchmark <- make_benchmark(
#'   ttd$data,
#'   toscale =  c("moderated.p.value", "moderated.p.value.adjusted"),
#'   benchmark = list(list(sc = "estimate", desc = TRUE),
#'                    list(sc = "statistic", desc = TRUE),
#'                    list(sc = "scaled.moderated.p.value", desc = TRUE),
#'                    list(sc = "scaled.moderated.p.value.adjusted", desc = TRUE)
#'   ),
#'   FDRvsFDP =
#'     list(list(sc = "moderated.p.value", desc = FALSE),
#'          list(sc = "moderated.p.value.adjusted", desc = FALSE)),
#'   model_description = "protein level measurments, lm model",
#'   model_name = "prot_lm"
#' )
#'
#' bb <- benchmark$pAUC_summaries()
#' benchmark$complete(FALSE)
#' benchmark$smc$summary
#' benchmark$plot_score_distribution()
#' bb <- benchmark$get_confusion_FDRvsFDP()
#' xb <- dplyr::filter(bb, contrast ==  "dilution_(4.5/3)_1.5")
#' bb <- benchmark$get_confusion_benchmark()
#' bb %>% group_by(what, contrast) %>% summarize(n = n())
#' benchmark$plot_ROC(xlim = 0.1)
#' benchmark$plot_FDPvsTPR()
#' benchmark$plot_FDRvsFDP()
#' benchmark$plot_scatter()
#' benchmark$complete(FALSE)
#' benchmark$pAUC_summaries()$ftable$content
#' benchmark$complete(TRUE)
#' benchmark$pAUC_summaries()$ftable$content
#'
Benchmark <-
  R6::R6Class(
    "Benchmark",
    public = list(
      #' @field .data data.frame
      .data = NULL,
      #' @field is_complete todo
      is_complete = FALSE,
      #' @field contrast column name
      contrast = "",
      #' @field toscale which columns to scale
      toscale = c(""),
      #' @field fc estimate column
      fcestimate = "",
      #' @field benchmark todo
      benchmark = list(),
      #' @field model_description describe model
      model_description = "",
      #' @field model_name model description
      model_name = "",
      #' @field hierarchy todo
      hierarchy = "",
      #' @field smc summarize missing contrasts
      smc = NULL,
      #' @field confusion todo
      confusion = NULL,
      #' @field species todo
      species = "",
      #' @field FDRvsFDP todo
      FDRvsFDP = NULL,
      #' @description
      #' create Benchmark
      #' @param data data.frame
      #' @param toscale columns ot scale
      #' @param benchmark columns to benchmark
      #' @param FDRvsFDP score for which to generate FDR vs FDP
      #' @param columns to create FPR vs FDP analysis for
      #' @param model_description describe model
      #' @param model_name model name
      #' @param contrast contrast
      #' @param species species (todo rename)
      #' @param hierarchy e.g. protein_Id
      initialize = function(data,
                            toscale = c("p.value"),
                            fcestimate = "estimate",
                            benchmark = list(
                              list(sc = "estimate", desc = TRUE),
                              list(sc = "statistic", desc = TRUE),
                              list(sc = "scaled.p.value", desc = TRUE)
                            ),
                            FDRvsFDP = list(list(sc = "FDR", desc = FALSE)),
                            model_description = "protein level measurments, linear model",
                            model_name = "medpolish_lm",
                            contrast = "contrast",
                            species = "species",
                            hierarchy = c("protein_Id"),
                            summarizeNA = "statistic") {
        self$.data <- data
        self$contrast <- contrast
        self$toscale <- toscale
        self$fcestimate <- fcestimate
        self$benchmark <- benchmark
        self$FDRvsFDP <- FDRvsFDP
        self$model_description <- model_description
        self$model_name <- model_name
        self$hierarchy <- hierarchy
        self$species <- species

        self$smc <- .summarise_missing_contrasts(self$.data,
                                                 hierarchy = hierarchy,
                                                 contrast = contrast,
                                                 what = summarizeNA)
        self$.data <- .scale_probabilities(self$.data,
                                           toscale = toscale,
                                           fcestimate = self$fcestimate)

      },
      #' @description
      #' get data
      #' @return data.frame
      data = function(){
        if (self$is_complete) {
          nr_na <- self$smc$nr_na %>% dplyr::filter(n == n - .data$nr_na)
          return(dplyr::inner_join(self$.data, nr_na, by = self$hierarchy))
        } else {
          return(self$.data)
        }
      },
      #' @description
      #' set or get complete
      #' @param value TRUE if data should be complete (no missing contrasts)
      #'
      complete = function(value){
        if (missing(value)) {
          return(self$is_complete);
        } else {
          self$is_complete = value
        }
      },
      #' @description
      #' get confusion data
      #' @param arrange todo
      .get_confusion = function(arrange){
        confusion <- prolfqua:::do_confusion_c(self$data(),
                                               contrast = self$contrast,
                                               arrangeby = arrange)
        confusion <- tibble::add_column(
          confusion ,
          model_name = self$model_name,
          .before = self$contrast)
        return(confusion)
      },
      #' @description
      #' get FDR summaries
      get_confusion_benchmark = function(){
        self$.get_confusion(arrange = self$benchmark)
      },
      #' @description nr of elements used to determine ROC curve
      #'
      n_confusion_benchmark = function(){
        bb1 <- self$get_confusion_benchmark()
        n <- bb1 %>% na.omit() |> group_by(what, contrast) |> summarise(n = n())
        return(n)
      },
      #' @description plot FDP vs TPR
      #' @param xlim limit x axis
      plot_FDPvsTPR = function(xlim = 0.5){
        confusion <- self$get_confusion_benchmark()

        p <- .plot_FDPvsTPR(confusion,
                            xlim = 0.5,
                            contrast = self$contrast)
        return(p)
      },
      #' @description
      #' plot FDR summaries
      #' @param xlim limit x axis
      #' @return ggplot
      plot_ROC = function(xlim = 0.5){
        confusion <- self$get_confusion_benchmark()
        vissum <- .plot_ROC(confusion,
                            fpr_lim = xlim,
                            contrast = self$contrast)
        return(vissum)
      },
      #' @description
      #' AUC summaries
      pAUC_summaries = function(){
        confusion <- self$get_confusion_benchmark()
        pauc <- .partial_AUC_summary(
          confusion,
          model_description = paste0(ifelse(self$complete(), " (CC) " , " (NC) "),
                                     self$model_description),
          contrast = self$contrast)
        return(pauc)
      },
      #' @description
      #' AUC summaries as table
      #'
      pAUC = function(){
        pStats <- self$get_confusion_benchmark()
        summaryS <- pStats %>% dplyr::group_by(.data$contrast, .data$what) %>%
          dplyr::summarize(
            AUC = ms_bench_auc(.data$FPR, .data$TPR),
            pAUC_10 =  ms_bench_auc(.data$FPR, .data$TPR, 0.1),
            pAUC_20 = ms_bench_auc(.data$FPR, .data$TPR, 0.2)
          )
        summaryS$Name <- self$model_name
        return(summaryS)
      },
      #' @description
      #' FDR vs FDP data
      get_confusion_FDRvsFDP = function(){
        xx <- self$.get_confusion(arrange = self$FDRvsFDP)
        return(xx)
      },
      #' @description nr of elements used to determine ROC curve
      #'
      n_confusion_FDRvsFDP = function(){
        bb1 <- self$get_confusion_FDRvsFDP()
        n <- bb1 %>% na.omit() |> group_by(what, contrast) |> summarise(n = n())
        return(n)
      },

      #' @description
      #' plot FDR vs FDP data
      #' @return ggplot
      plot_FDRvsFDP = function(){
        xx <- self$get_confusion_FDRvsFDP()
        #xx$FDP <- xx$FDP/seq(1,max(xx$FDP), length = length(xx$FDP))
        p <- ggplot(xx,
                    aes(x = scorecol,
                        y = FDP_,
                        color = !!sym(self$contrast))) +
          geom_line() +
          geom_abline(slope = max(xx$FDP_), col = 2) +
          facet_wrap(~what)
        return(p)
      },
      #' @description
      #' plot distributions of scores
      #' @param score the distribution of which scores to plot (list)
      #' @return ggplot
      plot_score_distribution = function(score =list(list(score = "estimate", xlim = c(-1,2) ),
                                                     list(score = "statistic", xlim = c(-3,10) ))){
        .plot_score_distribution(self$data(),
                                 score = score,
                                 contrast = self$contrast,
                                 species = self$species,
                                 annot = paste0("statistics density of ", self$model_description ) )
      },
      #' @description
      #' plot intensity vs scores
      #' @param score the distribution of which scores to plot (list)
      #' @return ggplot
      plot_scatter = function(score = list(list(score = "estimate", ylim = c(-1,2) ),
                                           list(score = "statistic", ylim = c(-3,10) ))){
        x <- self$data()

        x <- x %>% arrange(desc(!!sym(self$species)))
        plots <- list()

        for (i in score) {
          score <- i$score
          ylim <- i$ylim

          plots[[score]] <- x %>%
            ggplot(aes(x = (c1 + c2)/2, y = !!sym(score), color = !!sym(self$species) )) +
            geom_point(alpha = 0.2) +
            ggplot2::facet_wrap(as.formula(paste("~", self$contrast))) +
            ylim(ylim)
        }
        fig <- ggarrange(plotlist = plots,
                         nrow = 1,
                         common.legend = TRUE,
                         legend = "bottom")
        fig <- annotate_figure(fig, bottom = ggpubr::text_grob(self$model_typ , size = 10))
        return(fig)
      }

    ))


#' make Benchmark
#'
#' @export
#' @param prpr todo
#' @param contrast todo
#' @param toscale todo
#' @param benchmark todo
#' @param FDRvsFDP todo
#' @param model_description todo
#' @param model_name todo
#' @param hierarchy todo
#' @return Benchmark
make_benchmark <- function(prpr,
                           contrast = "contrast",
                           toscale = c("p.value"),
                           fcestimate = "estimate",
                           benchmark = list(
                             list(sc = "estimate", desc = TRUE),
                             list(sc = "statistic", desc = TRUE),
                             list(sc = "scaled.p.value", desc = TRUE)
                           ),
                           FDRvsFDP = list(list(sc = "FDR", desc = FALSE)),
                           model_description = "protein level measurments, linear model",
                           model_name = "prot_med_lm",
                           hierarchy = c("protein_Id"),
                           summarizeNA= "statistic"
) {
  res <- Benchmark$new(prpr,
                       contrast = contrast,
                       toscale = toscale,
                       fcestimate = fcestimate,
                       benchmark = benchmark,
                       FDRvsFDP = FDRvsFDP,
                       model_description = model_description,
                       model_name = model_name,
                       hierarchy = hierarchy,
                       summarizeNA=summarizeNA)
  return(res)
}
