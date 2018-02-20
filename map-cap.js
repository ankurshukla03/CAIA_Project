const debug = false;
const Nightmare = require('nightmare');

const satButton = '.widget-settings-button:nth-child(2)';

/*
  To prevent JS from doing some float rounding keep as strings
  lat: string, '59.2719844'
  long: string, '59.2719844'
  alt: number, 500
  test_collect: optional boolean
*/
function defaultCallback() {
  console.log('screenshot completed');
}

function mapCap(lat, long, alt, fname, callback=defaultCallback, test_collect=false) {
  let _alt = test_collect ? `${alt}z` : `${alt}m`; // z is plain, m is satellite
  const url = `https://www.google.se/maps/@${lat},${long},${_alt}${test_collect ? '' : '/data=!3m1!1e3?hl=en'}`;
  const nightmare = Nightmare({show: debug});
  return (nightmare
    .viewport(1100, 700)
    .goto(url)
    .wait(4000)
    .click('.searchbox-hamburger')
    .wait(satButton)
    .click(satButton)
    .wait(1500)
    .screenshot(`./${fname}`, {x:100, y:100, width:900, height:455})
    .end(callback)
    .catch(error => {
      console.error('Something failed:', error);
    })
  );
};

if (process.argv.length > 2) {
  console.log(process.argv);
  let lat  = process.argv[2];
  let long = process.argv[3];
  let alt  = process.argv[4];
  let fname = process.argv[5];
  mapCap(lat, long, alt, fname);
} else {
  module.exports = mapCap;
}
