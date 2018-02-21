function [img] = find_roads_match(mimg)
    r = 10;
    gap_thresh = 5;
    stride = 2;
%     offset = r/2;
    img = imbinarize(mimg);
    figure(3)
    imshow(img);
    matched = zeros(size(img));
    progressbar('x', 'y', 'angle');
    for x=1:stride:size(img, 2)
       for y=1:stride:size(img, 1)
           for angle = -90:3:90
               if img(x,y) == 1
                    nx = round(x - r * cos(angle * pi / 180));
                    ny = round(y - r * sin(angle * pi / 180));
                    if nx <= 0 || ny <= 0 || nx > size(img,2) || ny > size(img,1) || img(nx,ny) ~= 1
                        continue;
                    end
                    xs = [x, nx];
                    ys = [y, ny];
                    profile = improfile(img, xs, ys);
                    [one_count, ~, max_gap] = count_segments(profile);
                    % at least 60% ones and no gaps > gapthresh
                    if one_count > r * 0.75 && max_gap <= gap_thresh
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