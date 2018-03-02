function map_estimation = my_sim_batch(net, img, kernel)
    if net.inputs{1}.size == 27
        map_estimation = my_sim_neighbors(net, img, 3, kernel);
    elseif trained_net.inputs{1}.size == 3
        map_estimation = my_sim_single(net, img);
    end
end

% TODO: this function is not updated from precise
function map_estimation = my_sim_single(net, img)
    rows = size(img, 1);
    cols = size(img, 2);
    red = img(:,:,1);
    green = img(:,:,2);
    blue = img(:,:,3);
    map_estimation = zeros(rows, cols);
    progressbar('i','j');
    for i=1:rows
        for j=1:cols
            input = [red(i,j);green(i,j);blue(i,j)];
            map_estimation(i,j) = sim(net, input);
            progressbar([], j/cols);
        end
        progressbar(i/rows, []);
    end
    progressbar(1,1);
end

function map_estimation = my_sim_neighbors(net, img, inputsize, kernel)
    offset = (kernel - 1) / 2;
    input_offset = (inputsize - 1)/2;
    rows = size(img, 1);
    cols = size(img, 2);
    red   = img(:,:,1);
    green = img(:,:,2);
    blue  = img(:,:,3);
    map_estimation = zeros(rows, cols);
    progressbar('i','j');
    for i=offset+1:kernel:rows-offset
        for j=offset+1:kernel:cols-offset
            r_in = get_1d_range(red,   i,j, input_offset);
            g_in = get_1d_range(green, i,j, input_offset);
            b_in = get_1d_range(blue,  i,j, input_offset);
            input = [r_in g_in b_in]';
            map_estimation(i-offset:i+offset,j-offset:j+offset) = ...
                ones(kernel, kernel) .* sim(net, normalize(input));
            progressbar([], j/cols);
%             figure(1),
%             imagesc(map_estimation);
        end
        progressbar(i/rows, []);
    end
    progressbar(1,1);
end