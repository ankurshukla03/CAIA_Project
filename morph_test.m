close all;
%% open 
img = imread('imgs/02.png');
g_img = rgb2gray(img);

g_img = find_roads_morph(g_img);

%% viz
figure
imshow(g_img);