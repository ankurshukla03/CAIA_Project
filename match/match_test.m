close all;
img = imread('mt02.jpg');
g_img = rgb2gray(img);

g_img = imresize(g_img, .20, 'nearest');
g_img = find_roads_match(g_img);

%% viz
figure
imshow(g_img);