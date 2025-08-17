library(testthat)
library(mockery)

test_that("logger appends to an existing file", {
  temp_log_dir <- tempfile()
  dir.create(temp_log_dir)

  # Create a dummy existing file
  existing_file <- file.path(temp_log_dir, "testlog.qmd")
  writeLines("Initial log entry", existing_file)

  # Mock LOG_PATH environment variable
  withr::local_envvar(LOG_PATH = temp_log_dir)

  # Mock dependencies
  mock_here <- mock("fake/project/path")
  mock_dlg_list <- mock(list(res = "testlog.qmd"))  # select existing file
  mock_dlg_input <- mock(list(res = "This is a test note"))   # note to add

  stub(logger, "here::here", mock_here)
  stub(logger, "svDialogs::dlg_list", mock_dlg_list)
  stub(logger, "svDialogs::dlgInput", mock_dlg_input)

  # Run the function
  logger()

  # Check that note was appended
  log_contents <- readLines(existing_file)
  expect_true(any(grepl("This is a test note", log_contents)))
  expect_true(any(grepl("Project: path", log_contents)))
})
