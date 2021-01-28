import tba from 'ic:canisters/tba';

/*
tba.greet(window.prompt("Enter your name:")).then(greeting => {
  window.alert(greeting);
});
*/

tba.loading_message().then(tba_msg => {
    window.alert(tba_msg);
});

