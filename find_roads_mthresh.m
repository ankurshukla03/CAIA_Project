function [img, roads] = find_roads_mthresh(mimg)
%% smooth
% h = fspecial('average', 3);
% img = imfilter(mimg, h);

%% thresh
mthresh = multithresh(mimg, 3); % separates into 4 parts
img = imquantize(mimg, mthresh);

%% morph 
se = strel('disk', 5);
img = imclose(img, se);

%% find roads
comps = cell(4,1);
for i=1:4
   comps{i} = img == i;
   figure
   imshow(comps{i});
   title(sprintf('%d', i));
end

%pick region with the fewest components AND widest?


%% region find
% comps = bwconncomp(img);
% props = regionprops(comps, 'BoundingBox', 'Eccentricity');
roads = comps;
end