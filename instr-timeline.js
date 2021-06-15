function new_timeline() {
  /* defining test timeline*/
  var instr = {
    timeline: [{
      type: "html-button-response",
      choices: ['Fortsæt'],
      stimulus: "<p>I det følgende er der to slags opgaver.</p> <p>Først skal du regne et regnestykke.</p> <p>Dernæst bedes du afslutte sætningen.</p> <p>Du må skrive lige hvad der falder dig ind.</p> <p>Der er 27 sæt af to opgaver.</p> <p>God fornøjelse. </p>",
      // post_trial_gap: 500
  }],
  sample: {type: 'fixed-repetitions', size: 1}
};
return [instr];
}
