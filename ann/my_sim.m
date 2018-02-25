function map_estimation = my_sim(net, image)
    if net.inputs{1}.size == 27
        map_estimation = my_sim_neighbors(net, image, 3);
    elseif trained_net.inputs{1}.size == 3
        map_estimation = my_sim_single(net, image);
    end
end

function map_estimation = my_sim_single(net, img)
    cols = size(img, 1);
    rows = size(img, 2);
    red = img(:,:,1);
    green = img(:,:,2);
    blue = img(:,:,3);
    map_estimation = zeros(cols, rows);
    progressbar('i','j');
    for i=1:rows
        for j=1:cols
            input = [red(j,i);green(j,i);blue(j,i)];
            map_estimation(j,i) = sim(net, input);
            progressbar([], j/cols);
        end
        progressbar(i/rows, []);
    end
end

function map_estimation = my_sim_neighbors(net, img, ksize)
    offset = (ksize - 1) / 2;
    cols = size(img, 1);
    rows = size(img, 2);
    red = img(:,:,1);
    green = img(:,:,2);
    blue = img(:,:,3);
    map_estimation = zeros(cols, rows);
    progressbar('i','j');
    for i=offset+1:(size(img, 1)-offset)
        for j=offset+1:(size(img,2)-offset)
            r_in = get_1d_range(red,   i,j, offset);
            g_in = get_1d_range(green, i,j, offset);
            b_in = get_1d_range(blue,  i,j, offset);
            input = [r_in g_in b_in]';
            map_estimation(j,i) = sim(net, input);
            progressbar([], j/cols);
        end
        progressbar(i/rows, []);
    end
end