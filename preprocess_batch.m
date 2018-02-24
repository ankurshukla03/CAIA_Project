% this shouldn't take more memory than opening up all the images in the
% folder.

%% collect filenames into arrays
imgs = dir('images/*.png');
assert(mod(length(imgs), 2) == 0, 'there is an unequal number of train/test images');

data_size = length(imgs)/2;

in_data = [[]];
test_data = [[]];
i = 1;
path = 'images/';
progressbar('imgs i');
for fi=imgs'
    if ~isempty(regexp(fi.name, '_TEST', 'match'))
        train_name = strcat(path, fi.name(1:21), '.png');
        % get the coordinates
        name = regexp(fi.name, '_TEST', 'split');
        name = name{1};
        % file names
        train_name = strcat(path, name, '.png');
        test_name = strcat(path, fi.name);
        
        % open the images and grab the rgb values
        train_img = imread(train_name);
        test_img = plain_to_test(imread(test_name));
        % input and target
        [p, t] = preprocess_single_rgb(train_img, test_img);
        in_data = [p; in_data]; %#ok
        test_data = [t; test_data]; %#ok
        i = i + 1;
        progressbar(i/data_size);
    end
end

% save the data to a mat file for loading later
save('sat_data.mat', 'in_data', 'test_data');