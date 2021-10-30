function new_timeline() {
  /* defining test timeline*/
  var instr = {
    timeline: [{
      type: "html-button-response",
      choices: ['Fortsæt'],
      stimulus: "<p>Der vil være to slags opgaver.</p> <p>Du bedes både regne nogle regnestykker og færdiggøre nogle sætninger.</p> <p>I færdiggørelserne må du skrive lige, hvad der falder dig ind.</p> <p>Der er 54 sæt af to opgaver.</p> <p>God fornøjelse! </p>",
      // post_trial_gap: 500
  }],
  sample: {type: 'fixed-repetitions', size: 1}
};
return [instr];
}
