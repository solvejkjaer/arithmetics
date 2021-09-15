function new_timeline() {
  /* defining test timeline*/
  var instr = {
    timeline: [{
      type: "html-button-response",
      choices: ['Fortsæt'],
      stimulus: "<p>Når du trykker på Fortsæt, vil forsøget starte.</p> <p>Ved at trykke på Fortsæt giver du samtidig tilladelse til at vi må indsamle </p> <p>de data du giver os gennem din besvarelse.</p> <p>Intet af disse data er personligt, og alt vil blive gemt fuldstændig anonymt.</p> <p>Du må afbryde din deltagelse i eksperimentet når som helst.</p> <p>Igen, tusind tak for din deltagelse!. </p>",
      // post_trial_gap: 500
  }],
  sample: {type: 'fixed-repetitions', size: 1}
};
return [instr];
}
