function new_timeline() {
  /* defining test timeline*/
  var gend = ["Kvinde ", "Mand ", "Ingen af delene ", "Ønsker ikke at svare "];

  var gender = {
    timeline: [{
      type: "survey-multi-choice",
      questions: [
        {prompt: "Hvad er dit køn?", name: 'Gender', options: gend, required: true},
      ],
      button_label: "Fortsæt",
      post_trial_gap: 500
  }],
  // timeline_variables: gend,
  // sample: {type: 'fixed-repetitions', size: 1}
};
return [gender];
}
