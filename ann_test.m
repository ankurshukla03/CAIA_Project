close all;

% load data
load sat_data.mat
p = in_data;
t = test_data;

% init
net = newff(p, t, [5], {'tansig' 'purelin'}, 'trainrp', '', 'mse', {}, {}, '');
net = init(net);

% train
[trained_net, stats] = train(net, p, t);
