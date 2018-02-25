function map_estimation = my_sim(net, image)
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