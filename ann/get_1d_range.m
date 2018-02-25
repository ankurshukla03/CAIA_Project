% pass this a slice of a color spectrum and it 
% will five you an input vector
function subimg = get_1d_range(im, i, j, offset)
    subimg = im(i-offset:i+offset, j-offset:j+offset);
    subimg = reshape(subimg.', 1, []);
end