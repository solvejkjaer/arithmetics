function new_timeline() {
  /* defining test timeline*/
  var y_n = ["Ja ", "Nej ", "Ønsker ikke at svare "];

  var dyslexia = {
    timeline: [{
      type: "survey-multi-choice",
      questions: [
        {prompt: "Er du ordblind?", name: 'Dyslexia', options: y_n, required: true}
      ],
      button_label: "Fortsæt",
      post_trial_gap: 500
  }],
  // timeline_variables: y_n,
  // sample: {type: 'fixed-repetitions', size: 1}
};
return [dyslexia];
}
