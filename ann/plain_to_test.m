% Test image preprocessing
function out = plain_to_test(img)
    out = rgb2gray(img) > 250;
end