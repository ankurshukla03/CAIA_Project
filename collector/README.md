# Map Collector

Scrape Google Maps with Nightmare.

## Installing

0. Install Node and NPM if you haven't already. Unsure what minimum version is, this was run on Node 9.5.0 and NPM 5.6.0 on a Windows 10 machine and a Mac running 10.12.6.
1. Run `npm install`. Depedencies will install.

## Parameters

### `map-collector.js`
This is a driver for `map-cap.js` it as a few parameters that are helpful to know about and/or setup for you usage.

#### `coordinateRanges`
This is a collection of regions with specified bounding boxes. Coordinates for the images are randomly choosen within the bounds of these boxes.

#### `region`
Set this to the region you want from `coordinateRanges`

#### `collect_test`
A boolean which specifies whether or not the base map images should be collected. If `false` this will only collect satellite images.

#### `alt`
Atitude in meters to collect the images from.

#### `max`
Maximum number of images to collect.

### `map-cap.js`
This is a set of functions which can be included in some other Node script or run standalone from the commandline. 

#### `debug`
If `true` will show the Nightmare window as the script runs. 

#### CLI Arguments
All required:
- lat: latitude, ideally 7 decimal places
- long: logitude, ideally 7 decimal places
- alt: altitude in meters
- fname: file name to save the screenshot as
