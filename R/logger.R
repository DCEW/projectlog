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

  logslist <- c("Create New File",list.files(path=Sys.getenv("LOG_PATH")))
  file.choice <- svDialogs::dlg_list(choices = logslist,
    preselect = NULL,
    multiple = FALSE)$res

  if (file.choice == "Create New File") {
    new.file <- svDialogs::dlgInput("New file name:", default = NA)$res
    file.create(file.path = paste0(Sys.getenv("LOG_PATH"), "/",new.file, ".qmd"))
    file.choice <- new.file
  }
  text_to_add <- svDialogs::dlgInput("Enter text to be appended")$res

  CON = file(paste0(Sys.getenv("LOG_PATH"),"/",file.choice), "a")
  proj_name = stringr::str_extract(project, "([^/]+$)")
  cat(paste(Sys.Date(),
                   paste0("Project: ", proj_name),
                   paste0("Note = ", text_to_add),sep = "\n"), file = CON, append = TRUE)

}
