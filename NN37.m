X = csvread('/home/guillem/loc/Assoc37.csv')
y = csvread('/home/guillem/loc/Rew37binary.csv')

% This script assumes these variables are defined:
%
%   X - input data.
%   y - target data.

x = X';
t = y';

% Choose a Training Function
% For a list of all training functions type: help nntrain
% 'trainlm' is usually fastest.
% 'trainbr' takes longer but may be better for challenging problems.
% 'trainscg' uses less memory. Suitable in low memory situations.
trainFcn = 'trainscg';  % Levenberg-Marquardt backpropagation.

% Create a Fitting Network
hiddenLayerSize = 25;
net = fitnet(hiddenLayerSize,trainFcn);

% Setup Division of Data for Training, Validation, Testing
net.divideParam.trainRatio = 100/100;
net.divideParam.valRatio = 0/100;
net.divideParam.testRatio = 0/100;

% Train the Network
[net,tr] = train(net,x,t);

% Test the Network
y = net(x);
e = gsubtract(t,y);
performance = perform(net,t,y)

% View the Network
view(net)

% Plots
% Uncomment these lines to enable various plots.
figure, plotperform(tr)
%figure, plottrainstate(tr)
%figure, ploterrhist(e)
figure, plotregression(t,y)
%figure, plotfit(net,x,t)

