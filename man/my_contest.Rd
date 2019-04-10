% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/tidyMS_R6_Modelling.R
\name{my_contest}
\alias{my_contest}
\title{applies contrast computation using lmerTest::contest function}
\usage{
my_contest(model, linfct)
}
\description{
applies contrast computation using lmerTest::contest function
}
\examples{
mb <- LFQService::basicModel_p1807
linfct <- lmer4_linfct_from_model(mb)
names(linfct)
lmerTest::contest(mb, linfct$linfct_interactions, joint = FALSE, confint = TRUE)
my_contest(mb, linfct$linfct_factors)
my_contest(mb, linfct$linfct_interactions)
my_glht(mb, linfct$linfct_factors)
my_glht(mb, linfct$linfct_interactions)
}