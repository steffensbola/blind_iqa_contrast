%addpath('\SVM'); % add path to SVM folder

load('CCID2014_mos.mat'); % load mos values
MOS = CCID2014_mos;

noImages = 655;
scores = zeros(noImages, 1);

% load feature vector for all of the images (here 655)
load('MDMfeaturesOnCCID2014_655x3.mat'); % you may use feature vectors of another metric
featvec = MDMfeaturesOnCCID2014_655x3;
featvecORG = MDMfeaturesOnCCID2014_655x3; % backup

% Standard 1000 times split in order to make the results reproducible
load('Splits1000x655.mat');

% SVR parameters
c = 1;
g = 0.05;

% number of train-test
noTIMES = 1000;

z1 = zeros(noTIMES, 3);

for num = 1 : noTIMES
    
    index1 = Splits1000x655(num, :);
    
    rat1 = round(0.2 * noImages); % 20% train
    index20 = index1(1 : rat1);
    
    rat2 = round((8 / 15) * noImages); % ~~ 50% train
    index50 = index1(1 : rat2);
    
    rat3 = round(0.8 * noImages); % 80% train
    index80 = index1(1 : rat3);
    
    
    %% 20% train
    featvec = featvecORG;
    [featvec1, mu, sigma] = featureNormalize(featvec(index20, :));
    
    str = ['-s 3 -c ' num2str(c) ' -g ' num2str(g) ' -q'];
    model = svmtrain(MOS(index20), featvec1, str);
    
    for i = 1 : 655
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
    
    for i = 1 : 655
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
    
    for i = 1 : 655
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


%% Uncomment to generage different set of train-test (Splits1000x655) without overlap between content of train and test

%load('BEG_ENDindices655_15.mat'); % 15 is number of reference images in CCID2014 dataset

% Splits1000x655 = zeros(1000, 655);
% for i = 1 : 1000
%     r15 = randperm(15, 15);
%     s = 0;
%     for j = 1 : 15
%         a = BEG_ENDindices655_15(r15(j), 1) : BEG_ENDindices655_15(r15(j), 2);
%         Splits1000x655(i, s + 1 : s + size(a, 2)) = a;
%         s = s + size(a, 2);
%     end
% end

% save Splits1000x655 Splits1000x655