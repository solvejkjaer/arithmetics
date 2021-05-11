function new_timeline() {
  /* defining test timeline*/
  var test = {
    timeline: [{
      type: 'survey-html-form',
      data: jsPsych.timelineVariable('data'),
      preamble: '<p> Færdiggør venligst sætningen </p>',
      function(data){
        var html_input = '<p>' + data.sentence + '</p>',
      },
      html: html_input
    }],
    timeline_variables: test_stimuli,
    randomize_order: true,
    repetitions: 1
  };
  return [test];
}