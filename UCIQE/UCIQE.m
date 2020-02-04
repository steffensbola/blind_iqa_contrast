function UCIQE=UCIQE(rgb_in, c1, c2, c3)
%Calculate UCIQE (Underwater Colour Image Quality Evaluation).
%
%Usage
%     UCIQE_value = UCIQE(RGB_Image)
%  The implemented algorithm is based on the paper of M. Yang et al.:
%  An Underwater Color Image Quality Evaluation Metric.
%
% Implemented by Z. J. Wang, UAV Lab, National University of Singapore
% Sept. 2018
% Modified at Dec. 2019

if  ~exist( 'c1', 'var' )
    c1 = 0.4680;
end

if  ~exist( 'c2', 'var' )
    c2 = 0.2745;
end

if  ~exist( 'c3', 'var' )
    c3 = 0.2576;
end

lab = rgb2lab_n(rgb_in);
l = lab(:,:,1);
a = lab(:,:,2);
b = lab(:,:,3);

chroma = sqrt(a.^2 + b.^2);
% average of chroma
u_c = mean(chroma(:));
% variance of chroma
sigma_c = sqrt(mean(mean(chroma.^2 - u_c.^2)));

saturation = chroma ./ l;
% average of saturation
u_s = mean(saturation(:));

contrast_l = max(l(:)) - min(l(:));

UCIQE = c1 * sigma_c + c2 * contrast_l + c3 *  u_s;
