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
library(tidyverse)
library(readxl)

# base_dir <- "/srv/shiny-server/experimento-TFM"
base_dir <- "/Users/Solvej/OneDrive - Aarhus Universitet/Alting/Lingvistik/Projekter/arithmetics_project/arithmetics/"
jspsych_dir <- file.path(base_dir, "jspsych-6-3-1")

write_to_file <- function(json_object,file_name,var_name=NULL){
  if(is.null(var_name)){
    write(json_object, file=file_name)
  }else{
    write(paste("var ",var_name,"= ", json_object), file=file_name)
  }
}

stimuli<-read_excel(file.path(base_dir,"materiale.xlsx"))
# nb long format!

stroop_stim <- data.frame( stimulus = length(54*3),
                           word = rep(stim, each=3),
                           color = rep(c("red","green","blue"), 54),
                           response = rep(response_config, 54),
                           resp_config = rep(rand_resp[[1]], 54*3),
                           stim_type = rep(c("1", "2", "3", "4", "5", "6"), each=9*3), 
                           id = "stroop_stim",
                           fontsize = "60pt",
                           lineheight = "normal") %>%
  mutate(stim_type = recode(stim_type, '1' = "gender_masc", '2' = "gender_neut", '3' = "gender_col", '4' = "control_lemma", '5' = "control_der", '6' = "control_sing"))

# write html definitions to the stimulus column
# note this could be added as a pipe to the above, setting df=.
stroop_stim$stimulus <- html_stimulus(df = stroop_stim, 
                                      html_content = "word",
                                      html_element = "p",
                                      column_names = c("color","fontsize","lineheight"),
                                      css = c("color", "font-size", "line-height"),
                                      id = "id")

# create json object from dataframe
stimulus_json <- stimulus_df_to_json(df = stroop_stim,
                                     stimulus = "stimulus",
                                     data = c("word","color","response","stim_type"))

# write json object to script
write_to_file(stimulus_json, file.path(base_dir, "test_stimuli.js"), "test_stimuli")

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