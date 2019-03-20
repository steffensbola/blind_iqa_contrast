function [f1, f2, f3] = MDM(Y1)
% Minkowski Distance based Metric (MDM)
% MDM usage: Quality assessment of contrast distorted images

% By: Hossein Ziaei Nafchi, September 2017
% hossein.zi@synchromedia.ca
% Synchromedia Lab, ETS, Canada

% The code can be modified, rewritten and used for academic purposes
% without obtaining permission of the author.

% Y1: Distorted image (color)
% f1-f3: three features of MDM

phoo = 64; % phoo = 128;
P = 8; % P = 8;

[n, m, ~] = size(Y1);
Down_step = max( 2, round( min(n, m) / 512 ) );

Y1 = Y1(1 : Down_step : end, 1 : Down_step : end, 1 : 3);

f3 = entropy(rgb2gray(Y1));

Y1 = im2double(Y1);
Y2 = 1 - Y1;

Y1 = fastPower(Y1, P);
Y2 = fastPower(Y2, P);

diff = ( Y1(:) - mean(Y1(:)) );
Pdiff = fastPower(diff, phoo);

f1 = ( 1 / numel(Y1) * sum(Pdiff) ) ^ (1 / phoo);
f1 = f1 ^ 0.25;

diff = ( Y2(:) - mean(Y2(:)) );
Pdiff = fastPower(diff, phoo);
f2 = ( 1 / numel(Y2) * sum(Pdiff) ) ^ (1 / phoo);
f2 = f2 ^ 0.25;


function NP = fastPower(N, P)
maxP = 2 ^ fix(log2(P));
R = P - maxP;
NP = N;
while maxP > 1
    NP = NP .* NP;
    maxP = fix(maxP / 2);
    if R >= maxP
        NP = NP .* N;
        R = R - maxP;
    end
end
return