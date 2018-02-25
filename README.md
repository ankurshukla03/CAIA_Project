# CAIA 2 Project Repo

Various attempts at road segmentation.

## Folders

- `/ann`: ANN segmentation, scripts for training and testing.
- `/collector`: satellite image aggregator.
- `/match`: matching line segments
- `/morph`: directional morph
- `/mthresh`: simple multi-threshold segmentation.

Each folder's main script is titled `[foldername]_test.m`. `find_roads_[foldername].m` is the main function which `..._test` executes.