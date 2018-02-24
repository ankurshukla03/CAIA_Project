% red, green, blue is the color channels of the image
% test is a binary image 1 = roads, 0 = background
function [train, test] = preprocess_single_rgb(img, test_img)
    img = imresize(img, .25, 'bicubic');
    test_img = imresize(test_img, .25, 'bicubic');
    train = [[]];
    test = [[]];
    r = img(:,:,1);
    g = img(:,:,2);
    b = img(:,:,3);
    for i=1:size(img, 1)
        for j=1:size(img,2)
            train(end+1,:) = [r(i,j), g(i,j), b(i,j)]; %#ok
            test(end+1,:) = [test_img(i,j)]; %#ok
        end
    end
end