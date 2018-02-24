const mapCap = require('./map-cap');

// simple bouding boxes of regions, oceans left out as much as possible.
// gathered using latlong.net/
var coordinateRanges = {
  'america': {
    src: [49.331784,-125.462500],
    to: [30.381694, -70.267187]
  },
  'brazil': {
    src: [0.081368, -66.400000],
    to: [-21.540915, -41.087500]
  },
  'central_europe': {
    src: [52.307452, -0.860473],
    to: [44.133709, 31.131714]
  },
  'china': {
    src: [41.028377, 83.866089],
    to: [24.694435, 118.477787]
  },
  'india': {
    src: [29.572219, 76.932607],
	to: [9.112917, 77.899404]
  }
};

function range(val) {
  val = val.sort();
  return val[1] - val[0];
}

function randcoord(src, to) {
  var latRange  = [src[0], to[0]];
  var longRange = [src[1], to[1]];

  var randLat  = (Math.random() * range(latRange) + latRange[0]).toFixed(7);
  var randLong = (Math.random() * range(longRange) + longRange[0]).toFixed(7);
  return [randLat, randLong];
}

let collect_test = true;
let max = 100;
let region = coordinateRanges.central_europe;
const alt = 1200;
function capture(count = 0) {
  if (count >= max) {
    return;
  }
  const [lat, long] = randcoord(region.src, region.to);
  const fname = `images/${lat.replace(/\./g, '\'')}_${long.replace(/\./g, '\'')}.png`;
  mapCap(lat, long, alt, fname, () => {
    capture(count + 1);
  }, collect_test);
}

capture();