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
            if(data.response == 'leftarrow' &&  data.key_press == 37 && data.rt > -1){
                correct = true;
            } else if(data.response == 'uparrow' &&  data.key_press == 38 && data.rt > -1){
                correct = true;
            } else if(data.response == 'rightarrow' &&  data.key_press == 39 && data.rt > -1){
                correct = true;
            }
            data.correct = correct;
            },
    }]
    // timeline_variables: test_stimuli,
    // randomize_order: true,
    // repetitions: 1
    };

var sentence = {
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
            if(data.response == 'leftarrow' &&  data.key_press == 37 && data.rt > -1){
                correct = true;
            } else if(data.response == 'uparrow' &&  data.key_press == 38 && data.rt > -1){
                correct = true;
            } else if(data.response == 'rightarrow' &&  data.key_press == 39 && data.rt > -1){
                correct = true;
            }
            data.correct = correct;
            },
    }]
    // timeline_variables: test_stimuli,
    // randomize_order: true,
    // repetitions: 1
    };

var test_procedure = {
    timeline: [arithmetics,sentence],
    timeline_variables: test_stimuli,
};

timeline.push(test_procedure)