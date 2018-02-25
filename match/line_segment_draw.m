% adapted from https://stackoverflow.com/a/2465015
function img = line_segment_draw(img, x, y)
    nPoints = max(abs(diff(x)), abs(diff(y)))+1;    % Number of points in line
    rIndex = round(linspace(y(1), y(2), nPoints));  % Row indices
    cIndex = round(linspace(x(1), x(2), nPoints));  % Column indices
    index = sub2ind(size(img), rIndex, cIndex);     % Linear indices
    img(index) = 255;  % Set the line points to white
end