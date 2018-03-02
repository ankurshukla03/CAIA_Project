% Train image preprocessing
function out = plain_to_train(img)
    h = fspecial('average', 5);
    out = imfilter(img, h, 'replicate');
end