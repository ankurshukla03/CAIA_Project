function [img] = find_roads_match(mimg)
    r = 10;
    gap_thresh = 3;
%     offset = r/2;
    img = imbinarize(mimg);
    figure(3)
    imshow(img);
    matched = zeros(size(img));
    progressbar('x', 'y', 'angle');
    for x=1:size(img, 1)
       for y=1:size(img, 2)
           for angle = -90:5:90
               if img(x,y) == 1
                    nx = round(x - r * cos(angle * pi / 180));
                    ny = round(y - r * sin(angle * pi / 180));
                    if nx <= 0 || ny <= 0 || nx > size(img,1) || ny > size(img,2) || img(nx,ny) ~= 1
                        continue;
                    end
                    xs = [x, nx];
                    ys = [y, ny];
                    profile = improfile(img, xs, ys);
                    if all(profile == 1)
                        matched = line_segment_draw(matched, xs, ys);
                        figure(2)
                        imshow(matched);
                    end
               end
               progressbar([], [], (angle+90)/180);
           end % end angle
           progressbar([], y/size(img,2), []);
       end % end j
       progressbar(x/size(img,1), [], []);
    end % end i
    img = matched;
end

function [one_count, zero_count, max_gap] = count_segments(line)
    cur_gap = 0;
    max_gap = 0;
    zero_count = 0;
    one_count = 0;
    prev = 1;
    for i=1:length(line)
        cur = line(1);
        if cur == 1
            one_count = one_count + 1;
        else 
            zero_count = zero_count + 1;
        end

        % gap start?
        if prev == 1 && cur == 0
            cur_gap = 1;
        % gap end
        elseif prev == 0 && cur == 1
            if cur_gap > max_gap
                max_gap = cur_gap;
            end
        % traversing a gap
        else % 0, 0
            cur_gap = cur_gap + 1;
        end
        prev = cur;
    end
end

% adapted from https://stackoverflow.com/a/2465015
function img = line_segment_draw(img, x, y)
    nPoints = max(abs(diff(x)), abs(diff(y)))+1;    % Number of points in line
    rIndex = round(linspace(y(1), y(2), nPoints));  % Row indices
    cIndex = round(linspace(x(1), x(2), nPoints));  % Column indices
    index = sub2ind(size(img), rIndex, cIndex);     % Linear indices
    img(index) = 255;  % Set the line points to white
end