const Nightmare = require('nightmare');
const nightmare = Nightmare({show: true});

// to prevent JS from doing some float rounding keep as strings
const alt = '15z'
const lat = '59.2719844';
const long = '17.6372656';

const url = `https://www.google.se/maps/@${lat},${long},${alt}`;
//const url = `https://www.google.se/maps/@${lat},${long},${alt}/data=!3m1!1e3?hl=en`;

const satButton = '.widget-settings-button:nth-child(2)';

nightmare
  .viewport(1100, 700)
  .goto(url)
  .wait(4000)
  .click('.searchbox-hamburger')
  .wait(satButton)
  .click(satButton)
  .wait(1500)
  .screenshot('./output.png', {x:100, y:100, width:900, height:455})
  .end()
  .catch(error => {
    console.error('Something failed:', error)
  });