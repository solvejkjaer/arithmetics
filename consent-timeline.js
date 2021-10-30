function new_timeline() {
  /* defining test timeline*/
  var instr = {
    timeline: [{
      type: "html-button-response",
      choices: ['Fortsæt'],
      stimulus: "<p>Når du trykker på 'Fortsæt', vil forsøget starte.</p> <p>Ved at trykke på 'Fortsæt' giver du samtidig tilladelse til, </p> <p>at vi må indsamle de data du giver os gennem din besvarelse.</p> <p>Ingen af disse data er personlige, og alt vil blive gemt fuldstændig anonymt.</p> <p>Hvis du vælger at deltage i lodtrækningen om et gavekort på 200 kr., </p> <p>skal du oplyse din email-adresse til os, som vil blive opbevaret separat fra dine </p> <p>besvarelser og slettet, når lodtrækningen er slut (d. 15. december, 2021). </p> <p>Du kan afbryde din deltagelse i eksperimentet når som helst.</p> <p>Igen, tusind tak for din deltagelse!. </p>",
      // post_trial_gap: 500
  }],
  sample: {type: 'fixed-repetitions', size: 1}
};
return [instr];
}
