function new_timeline() {
  /* defining test timeline*/
  var instr = {
    timeline: [{
      type: "html-button-response",
      choices: ['Fortsæt'],
      stimulus: "<p>I det følgende får du brug for at kende regnearternes hierarki:</p> <p>Parenteser skal udregnes allerførst.</p> <p>Gange/dividere kommer før plus/minus.</p> <p>Og ellers regnes der fra venstre mod højre.</p> <p>God fornøjelse. </p>",
      // post_trial_gap: 500
  }],
  sample: {type: 'fixed-repetitions', size: 1}
};
return [instr];
}
