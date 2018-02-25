close all;

% load data
load sat_data.mat
p = in_data;
t = test_data;

% init
net = newff(p, t, [10], {'tansig' 'logsig'}, 'trainrp', '', 'mse', {}, {}, '');
% net.performFcn = 'rmse';
net = init(net);

% train
[trained_net, stats] = train(net, p, t);

% uncomment to save nn model for later use
% save trained_net;
