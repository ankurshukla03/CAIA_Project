const debug = false;
const Nightmare = require('nightmare');

const burgerButton = '.searchbox-hamburger';
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

function mapCap(lat, long, alt, fname, callback=defaultCallback, collect_test=false) {
  if (collect_test) {
    cap_both(lat, long, alt, fname, callback);
  } else {
    cap_only_satellite(lat, long, alt, fname, callback);
  }
}

function cap_only_satellite(lat, long, alt, fname, callback) {
  const url = `https://www.google.se/maps/@${lat},${long},${alt}m/data=!3m1!1e3?hl=en`;
  console.log(url);
  const nightmare = Nightmare({show: debug});
  return (nightmare
    .viewport(1100, 700)
    .goto(url)
    .wait(5000)
    .inject('css', './hide-styles.css')
    .wait(burgerButton)
    .click(burgerButton)
    .wait(satButton)
    .click(satButton)
    .wait(2000)
    .screenshot(`./${fname}`, {x:100, y:100, width:500, height:400})
    .end(() => {
      console.log(`captured "${fname}"`);
      callback();
    })
    .catch(error => {
      console.error('Something failed:', error);
      callback();
    })
  );
};

// clicks the widget minimap and captures the plain view.
function cap_both(lat, long, alt, fname, callback) {
  const url = `https://www.google.se/maps/@${lat},${long},${alt}m/data=!3m1!1e3?hl=en`;
  const fnameTest = fname.replace(/\.png/g, '_TEST.png');
  const nightmare = Nightmare({show: debug});
  return (nightmare
    .viewport(1100, 700)
    .goto(url)
    .wait(5000)
    .inject('css', './hide-styles.css')
    // turn off labels
    .wait(burgerButton)
    .click(burgerButton)
    .wait(satButton)
    .click(satButton)
    .wait(2000)
    .screenshot(`./${fname}`, {x:100, y:100, width:500, height:400})
    // switch to plain map view
    .click('.widget-minimap-shim')
    .wait(2000)
    // turn off labels (again)
    .wait(burgerButton)
    .click(burgerButton)
    .wait(satButton)
    .click(satButton)
    .wait(2000)
    .screenshot(`./${fnameTest}`, {x:100, y:100, width:500, height:400})
    .end(() => {
      console.log(`captured "${fname}"`);
      callback();
    })
    .catch(error => {
      console.error('Something failed:', error);
      callback();
    })
  );
};

if (process.argv.length > 2) {
  console.log(process.argv);
  let lat  = process.argv[2];
  let long = process.argv[3];
  let alt  = process.argv[4];
  let fname = process.argv[5] || 'capture.png';
  mapCap(lat, long, alt, fname);
} else {
  module.exports = mapCap;
}
