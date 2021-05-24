# # ####################################################
# # # This script makes a psychTestR implementation of
# # # arithmetics
# # # Date:2021
# # # Author: Solvej
# # # Project group: X
# # ###################################################


library(htmltools)
library(psychTestR)
library(tibble)
library(shiny)
library(jspsychr)
library(dplyr)

# base_dir <- "/srv/shiny-server/experimento-TFM"
base_dir <- "/Users/Solvej/OneDrive - Aarhus Universitet/Alting/Lingvistik/Projekter/arithmetics_project/arithmetics/"
jspsych_dir <- file.path(base_dir, "jspsych-6-3-1")

###############################
##### jsPsych starts here #####
###############################


head <- tags$head(
  # jsPsych files
  
  
  # If you want to use original jspsych.js, use this:
  includeScript(file.path(jspsych_dir, "jspsych.js")),
  
  # If you want to display text while preloading files (to save time), specify your intro_text
  # in jsPsych.init (in run-jspsych.js) and call jspsych_preloadprogressbar.js here:
  # includeScript(file.path(jspsych_dir, "plugins/jspsych_preloadprogressbar.js")),
  
  includeScript(
    file.path(jspsych_dir, "plugins/jspsych-html-button-response.js")
  ),
  
  includeScript(
    file.path(jspsych_dir, "plugins/jspsych-html-keyboard-response.js")
  ),
  
  includeScript(
    file.path(jspsych_dir, "plugins/jspsych-fullscreen.js")
  ),
  
  includeScript(
    file.path(jspsych_dir, "plugins/jspsych-survey-text.js")
  ),
  
  includeScript(
    file.path(jspsych_dir, "plugins/jspsych-survey-multi-choice.js")
  ),
  
  includeScript(
    file.path(jspsych_dir, "plugins/jspsych-survey-html-form.js")
  ),
  
  includeScript(
    file.path(jspsych_dir, "plugins/jspsych-instructions.js")
  ),
  
  # Custom files
  includeCSS(file.path(jspsych_dir, "css/jspsych.css"))
)

#########

##Test
ui_test <- tags$div(
  head,
  # includeScript(file.path(base_dir, "test_text.js")),
  includeScript(file.path(base_dir, "test-00-timeline.js")),
  includeScript(file.path(base_dir, "run-jspsych.js")),
  tags$div(id = "js_psych", style = "min-height: 90vh")
)

test <- page(
  ui = ui_test,
  label = "test",
  get_answer = function(input, ...)
    input$jspsych_results,
  validate = function(answer, ...)
    nchar(answer) > 0L,
  save_answer = TRUE
)

##Final
ui_final <- tags$div(
  head,
  includeScript(file.path(base_dir, "final-timeline.js")),
  includeScript(file.path(base_dir, "run-jspsych.js")),
  tags$div(id = "js_psych", style = "min-height: 90vh")
)

final <- page(
  ui = ui_final,
  label = "final",
  get_answer = function(input, ...)
    input$jspsych_results,
  validate = function(answer, ...)
    nchar(answer) > 0L,
  save_answer = TRUE,
  final = TRUE
)

##elts
elts <- join(
    test,
    # elt_save_results_to_disk(complete = FALSE), # anything that is saved here counts as completed
    # instr,
    elt_save_results_to_disk(complete = TRUE),
    final
)

##exp
exp <- make_test(
  elts = elts,
  opt = test_options(title="arithmetics test, Aarhus 2021",
                     admin_password="", # write a secret password here
                     enable_admin_panel=TRUE,
                     researcher_email="jbkj@gmail.com",
                     display = display_options(
                       full_screen = TRUE,
                       css = file.path(jspsych_dir, "css/jspsych.css")
                     )))

# shiny::runApp(".")