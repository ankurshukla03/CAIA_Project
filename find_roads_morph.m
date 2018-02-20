function [img] = find_roads_morph(mimg)
ses = structuring_elems(5);
for i = 1:numel(ses)
    se = ses{i};
    img = imclose(imopen(mimg, se), se);
end
end

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