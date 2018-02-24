close all;

%% collect filenames into arrays
imgs = dir('images/*.png');
assert(mod(length(imgs), 2) == 0, 'there is an unequal number of train/test images');

data_size = length(imgs)/2;

in_data = [[]];
test_data = [[]];
i = 1;
path = 'images/';
% progressbar('imgs i');
for fi=imgs'
    if ~isempty(regexp(fi.name, '_TEST', 'match'))
    %if ~isempty(regexp(fi.name, 'TEST', 'split'))
        train_name = strcat(path, fi.name(1:21), '.png');
        test_name = strcat(path, fi.name);
        
        train_img = imread(train_name);
        test_img = plain_to_test(imread(test_name));
        [p, t] = preprocess_single_rgb(train_img, test_img);
        in_data = [p; in_data]; %#ok
        test_data = [t; test_data]; %#ok
    end
    i = i + 1;
%     progressbar(i/data_size);
end

save('sat_data.mat', 'in_data', 'test_data');