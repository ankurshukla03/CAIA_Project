function subimg = get_1d_range(im, i, j, offset)
    subimg = im(i-offset:i+offset, j-offset:j+offset);
    subimg = reshape(subimg.', 1, []);
end