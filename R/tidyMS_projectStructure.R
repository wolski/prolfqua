.checkForFile <- function(inputData){
  if ( file.exists(inputData) ) {
    inputData
  } else {
    stop("File does not exist : ", inputData)
  }
}

#' keep track of folder paths and create them if needed
#' @export
#'
#' @examples
#' tmp <- ProjectStructure$new("./test_project",
#' project_Id  = 3000,
#' order_Id = 6200,
#' workunit_Id = 23000,
#' inputAnnotation = ".",
#' inputData = "."
#' )
#' tmp$qc_path
#' tmp$modelling_path
#' if(FALSE){tmp$create()}
#'

ProjectStructure <-
  R6::R6Class("ProjectStructure", public = list(
    #' @field outpath path
    #' @field qc_path path for qc results
    #' @field modelling_path path for modeling results
    #' @field project_Id project_Id
    #' @field order_Id order_Id
    #' @field workunit_Id workunit_Id
    #' @field inputData inputFile
    #' @field inputAnnotation inputAnnotation xlsx
    outpath = "",
    qc_path = "",
    modelling_path = "",
    project_Id = integer(),
    order_Id = integer(),
    workunit_Id = integer(),
    inputData = character(),
    inputAnnotation = character(),
    #' @description
    #' create ProjectStructure
    #' @param outpath directory
    #' @param project_Id bfabric project ID
    #' @param workunit_Id bfabric workunit_Id
    #' @param order_Id bfabric order_Id
    #' @param inputAnnotation input annotation path
    #' @param inputData input data path
    #' @param qc_path qc folder
    #' @param modelling_path modelling results folder

    initialize = function(outpath,
                          project_Id,
                          order_Id,
                          workunit_Id,
                          inputAnnotation,
                          inputData,
                          qc_path = "qc_results",
                          modelling_path = "modelling_results"){
      self$outpath = outpath
      self$project_Id = project_Id
      self$order_Id = order_Id
      self$workunit_Id = workunit_Id
      self$inputData = .checkForFile(inputData)
      self$inputAnnotation = .checkForFile(inputAnnotation)
      self$qc_path = file.path(outpath, qc_path )
      self$modelling_path = file.path(outpath, modelling_path )
    },
    #' @description
    #' qc folder name
    qc_folder = function(){
      basename(self$qc_path)
    },
    #' @description
    #' modelling folder name
    modelling_folder = function(){
      basename(self$modelling_path)
    },
    #' @description
    #' create outpath
    create_outpath = function(){
      if (!dir.exists(self$outpath)) {
        dir.create(self$outpath)
      }
    },
    #' @description
    #' create qc dir
    creat_qc_dir = function(){
      self$create_outpath()
      if (!dir.exists(self$qc_path)) {
        dir.create(self$qc_path)
      }
    },
    #' @description
    #' create modelling path
    create_modelling_path = function(){
      self$create_outpath()
      if (!dir.exists(self$modelling_path)) {
        dir.create(self$modelling_path)
      }
    },
    #' @description
    #' create all directories
    create = function(){
      self$creat_qc_dir()
      self$create_modelling_path()
    },
    #' @description
    #' empty modelling_path and qc_path folder.
    reset = function(){
      if (unlink(self$modelling_path, recursive = TRUE) != 0 ) {
        message("could not clean ",self$modelling_path)
      }
      if (unlink(self$qc_path, recursive = TRUE) != 0) {
        message("could not clean ",self$modelling_path)
      }
    }

  )
  )
