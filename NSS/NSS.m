function Score = NSS(img)
%% The code is used to compute the objective score of contrast distorted images. Please cite the following
%% paper when using the code (We use the code of SVR from http://www.csie.ntu.edu.tw/~cjlin/libsvm/ for machine learning. ).
%% Yuming Fang, Kede Ma, Zhou Wang, Weisi Lin, Zhijun Fang, and Guangtao Zhai, 'No-Reference Quality
%% Assessment of Contrast-Distorted Images Based on Natural Scene Statistics', IEEE Signal Processing
%% Letter, 22(7): 838-842, 2015.

%load ./CSIQ.mat; %% You can also load the files of 'CSIQ.mat' or 'TID13.mat' if you want to use CSIQ or TID2013 database for training.
%train_data = Data(:,[1:5]);
%train_label = Data(:, 6);
%model = svmtrain(train_label, train_data, '-s 3');  % train
load CID2013model.mat
disim = img;

if numel(size(disim))>2     %% Is a rgb image ?
    dis_file_gray = rgb2gray(disim);
else
    dis_file_gray = disim;
end

i = 1;
    %% mean value
   mean_tmp = round(mean2(dis_file_gray));
   Value(i, 1) = 1/(sqrt(2*pi)*26.0625)*exp(-(mean_tmp-118.5585)^2/(2*26.0625^2));

   %% std value
   std_tmp = round(std2(dis_file_gray));
   Value(i, 2) = 1/(sqrt(2*pi)*12.8584)*exp(-(std_tmp-57.2743)^2/(2*12.8584^2));

  %% entropy value
   entropy_tmp = entropy(dis_file_gray);
   Value(i, 3) = 1/0.2578*exp((entropy_tmp-7.5404)/0.2578)*exp(-exp((entropy_tmp-7.5404)/0.2578));

  %% kurtosis value
   kurtosis_tmp = kurtosis(double(dis_file_gray(:)));
   Value(i, 4) = sqrt(19.3174/(2*pi*kurtosis_tmp^3))*exp(-19.3174*(kurtosis_tmp-2.7292)^2/(2*(2.7292^2)*kurtosis_tmp));

  %% skewness value
   skewness_tmp = skewness(double(dis_file_gray(:)));
   Value(i, 5) = 1/(sqrt(2*pi)*0.6319)*exp(-(skewness_tmp-0.1799)^2/(2*0.6319^2));

test_label = 0;
[predicted_label, accuracy, decision_values] = svmpredict(test_label, Value, model);
Score = predicted_label;
clc
%disp('Score:');
%disp(Score );
