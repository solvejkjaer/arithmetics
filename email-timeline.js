function new_timeline() {
  /* defining test timeline*/
  var email = {
    timeline: [{
      type: "survey-text",
      questions: [
        {prompt: "Tusind tak fordi du ville være med! </p> <p>Hvis du vil deltage i lodtrækningen om et gavekort på 200 kr., skal du indtaste din </p> <p>e-mailadresse her. Dermed giver du os tilladelse til at opbevare din e-mailadresse, </p> <p>indtil vinderne af lodtrækningen er fundet. Vinderne vil blive udtrukket d. 15. december 2021. </p> <p>Herefter vil alle deltagere i lodtrækningen få besked om udfaldet af lodtrækningen, </p> <p>og din e-mailadresse vil blive slettet.</p>", name: 'Email', required: false},
      ],
      button_label: "Fortsæt",
      post_trial_gap: 500
  }],
  sample: {type: 'fixed-repetitions', size: 1}
};
return [email];
}
