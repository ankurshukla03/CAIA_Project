function [img] = find_roads_morph(mimg)
% keep size odd.
strel_size = 5;
assert(mod(strel_size, 2) == 1);
ses = structuring_elems(strel_size);

img = dir_morph(mimg, ses, strel_size, 'erode');
img = dir_morph(img, ses, strel_size, 'dilate');

img = dir_morph(img, ses, strel_size, 'dilate');
img = dir_morph(img, ses, strel_size, 'erode');

end

%% directional morph
function img = dir_morph(img, ses, strel_size, op)
    offset = (strel_size - 1)/2;
    % do not modify this
    tmp_img = img;
    % we modify *this*
    out_img = tmp_img;
    progressbar(sprintf('%s i', op),'j');
    for i = offset+1:(size(tmp_img,1)-offset)
        for j = offset+1:(size(tmp_img,2)-offset)
            % compute sd gray value
            vals = zeros(numel(ses), 1);
            sub_img = tmp_img(i-offset:i+offset,j-offset:j+offset);
            for k = 1:numel(ses)
                se = ses{k};
                vals(k) = strel_stdev(sub_img, se);
            end
            % morph ONLY i,j where sd is minimal
            [~, idx] = min(vals);
            switch op
                case 'dilate'
                    sub_img = imdilate(sub_img, ses{idx});
                case 'erode'
                    sub_img = imerode(sub_img, ses{idx});
                otherwise
                    warning('Unexpected morph type.');
            end
            out_img(i,j) = sub_img(offset+1, offset+1);
            progressbar([], j/size(tmp_img,2));
        end
        progressbar(i/size(tmp_img,1),[]);
    end
    progressbar(1);
    % contrast stretch output.
    img = contrast_stretch(out_img);
end

function stretched = contrast_stretch(img)
vmin = min(img(:));
vmax = max(img(:));
m = 255/(vmax - vmin);  % slope from min to max
c = 255 - m*vmax;       % find the intercept of the straight line with the axis
stretched = m*img + c;  % transform the image according to new slope
end

%% stdev over some se
function stdev = strel_stdev(im, se)
    vals = zeros(size(se,1), 1);
    for i=1:size(im,1)
        for j=1:size(im,2)
            if se(i,j) == 1
                vals(i) = im(i,j);
            end
        end
    end
    stdev = std(vals);
end

%% create four directional se's
function [ses] = structuring_elems(size)
    % structuring elements, these should be 5x5.
    horiz = strel('line', size, 0);
    horiz = padarray(horiz.Neighborhood, 2);
    vert = horiz';
    % diagonals
    r_diag = eye(size);
    l_diag = rot90(r_diag);
    ses = {horiz, r_diag, vert, l_diag};
end