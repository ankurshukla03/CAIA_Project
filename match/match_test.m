close all;
img = imread('imgs/02.png');
g_img = rgb2gray(img);

g_img = imresize(g_img, .20, 'nearest');
g_img = find_roads_match(g_img);

%% viz
figure
imshow(g_img);