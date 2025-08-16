#' A function to add lines to an existing quarto log.
#'
#' @description
#' A little package to write to my work notes Quarto. The LOG_PATH needs to point to a folder of qmds.
#'
#' @importFrom svDialogs dlgInput dlg_list
#' @importFrom here here
#' @importFrom stringr str_extract
#' @export

logger <- function() {
  project = here::here() #find the project you're in

  logslist <- list.files(path=Sys.getenv("LOG_PATH"))
  file.choice <- svDialogs::dlg_list(choices = logslist,
    preselect = NULL,
    multiple = FALSE)$res

  text_to_add <- svDialogs::dlgInput("Enter text to be appended")$res

  CON = file(paste0(Sys.getenv("LOG_PATH"),"/",file.choice), "a")
  proj_name = stringr::str_extract(project, "([^/]+$)")
  writeLines(paste(Sys.Date(), ":", "Project : \"", proj_name, "Note = ", text_to_add),
  con = ,CON,
  sep = "\n", useBytes = FALSE)

}
