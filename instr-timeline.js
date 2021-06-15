function new_timeline() {
  /* defining test timeline*/
  var instr = {
    timeline: [{
      type: "html-button-response",
      choices: ['Fortsæt'],
      stimulus: "<p> I det følgende er der to slags opgaver. Først skal du regne et regnestykke. Dernæst bedes du afslutte sætningen. Du må skrive lige hvad der falder dig ind. Der er 27 sæt af to opgaver. God fornøjelse. </p>",
      post_trial_gap: 500
  }],
  sample: {type: 'fixed-repetitions', size: 1}
};
return [instr];
}
