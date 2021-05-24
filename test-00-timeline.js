/*defining timeline*/
function new_timeline() {
    var test = {
        timeline: [{
            type: 'survey-text',
        //   data: jsPsych.timelineVariable('data'),
            questions: [
                {prompt: "Pensionisten klagede over indholdet af brochurerne, som var"}
            ],
            button_label: "Fortsæt"
        }]
        // timeline_variables: test_stimuli,
        // randomize_order: true,
        // repetitions: 1
      };
      return [test];
}