close all;
img = imread('imgs/02.png');
g_img = rgb2gray(img);

% this takes some time to run
sizes = size(g_img);
g_img = imresize(g_img, 0.25, 'nearest');
g_img = find_roads_morph(g_img);

%% viz
figure
imshow(g_img);