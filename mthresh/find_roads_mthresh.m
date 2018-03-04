function [img, roads] = find_roads_mthresh(mimg)
% to grayscale
if size(mimg,3) > 1
   mimg = rgb2gray(mimg); 
end

% smooth
img = imsharpen(mimg);

% thresh
mthresh = multithresh(img, 3); % separates into 4 parts
img = imquantize(img, mthresh);

% find comps
comps = cell(4,1);
for i=1:4
   comps{i} = img == i;
   figure
   imshow(comps{i});
   title(sprintf('%d', i));
end

roads = comps;
end