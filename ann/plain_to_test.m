% Test image preprocessing
function out = plain_to_test(img)
    % We need to mask a very specific shade of yellow
    red = img(:,:,1); green = img(:,:,2); blue = img(:,:,3);
    mred = red == 255; 
    mgreen = green == 242; 
    mblue = blue == 175;
    final_mask = mred & mgreen & mblue;
    red(final_mask) = 255; 
    green(final_mask) = 255; 
    blue(final_mask) = 255;
    img = cat(3, red, green, blue);
    
    out = rgb2gray(img) >= 250;
end