# Sys.setlocale("LC_ALL","es_ES")

# # ####################################################
# # # This script makes a psychTestR implementation of
# # # Gender Names Task
# # # Date:2021
# # # Author: Jon Lapresa-Serrano
# # # Project group: X
# # ###################################################


library(htmltools)
library(psychTestR)
library(tibble)
library(shiny)
library(jspsychr)
library(dplyr)

# base_dir <- "/srv/shiny-server/experimento-TFM"
base_dir <- "/Users/jonla/Desktop/names_JLS"
jspsych_dir <- file.path(base_dir, "jspsych-6-3-1")

write_to_file <- function(json_object,file_name,var_name=NULL){
  OS_type = .Platform
  if(is.null(var_name)){
    # if(OS_type$OS.type == "windows"){
    #   fileConn<-file(file_name)
    #   writeLines(json_object, fileConn, useBytes=TRUE)
    #   close(fileConn)
    # }else{
      write(json_object, file=file_name)
    # }
  }else{
    # if(OS_type$OS.type == "windows"){
    #   fileConn<-file(file_name)
    #   writeLines(paste("var ",var_name,"= ", json_object), fileConn, useBytes=TRUE)
    #   close(fileConn)
    # }else{
      write(paste("var ",var_name,"= ", json_object), file=file_name)
    # }
  }
}

# create dataframe to define stimuli
# setting up a list of the possible response key configurations
resps = list(c("leftarrow","uparrow","rightarrow"),
             c("leftarrow","rightarrow","uparrow"),
             c("uparrow","leftarrow","rightarrow"),
             c("rightarrow","leftarrow","uparrow"),
             c("uparrow","rightarrow","leftarrow"),
             c("rightarrow","uparrow","leftarrow"))
# randomizing the selection of response key configuration
rand_resp = sample(1:length(resps))
response_config = resps[[rand_resp[1]]]

# sentences with masculine forms
sent_masc[1] = "Los alumnos del instituto local tuvieron la excelente oportunidad de visitar el Museo Nacional del Prado."
sent_masc[2] = "Los estudiantes de primer aÒo tienen que matricularse al menos tres meses antes de comenzar los estudios."
sent_masc[3] = "Los vecinos del portal n˙mero 21 votaron sobre la decisiÛn de instalar un ascensor en el edificio."
sent_masc[4] = "Los diputados de aquel entonces tomaron la decisiÛn de derogar la Ley de EducaciÛn que habÌa estado vigente desde 2003."
sent_masc[5] = "Los clientes del hipermercado de la Gran VÌa esperaron durante horas para el comienzo de las rebajas."
sent_masc[6] = "Los profesores del centro educativo deben entregar su autoevaluaciÛn a travÈs de un formulario que se encuentra en la p·gina web oficial."
sent_masc[7] = "Los abogados de todo bufete tienen que aprenderse el CÛdigo Penal y el CÛdigo Civil tan bien como se pueda."
sent_masc[8] = "Los ministros del nuevo gabinete han de escogerse antes de que acabe el prÛximo mes."
sent_masc[9] = "Los empresarios de esa compaÒÌa decidieron posponer la reuniÛn y hacer un descanso con tal de poder comer el almuerzo en alg˙n otro sitio."

# sentences with neutral forms
sent_neut[1] = "Les alumnes del instituto local tuvieron la excelente oportunidad de visitar el Museo Nacional del Prado."
sent_neut[2] = "Les estudiantes de primer aÒo tienen que matricularse al menos tres meses antes de comenzar los estudios."
sent_neut[3] = "Les vecines del portal n˙mero 21 votaron sobre la decisiÛn de instalar un ascensor en el edificio."
sent_neut[4] = "Les diputades de aquel entonces tomaron la decisiÛn de derogar la Ley de EducaciÛn que habÌa estado vigente desde 2003."
sent_neut[5] = "Les clientes del hipermercado de la Gran VÌa esperaron durante horas para el comienzo de las rebajas."
sent_neut[6] = "Les profesores del centro educativo deben entregar su autoevaluaciÛn a travÈs de un formulario que se encuentra en la p·gina web oficial."
sent_neut[7] = "Les abogades de todo bufete tienen que aprenderse el CÛdigo Penal y el CÛdigo Civil tan bien como se pueda."
sent_neut[8] = "Les ministres del nuevo gabinete han de escogerse antes de que acabe el prÛximo mes."
sent_neut[9] = "Les empresaries de esa compaÒÌa decidieron posponer la reuniÛn y hacer un descanso con tal de poder comer el almuerzo en alg˙n otro sitio."

# sentences with collective forms
sent_coll[1] = "El alumnado del instituto local tuvo la excelente oportunidad de visitar el Museo Nacional del Prado."
sent_coll[2] = "El estudiantado de primer aÒo tiene que matricularse al menos tres meses antes de comenzar los estudios."
sent_coll[3] = "El vecindario del portal n˙mero 21 votÛ sobre la decisiÛn de instalar un ascensor en el edificio."
sent_coll[4] = "La diputaciÛn de aquel entonces tomÛ la decisiÛn de derogar la Ley de EducaciÛn que habÌa estado vigente desde 2003."
sent_coll[5] = "La clientela del hipermercado de la Gran VÌa esperaron durante horas para el comienzo de las rebajas."
sent_coll[6] = "El profesorado del centro educativo debe entregar su autoevaluaciÛn a travÈs de un formulario que se encuentra en la p·gina web oficial."
sent_coll[7] = "La abogacÌa de todo bufete tiene que aprenderse el CÛdigo Penal y el CÛdigo Civil tan bien como se pueda."
sent_coll[8] = "El ministerio del nuevo gabinete ha de escogerse antes de que acabe el prÛximo mes."
sent_coll[9] = "El empresariado de esa compaÒÌa decidierÛ posponer la reuniÛn y hacer un descanso con tal de poder comer el almuerzo en alg˙n otro sitio."

# sentences with gaps
sent_gaps[1] = "__________ y __________ pensaron que fue una experiencia de lo m·s enriquecedora."
sent_gaps[2] = "__________ y __________ se olvidaron de hacerlo y tuvieron que empezar un mes m·s tarde."
sent_gaps[3] = "__________ y __________ debatieron sobre las diferencias de vivir en el primer piso o en el cuarto."
sent_gaps[4] = "__________ y __________ aplaudieron enÈrgicamente al darse a conocer el resultado."
sent_gaps[5] = "__________ y __________ incluso trasnocharon para no perderse los mejores precios."
sent_gaps[6] = "__________ y __________ tardaron menos de media hora en completarlo y enviarlo con Èxito."
sent_gaps[7] = "__________ y __________ siempre tenÌan m˙ltiples problemas porque sus memorias no eran muy buenas."
sent_gaps[8] = "__________ y __________ tienen grandes esperanzas en que ser·n esenciales para la remodelaciÛn del Gobierno."
sent_gaps[9] = "__________ y __________ siguieron comentando los detalles de la reuniÛn en mitad del restaurante."

# filler sentences with masculine forms
fill_masc[1] = "Los rebeldes de este instituto deberÌan pensar en el bien com˙n y dejar de destrozar el edificio."
fill_masc[2] = "Los criminales de la ciudad de San Francisco siempre han sido una gran influencia para la leyenda y fama de la isla de Alcatraz."
fill_masc[3] = "Los jardineros del parque de la ciudad no deben abrir la verja hasta que sean las seis de la maÒana."
fill_masc[4] = "Los caballeros de la Mesa Redonda fueron el primer ejemplo de la cl·sica imagen de galanterÌa y heroÌsmo que ahora tanto gusta en las pelÌculas."
fill_masc[5] = "Los cantantes del Teatro Real verdaderamente enseÒan todo el trabajo y entrenamiento que emplean en hacer una buena actuaciÛn."
fill_masc[6] = "Los espectadores de ese programa de televisiÛn han de aburrirse mucho con tantos anuncios."
fill_masc[7] = "Los ciudadanos de esta provincia quiere ver cambios positivos en sus hogares durante los prÛximos cuatro aÒos."
fill_masc[8] = "Los directores de esa organizaciÛn propusieron tener tres reuniones mensuales con tal de mantener la comunicaciÛn activa."
fill_masc[9] = "Missing"

# filler sentences with neutral forms
fill_neut[1] = "Les rebeldes de este instituto deberÌan pensar en el bien com˙n y dejar de destrozar el edificio."
fill_neut[2] = "Les criminales de la ciudad de San Francisco siempre han sido una gran influencia para la leyenda y fama de la isla de Alcatraz."
fill_neut[3] = "Les jardineres del parque de la ciudad no deben abrir la verja hasta que sean las seis de la maÒana."
fill_neut[4] = "Les caballeres de la Mesa Redonda fueron el primer ejemplo de la cl·sica imagen de galanterÌa y heroÌsmo que ahora tanto gusta en las pelÌculas."
fill_neut[5] = "Les cantantes del Teatro Real verdaderamente enseÒan todo el trabajo y entrenamiento que emplean en hacer una buena actuaciÛn."
fill_neut[6] = "Les espectadores de ese programa de televisiÛn han de aburrirse mucho con tantos anuncios."
fill_neut[7] = "Les ciudadanes de esta provincia quiere ver cambios positivos en sus hogares durante los prÛximos cuatro aÒos."
fill_neut[8] = "Les directores de esa organizaciÛn propusieron tener tres reuniones mensuales con tal de mantener la comunicaciÛn activa."
fill_neut[9] = "Missing"

# filler sentences with collective forms
fill_coll[1] = "La rebeldÌa de este instituto deberÌa pensar en el bien com˙n y dejar de destrozar el edificio."
fill_coll[2] = "El crimen de la ciudad de San Francisco siempre ha sido una gran influencia para la leyenda y fama de la isla de Alcatraz."
fill_coll[3] = "La jardinerÌa del parque de la ciudad no debe abrir la verja hasta que sean las seis de la maÒana."
fill_coll[4] = "La caballerÌa de la Mesa Redonda fueron el primer ejemplo de la cl·sica imagen de galanterÌa y heroÌsmo que ahora tanto gusta en las pelÌculas."
fill_coll[5] = "El coro del Teatro Real verdaderamente enseÒa todo el trabajo y entrenamiento que emplea en hacer una buena actuaciÛn."
fill_coll[6] = "La audiencia de ese programa de televisiÛn ha de aburrirse mucho con tantos anuncios."
fill_coll[7] = "La ciudadanÌa de esta provincia quiere ver cambios positivos en sus hogares durante los prÛximos cuatro aÒos."
fill_coll[8] = "La direcciÛn de esa organizaciÛn propuso tener tres reuniones mensuales con tal de mantener la comunicaciÛn activa."
fill_coll[9] = "Missing"

# filler sentences with gaps
fill_gaps[1] = "__________ y __________ han de cumplir un grave castigo con tal de dar ejemplo al resto."
fill_gaps[2] = "__________ y __________ son dos claros ejemplos de cÛmo las acciones mezquinas tambiÈn pasan a ser historia."
fill_gaps[3] = "__________ y __________ siempre llegan puntuales para no tener que esperar fuera hasta poder hacer su trabajo."
fill_gaps[4] = "__________ y __________ demostraron a travÈs de acciones valientes lo importante que es ayudar a los dem·s."
fill_gaps[5] = "__________ y __________ literalmente han brillado esta noche."
fill_gaps[6] = "__________ y __________ han dicho que han estado hasta quince minutos esperando a que se acabaran."
fill_gaps[7] = "__________ y __________ mantienen la esperanza de que por fin podr·n estar en una mejor vivienda."
fill_gaps[8] = "__________ y __________ confirmaron que irÌan a todas las reuniones siempre y cuando no se hicieran durante el fin de semana."
fill_gaps[9] = "Missing"

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

stroop_prac_stim <- data.frame( stimulus = length(3*5),
                                word = rep(c("EJEMPLO", "EL EJEMPLO", "LOS EJEMPLOS"), each=5),
                                color = rep(c("red","green","blue"), 5),
                                response = rep(response_config, 5),
                                resp_config = rep(rand_resp[[1]], 5),
                                id = "stroop_pract_stim",
                                fontsize = "60pt",
                                lineheight = "normal")

# line to make it a test:
# stroop_stim = stroop_stim[-c(21:(54*3)), ]

# write html definitions to the stimulus column
# note this could be added as a pipe to the above, setting df=.
stroop_stim$stimulus <- html_stimulus(df = stroop_stim, 
                                      html_content = "word",
                                      html_element = "p",
                                      column_names = c("color","fontsize","lineheight"),
                                      css = c("color", "font-size", "line-height"),
                                      id = "id")

stroop_prac_stim$stimulus <- html_stimulus(df = stroop_prac_stim,
                                           html_content = "word",
                                           html_element = "p",
                                           column_names = c("color","fontsize","lineheight"),
                                           css = c("color", "font-size", "line-height"),
                                           id = "id")

# create json object from dataframe
stimulus_json <- stimulus_df_to_json(df = stroop_stim,
                                     stimulus = "stimulus",
                                     data = c("word","color","response","stim_type"))

stimulus_prac_json <- stimulus_df_to_json(df = stroop_prac_stim,
                                          stimulus = "stimulus",
                                          data = c("word","color","response"))

# write json object to script
# write_to_script(stimulus_json,"test_stimuli")
# write_to_script(stimulus_prac_json,"prac_stimuli")
write_to_file(stimulus_json, paste0(base_dir, "/test_stimuli.js"), "test_stimuli")
write_to_file(stimulus_prac_json, paste0(base_dir, "/prac_stimuli.js"), "prac_stimuli")


names_arrow <- setNames(c('&#x2190', '&#x2191', '&#x2192'), c('leftarrow', 'uparrow', 'rightarrow'))
red_style=paste0("<span style='color:red;font-size:24pt;line-height:normal'>", names_arrow[response_config[1]], " (rojo)</span>")
green_style=paste0("<span style='color:green;font-size:24pt;line-height:normal'>", names_arrow[response_config[2]], " (verde)</span>")
blue_style=paste0("<span style='color:blue;font-size:24pt;line-height:normal'>", names_arrow[response_config[3]], " (azul)</span>")

resp_arrows = c(paste(red_style, "&emsp;&emsp;", green_style, "&emsp;&emsp;", blue_style),
                paste(red_style, "&emsp;&emsp;", blue_style, "&emsp;&emsp;", green_style),
                paste(green_style, "&emsp;&emsp;", red_style, "&emsp;&emsp;", blue_style),
                paste(green_style, "&emsp;&emsp;", blue_style, "&emsp;&emsp;", red_style),
                paste(blue_style, "&emsp;&emsp;", red_style, "&emsp;&emsp;", green_style),
                paste(blue_style, "&emsp;&emsp;", green_style, "&emsp;&emsp;", red_style))


instr1_stim = paste("<p>Muchas gracias por completar la encuesta previa.</p>",
                  "<p>En este experimento ver√° una palabra de un color (azul, rojo o verde) como la siguiente:</p>",
                  "<p style='color:red;font-size:60pt;line-height:normal'>EJEMPLO</p>",
                  "<p>Tras ver la palabra usted tendr√° que pulsar las siguientes teclas de direcci√≥n de su teclado:</p>",
                  resp_arrows[rand_resp[[1]]],
                  "<p>Pulse tan r√°pido como pueda para identificar el color de las palabras que vea.</p>",
                  "<p>Intente memorizar ahora qu√© tecla de direcci√≥n est√° relacionada con cada color.</p>",
                  "<p>Pulse 'Continuar' para realizar una peque√±a pr√°ctica antes del experimento. Recuerde memorizar antes las teclas.</p>")

instr1_stim_df = data.frame(stimulus = instr1_stim)
instr2_stim_df = data.frame(stimulus = instr2_stim)

# create json object from dataframe
instr1_json <- stimulus_df_to_json(df = instr1_stim_df,
                                     stimulus = "stimulus")
instr2_json <- stimulus_df_to_json(df = instr2_stim_df,
                                      stimulus = "stimulus")
# write json object to script
write_to_file(instr1_json, paste0(base_dir, "/instr1_text.js"), "instr_text")
write_to_file(instr2_json, paste0(base_dir, "/instr2_text.js"), "instr_text")

###############################
##### jsPsych starts here #####
###############################

# # For jsPsych
# library_dir <- "jspsych/jspsych-6.1.0"
# custom_dir <- "jspsych/js"

head <- tags$head(
  # jsPsych files
  
  
  # If you want to use original jspsych.js, use this:
  includeScript(file.path(jspsych_dir, "jspsych.js")),
  
  # If you want to display text while preloading files (to save time), specify your intro_text
  # in jsPsych.init (in run-jspsych.js) and call jspsych_preloadprogressbar.js here:
  # includeScript(file.path(jspsych_dir, "plugins/jspsych_preloadprogressbar.js")),
  
  includeScript(
    # file.path(jspsych_dir, "plugins/jspsych_JLS/jspsych-html-button-response.js")
    file.path(jspsych_dir, "plugins/jspsych-html-button-response.js")
  ),
  
  includeScript(
    # file.path(jspsych_dir, "plugins/jspsych_JLS/jspsych-html-keyboard-response.js")
    file.path(jspsych_dir, "plugins/jspsych-html-keyboard-response.js")
  ),
  
  includeScript(
    # file.path(jspsych_dir, "plugins/jspsych_JLS/jspsych-fullscreen.js")
    file.path(jspsych_dir, "plugins/jspsych-fullscreen.js")
  ),
  
  includeScript(
    # file.path(jspsych_dir, "plugins/jspsych_JLS/jspsych-survey-text.js")
    file.path(jspsych_dir, "plugins/jspsych-survey-text.js")
  ),
  
  includeScript(
    # file.path(jspsych_dir, "plugins/jspsych_JLS/jspsych-survey-multi-choice.js")
    file.path(jspsych_dir, "plugins/jspsych-survey-multi-choice.js")
  ),
  
  includeScript(
    # file.path(jspsych_dir, "plugins/jspsych_JLS/jspsych-survey-html-form.js")
    file.path(jspsych_dir, "plugins/jspsych-survey-html-form.js")
  ),
  
  includeScript(
    # file.path(jspsych_dir, "plugins/jspsych_JLS/jspsych-survey-html-form.js")
    file.path(jspsych_dir, "plugins/jspsych-instructions.js")
  ),
  
  # Custom files
  includeCSS(file.path(jspsych_dir, "css/jspsych.css"))
  # includeCSS("css/style.css")
)

#########

##Intro
ui_intro <- tags$div(
  head,
  includeScript(file.path(base_dir, "intro_text.js")),
  includeScript(file.path(base_dir, "intro-timeline.js")),
  # includeScript(file.path(base_dir, "run-jspsych_full.js")),
  includeScript(file.path(base_dir, "run-jspsych.js")),
  tags$div(id = "js_psych", style = "min-height: 90vh")
)

intro <- page(
  ui = ui_intro,
  label = "intro",
  get_answer = function(input, ...)
    input$jspsych_results,
  validate = function(answer, ...)
    nchar(answer) > 0L,
  save_answer = TRUE
)
  
##Instructions
ui_instr <- tags$div(
  head,
  includeScript(file.path(base_dir, "instr-timeline.js")),
  # includeScript(file.path(base_dir, "run-jspsych_full.js")),
  includeScript(file.path(base_dir, "run-jspsych.js")),
  tags$div(id = "js_psych", style = "min-height: 90vh")
)

instr <- page(
  ui = ui_instr,
  label = "instr",
  get_answer = function(input, ...)
    input$jspsych_results,
  validate = function(answer, ...)
    nchar(answer) > 0L,
  save_answer = TRUE
)

##Practice
ui_prac <- tags$div(
  head,
  includeScript(file.path(base_dir, "prac_stimuli.js")),
  includeScript(file.path(base_dir, "prac-timeline.js")),
  # includeScript(file.path(base_dir, "run-jspsych_full.js")),
  includeScript(file.path(base_dir, "run-jspsych.js")),
  tags$div(id = "js_psych", style = "min-height: 90vh")
)

stroop_prac <- page(
  ui = ui_prac,
  label = "stroop_prac",
  get_answer = function(input, ...)
    input$jspsych_results,
  validate = function(answer, ...)
    nchar(answer) > 0L,
  save_answer = TRUE
)

##Experiment
ui_exp <- tags$div(
  head,
  includeScript(file.path(base_dir, "test_stimuli.js")),
  includeScript(file.path(base_dir, "test-timeline.js")),
  # includeScript(file.path(base_dir, "run-jspsych_full.js")),
  includeScript(file.path(base_dir, "run-jspsych.js")),
  tags$div(id = "js_psych", style = "min-height: 90vh")
)

names_exp <- page(
  ui = ui_exp,
  label = "names_exp",
  get_answer = function(input, ...)
    input$jspsych_results,
  validate = function(answer, ...)
    nchar(answer) > 0L,
  save_answer = TRUE
)

##SURVEY
#survey <- (

##Age, nationality and residence
ui_demographics <- tags$div(
  head,
  includeScript(file.path(base_dir, "demographics-timeline.js")),
  # includeScript(file.path(base_dir, "run-jspsych_full.js")),
  includeScript(file.path(base_dir, "run-jspsych.js")),
  tags$div(id = "js_psych", style = "min-height: 90vh")
)

demographics <- page(
  ui = ui_demographics,
  label = 'demographics',
  get_answer = function(input, ...)
    input$jspsych_results,
  validate = function(answer, ...)
    nchar(answer) > 0L,
  save_answer = TRUE
)

##Gender
ui_gender <- tags$div(
  head,
  includeScript(file.path(base_dir, "gender-timeline.js")),
  # includeScript(file.path(base_dir, "run-jspsych_full.js")),
  includeScript(file.path(base_dir, "run-jspsych.js")),
  tags$div(id = "js_psych", style = "min-height: 90vh")
)

gender <- page(
  ui = ui_gender,
  label = 'gender',
  get_answer = function(input, ...)
    input$jspsych_results,
  validate = function(answer, ...)
    nchar(answer) > 0L,
  save_answer = TRUE
)

##Education
ui_edu <- tags$div(
  head,
  includeScript(file.path(base_dir, "edu-timeline.js")),
  # includeScript(file.path(base_dir, "run-jspsych_full.js")),
  includeScript(file.path(base_dir, "run-jspsych.js")),
  tags$div(id = "js_psych", style = "min-height: 90vh")
)

education <- page(
  ui = ui_edu,
  label = 'education',
  get_answer = function(input, ...)
    input$jspsych_results,
  validate = function(answer, ...)
    nchar(answer) > 0L,
  save_answer = TRUE
)

##Language1
ui_lang1 <- tags$div(
  head,
  includeScript(file.path(base_dir, "lang1-timeline.js")),
  # includeScript(file.path(base_dir, "run-jspsych_full.js")),
  includeScript(file.path(base_dir, "run-jspsych.js")),
  tags$div(id = "js_psych", style = "min-height: 90vh")
)

lang1 <- page(
  ui = ui_lang1,
  label = 'lang1',
  get_answer = function(input, ...)
    input$jspsych_results,
  validate = function(answer, ...)
    nchar(answer) > 0L,
  save_answer = TRUE
)

##Language2
ui_lang <- tags$div(
  head,
  includeScript(file.path(base_dir, "lang_var.js")),
  includeScript(file.path(base_dir, "lang-timeline.js")),
  # includeScript(file.path(base_dir, "run-jspsych_full.js")),
  includeScript(file.path(base_dir, "run-jspsych.js")),
  tags$div(id = "js_psych", style = "min-height: 90vh")
)

lang <- page(
  ui = ui_lang,
  label = "lang",
  get_answer = function(input, ...)
    input$jspsych_results,
  validate = function(answer, ...)
    nchar(answer) > 0L,
  save_answer = TRUE
)

##Neurological disease
ui_neuro <- tags$div(
  head,
  includeScript(file.path(base_dir, "neuro-timeline.js")),
  # includeScript(file.path(base_dir, "run-jspsych_full.js")),
  includeScript(file.path(base_dir, "run-jspsych.js")),
  tags$div(id = "js_psych", style = "min-height: 90vh")
)

neuro <- page(
  ui = ui_neuro,
  label = "neuro",
  get_answer = function(input, ...)
    input$jspsych_results,
  validate = function(answer, ...)
    nchar(answer) > 0L,
  save_answer = TRUE
)

##Duplets
ui_duplet <- tags$div(
  head,
  includeScript(file.path(base_dir, "duplet-timeline.js")),
  # includeScript(file.path(base_dir, "run-jspsych_full.js")),
  includeScript(file.path(base_dir, "run-jspsych.js")),
  tags$div(id = "js_psych", style = "min-height: 90vh")
)

duplet <- page(
  ui = ui_duplet,
  label = "duplet",
  get_answer = function(input, ...)
    input$jspsych_results,
  validate = function(answer, ...)
    nchar(answer) > 0L,
  save_answer = TRUE
)

##Thanks
ui_thanks <- tags$div(
  head,
  includeScript(file.path(base_dir, "thanks_text.js")),
  includeScript(file.path(base_dir, "thanks-timeline.js")),
  # includeScript(file.path(base_dir, "run-jspsych_full.js")),
  includeScript(file.path(base_dir, "run-jspsych.js")),
  tags$div(id = "js_psych", style = "min-height: 90vh")
)

thanks <- page(
  ui = ui_thanks,
  label = "thanks",
  get_answer = function(input, ...)
    input$jspsych_results,
  validate = function(answer, ...)
    nchar(answer) > 0L,
  save_answer = TRUE,
)

##Final
ui_final <- tags$div(
  head,
  includeScript(file.path(base_dir, "final-timeline.js")),
  # includeScript(file.path(base_dir, "run-jspsych_full.js")),
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
  new_timeline(join(
   intro,
   # demographics,
   # gender,
   # education,
   # lang1,
   # lang,
   # neuro,
   duplet,
   elt_save_results_to_disk(complete = FALSE), # anything that is saved here counts as completed
   instr,
   # names_exp,
   # elt_save_results_to_disk(complete = TRUE),
   thanks,
   final), default_lang = "es")
)

##exp
exp <- make_test(
   elts = elts,
   opt = test_options(title="Stroop Task, Aarhus 2021",
                      admin_password="", # write a secret password here
                      enable_admin_panel=TRUE,
                      languages="es",
                      researcher_email="201902476@post.au.dk",
                      # problems_info="?Tiene problemas con el experimento? Env?e un email a 201902476@post.au.dk",
                      display = display_options(
                        full_screen = TRUE,
                        # content_border = "0px",
                        # show_header = FALSE,
                        # show_footer = FALSE,
                        # left_margin = 0L,
                        # right_margin = 0L,
                        css = file.path(jspsych_dir, "css/jspsych.css")
       )))

shiny::runApp(exp)
