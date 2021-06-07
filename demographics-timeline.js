function new_timeline() {
  /* defining test timeline*/
  var demographics = {
    timeline: [{
      type: "survey-text",
      questions: [
        {prompt: "Hvor gammel er du?", name: 'Age', required: true},
        {prompt: "Hvad er dit modersmål?", name: 'Native language', required: true},
        {prompt: "Hvor bor du?", name: 'Residence', required: true}
      ],
      post_trial_gap: 500
  }],
  sample: {type: 'fixed-repetitions', size: 1}
};
return [demographics];
}
