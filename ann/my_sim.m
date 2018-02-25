function map_estimation = my_sim(net, image)
    if net.inputs{1}.size == 27
        map_estimation = my_sim_neighbors(net, image, 3);
    elseif trained_net.inputs{1}.size == 3
        map_estimation = my_sim_single(net, image);
    end
end

function map_estimation = my_sim_single(net, image)
    cols = size(image, 1);
    rows = size(image, 2);
    red = image(:,:,1);
    green = image(:,:,2);
    blue = image(:,:,3);
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

function map_estimation = my_sim_neighbors(net, image, ksize)
    offset = (ksize - 1) / 2;
    cols = size(image, 1);
    rows = size(image, 2);
    red = image(:,:,1);
    green = image(:,:,2);
    blue = image(:,:,3);
    map_estimation = zeros(cols, rows);
    progressbar('i','j');
    for i=offset+1:rows-offset
        for j=offset+1:cols-offset
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