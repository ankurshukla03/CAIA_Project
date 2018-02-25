% red, green, blue is the color channels of the image
% test is a binary image 1 = roads, 0 = background
function [train, test] = preprocess_neighbor_rgb(img, test_img)
    size = 3;
    offset = size-1 / 2;
    resize_scale = [500, NaN]; %resize to 500, keep proportion.
    img = imresize(img, resize_scale, 'bicubic');
    test_img = imresize(test_img, resize_scale, 'bicubic');
    train = [];
    test = [];
    r = img(:,:,1);
    g = img(:,:,2);
    b = img(:,:,3);
    for i=offset+1:(size(img, 1)-offset)
        for j=offset+1:(size(img,2)-offset)
            sub_r = r(i-offset:j-offset, i+offset:j+offset);
            sub_r = reshape(sub_r.', 1, []);
            
            sub_g = g(i-offset:j-offset, i+offset:j+offset);
            sub_g = reshape(sub_g.', 1, []);
            
            sub_b = b(i-offset:j-offset, i+offset:j+offset);
            sub_b = reshape(sub_b.', 1, []);
            
            train(:, end+1) = [sub_r; sub_g; sub_b]; %#ok
            test(:, end+1) = [test_img(i,j)]; %#ok
        end
    end
end