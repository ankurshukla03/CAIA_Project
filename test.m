close all;
%% open 
img = imread('02.png');
g_img = rgb2gray(img);

[g_img, roads] = find_roads_mthresh(g_img);

%% viz
rows = 1;
cols = 2;
% subplot()
% subplot(rows, cols, 1), imshow(img);
% subplot(rows, cols, 2), imagesc(g_img);
figure
imagesc(g_img);