function [img] = find_roads_match(mimg)
    r = 10;
    gap_thresh = 2;
    stride = 2;
    img = imbinarize(mimg);
    width = size(img, 2);
    height = size(img, 1);
    figure(3)
    imshow(img);
    matched = zeros(size(img));
    progressbar('angle', 'x', 'y');
    for angle = -90:2:90
        for x=1:stride:width
           for y=1:stride:height
               if img(y,x) == 1
                    nx = clamp(round(x - r * cos(angle * pi / 180)), width);
                    ny = clamp(round(y - r * sin(angle * pi / 180)), height);
                    xs = [x, nx];
                    ys = [y, ny];
                    profile = improfile(img, xs, ys);
                    len_p = length(profile);
                    [one_count, ~, max_gap] = count_segments(profile);
                    % at least 75% ones and no gaps > gapthresh
                    if one_count > len_p * 0.75 && max_gap <= gap_thresh
                        matched = line_segment_draw(matched, xs, ys);
                    end
               end
               progressbar([], [], y/height);
           end
           progressbar([], x/width, []);
       end % end j
       progressbar((angle+90)/180, [], []);
       figure(2),
       imshow(matched);
    end % end angle
    img = matched;
end

function val = clamp(sample, maximum)
    val = min(maximum, max(sample, 1));
end