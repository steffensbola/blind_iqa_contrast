addpath('\SVM'); % add path to SVM folder

load('CSIQ_mos');
MOS = CSIQ_mos;

noImages = 116;
scores = zeros(noImages, 1);

% load feature vectors
load('MDMfeaturesOnCSIQ_116x3.mat'); % you may use feature vectors of another metric
featvec = MDMfeaturesOnCSIQ_116x3;
featvecORG = MDMfeaturesOnCSIQ_116x3;

% Standard 1000 times split in order to make the results reproducible
load('Splits1000x116.mat');

% Choose SVR parameters
c = 1;
g = 0.05;


noTIMES = 1000;

z1 = zeros(noTIMES, 3);

for num = 1 : noTIMES
    
    index1 = Splits1000x116(num, :);
    
    rat1 = round(0.2 * noImages); % 20% train
    index20 = index1(1 : rat1);
        
    rat2 = round(0.5 * noImages); % 50% train
    index50 = index1(1 : rat2);
    
    rat3 = round(0.8 * noImages); % 80% train
    index80 = index1(1 : rat3);
    
    %% 20% train
    featvec = featvecORG;
    [featvec1, mu, sigma] = featureNormalize(featvec(index20, :));
    
    str = ['-s 3 -c ' num2str(c) ' -g ' num2str(g) ' -q'];
    model = svmtrain(MOS(index20), featvec1, str);
        
    for i = 1 : 116
        featvec(i, :) = ( featvec(i, :) - mu ) ./ sigma;
    end
    
    test_label = zeros(noImages, 1);
    [scores, ~, ~] = svmpredict(test_label, featvec, model, '-q');
    
    s = corr(scores(index1(rat1 + 1 : end)), MOS(index1(rat1 + 1 : end)), 'type', 'Spearman');
    z1(num, 1) = s;
    
    %% 50% train
    featvec = featvecORG;
    [featvec1, mu, sigma] = featureNormalize(featvec(index50, :));
    
    str = ['-s 3 -c ' num2str(c) ' -g ' num2str(g) ' -q'];
    model = svmtrain(MOS(index50), featvec1, str);
    
    for i = 1 : 116
        featvec(i, :) = ( featvec(i, :) - mu ) ./ sigma;
    end
    
    test_label = zeros(noImages, 1);
    [scores, ~, ~] = svmpredict(test_label, featvec, model, '-q');
    
    s = corr(scores(index1(rat2 + 1 : end)), MOS(index1(rat2 + 1 : end)), 'type', 'Spearman');
    z1(num, 2) = s;
    
    %% 80% train
    featvec = featvecORG;
    [featvec1, mu, sigma] = featureNormalize(featvec(index80, :));
    
    str = ['-s 3 -c ' num2str(c) ' -g ' num2str(g) ' -q'];
    model = svmtrain(MOS(index80), featvec1, str);
    
    for i = 1 : 116
        featvec(i, :) = ( featvec(i, :) - mu ) ./ sigma;
    end
    
    test_label = zeros(noImages, 1);
    [scores, ~, ~] = svmpredict(test_label, featvec, model, '-q');
    
    s = corr(scores(index1(rat3 + 1 : end)), MOS(index1(rat3 + 1 : end)), 'type', 'Spearman');
    z1(num, 3) = s;
         
end

z1(isnan(z1)) = 0;
% 20% 50% 80%
disp([median(z1(:, 1))  median(z1(:, 2)) median(z1(:, 3))])


%% Uncomment to generage different set of train-test (Splits1000x116) without overlap between content of train and test

% load('C:\Users\synchro\Dropbox\metrics\Fast\OptALL\Contrast\rangesCSIQ.mat');
% Splits1000x116 = zeros(1000, 116);
% for i = 1 : 1000
%     q = [];
%     r = randperm(30, 30);
%     for j = 1 : 30
%         q = [q rangesCSIQ(r(j), 1) : rangesCSIQ(r(j), 2)];
%     end
%     Splits1000x116(i, :) = q;
% end

% save Splits1000x116 Splits1000x116