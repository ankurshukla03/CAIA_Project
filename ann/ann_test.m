close all;

% load data
%load sat_data.mat
load single_data.mat
p = in_data;
t = test_data;

%init
net = newff(p, t,[5], {'tansig' 'logsig'}, 'trainrp', '', 'mse', {}, {}, '');
%net = newff(p, t, [10], {'tansig' 'logsig'}, 'trainrp', '', 'mse', {}, {}, '');
% % net.performFcn = 'rmse';
close all
net = init(net);
net.trainParam.lr = 1;
% train
[trained_net, stats] = train(net, p, t);

% uncomment to save nn model for later use
% save trained_net;