function [lightOrderError, mask] = LOE(raw, enhanceResult)
% Naturalness Preserved Enhancement Algorithm for Non-Uniform Illumination Images 
##@article{wang2013naturalness,
##  title={Naturalness preserved enhancement algorithm for non-uniform illumination images},
##  author={Wang, Shuhang and Zheng, Jin and Hu, Hai-Miao and Li, Bo},
##  journal={IEEE Transactions on Image Processing},
##  volume={22},
##  number={9},
##  pages={3538--3548},
##  year={2013},
##  publisher={IEEE}
##}
% input image
% enhanced image
% L O E=\frac{1}{m} \sum_{x=1}^{m} R D(x)
% R D(x)=\sum_{y=1}^{m} U(\mathbf{L}(x), \mathbf{L}(y)) \oplus U\left(\mathbf{L}^{\prime}(x), \mathbf{L}^{\prime}(y)\right)
% Lightness Distortion - relative order difference of the lightness between the original image P and its enhanced version P


assert(nargin == 2);
if max(raw) <= 1.
  raw *=255;
endif
if max(enhanceResult) <= 1.
  enhanceResult *=255;
endif

% resize
raw = im2uint8(raw); % imresize(raw,[100 100])
enhanceResult = im2uint8(enhanceResult); % imresize(enhanceResult,[100 100])


rawL = max(raw,[],3);
[nRow, nCol] = size(rawL);

enhanceResultL = max(enhanceResult,[],3);

N = 100;
sampleRow = round( linspace(1,nRow,N) ); % 100 samples
sampleCol = round( linspace(1,nCol,N) );
rawL = rawL(sampleRow, sampleCol); % downsample
enhanceResultL = enhanceResultL(sampleRow, sampleCol);

error = 0;
mask = zeros(N,N);
for r = 1:N %size(rawL,1)*size(rawL,2)   %numel(rawL)
    for c = 1:N
        mapRawOrder = rawL>=rawL(r,c);
        mapResultOrder = enhanceResultL>=enhanceResultL(r,c);
        mapError = xor(mapRawOrder,mapResultOrder);
        error = error + sum(mapError(:));
        mask(r,c) = sum(mapError(:));
    end
end

lightOrderError = error / (N*N); %(size(raw,1)*size(raw,2));

end
