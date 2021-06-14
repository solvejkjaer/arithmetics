/*defining timeline*/
var timeline = [];
var arithmetics = {
    timeline: [{
        type: 'survey-text',
        data: jsPsych.timelineVariable('data'),
        stimulus: jsPsych.timelineVariable('stimulus'),
        questions: [
            {prompt: stimulus, columns: 500}
        ],
        button_label: "Fortsæt",
        on_finish: function(data){
            var correct = false;
            if(data.response == data.answer && data.rt > -1){
                correct = true;
            }
            data.correct = correct;
            },
    }]
    // timeline_variables: math_stimuli,
    // randomize_order: true,
    // repetitions: 1
    };

var sentence = {
    timeline: [{
        type: 'survey-text',
        data: jsPsych.timelineVariable('data'),
        stimulus: function(){
            var stimuli = jsPsych.timelineVariable('data')
            stim = stimuli.map(item => item.sent_stim)
            return stim;
          },
        questions: [
            {prompt: stimulus, columns: 500}
        ],
        button_label: "Fortsæt",
    }]
    // timeline_variables: sent_stimuli,
    // randomize_order: true,
    // repetitions: 1
    };

var test_procedure = {
    timeline: [arithmetics,sentence],
    timeline_variables: test_stimuli,
};

timeline.push(test_procedure)