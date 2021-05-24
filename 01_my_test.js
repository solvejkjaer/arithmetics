/*defining timeline*/
function new_timeline() {
    var test = {
        timeline: [{
          type: 'survey-html-form',
          data: jsPsych.timelineVariable('data'),
          preamble: '<p> Færdiggør denne sætning </p>',
          function(data){
            var survey_trial = {
                type: 'survey-text',
                questions: [
                  {prompt: "Pensionisten klagede over indholdet af brocurerne, som var"}
          },
          html: html_input
        }],
        timeline_variables: test_stimuli,
        randomize_order: true,
        repetitions: 1
      };
      return [test];
}