close all;
%img = imread('imgs/richmond.png');
img = imread('train.png');
g_img = rgb2gray(img);

% this takes some time to run
sizes = size(g_img);
g_img = imresize(g_img, .15, 'bilinear');

g_img_3 = find_roads_morph(g_img,3);
g_img_5 = find_roads_morph(g_img,5);
g_img_7 = find_roads_morph(g_img,7);
g_img_11 = find_roads_morph(g_img,11);

%% viz
rows = 2;
cols = 2;
figure
subplot(rows, cols, 1), imshow(g_img_3);
subplot(rows, cols, 2), imshow(g_img_5);
subplot(rows, cols, 3), imshow(g_img_7);
subplot(rows, cols, 4), imshow(g_img_11);