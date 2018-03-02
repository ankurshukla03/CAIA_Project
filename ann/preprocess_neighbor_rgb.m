% red, green, blue is the color channels of the image
% test is a binary image 1 = roads, 0 = background
function [train, test] = preprocess_neighbor_rgb(img, test_img, max_px)
    window_size = 3;
    offset = (window_size-1) / 2;
    w = size(img,1);
    h = size(img,2);
    road_count = 0;
    non_count  = 0;
    train = [];
    test = [];
    r = img(:,:,1);
    g = img(:,:,2);
    b = img(:,:,3);
    % balance the dataset
    while road_count < max_px || non_count < max_px
        x = (offset+1) + floor(rand() * (w-offset*2));
        y = (offset+1) + floor(rand() * (h-offset*2));
        if test_img(x,y) == 1 && road_count < max_px
            road_count = road_count + 1;
        elseif test_img(x,y) == 0 && non_count < max_px
            non_count = non_count + 1;
        elseif (test_img(x,y) == 0 && non_count == max_px) || ...
               (test_img(x,y) == 1 && road_count == max_px)
            continue
        end
        sub_r = get_1d_range(r, x, y, offset);      
        sub_g = get_1d_range(g, x, y, offset);            
        sub_b = get_1d_range(b, x, y, offset);
        input = normalize([sub_r sub_g sub_b]');
        train(:, end+1) = input; %#ok
        test(:, end+1) = [test_img(x,y)]; %#ok
    end
end