# Blind Image Quality Assessment for Low Contrast Images
This repo compiles various blind image quality assessment methods focused on contrast evaluation. Only code that works in Python or Octave.

# NSS 

Source code from https://sites.google.com/site/leofangyuming/Home/nrqacdi

Yuming Fang, Kede Ma, Zhou Wang, Weisi Lin, Zhijun Fang, and Guangtao Zhai, 'No-Reference Quality Assessment of Contrast-Distorted Images Based on Natural Scene Statistics', IEEE Signal Processing Letter, 22(7): 838-842, 2015

# MDM

Source code from http://www.synchromedia.ca/system/files/MDM.zip.

Hossein Ziaei Nafchi and Mohamed Cheriet, 'Efficient No-Reference Quality Assessment and Classification Model for Contrast Distorted Images', IEEE Transactions on Broadcasting, 2018.

# CEIQ

Source code from https://github.com/mtobeiyf/CEIQ

Jia Yan, Jie Li, Xin Fu, 'No-Reference Quality Assessment of Contrast-Distorted Images using Contrast Enhancement'. Journal of Visual Communication and Image Representation, 2018 (Under review) Pre-Print available at https://arxiv.org/abs/1904.08879

# LOE

Source code from https://github.com/baidut/BIMEF

Wang, S., Zheng, J., Hu, H.M. and Li, B., 2013. Naturalness preserved enhancement algorithm for non-uniform illumination images. IEEE Transactions on Image Processing, 22(9), pp.3538-3548.

# UCIQUE

Source code from https://github.com/paulwong16/UCIQE

Yang, M. and Sowmya, A., 2015. An underwater color image quality evaluation metric. IEEE Transactions on Image Processing, 24(12), pp.6062-6071.


# Usage

```
img = imread('sample.jpg')
mdm_score = MDM(img) % larger is better
nss_score = NSS(img) % larger is better
ceiq_score = CEIQ(img) % larger is better
loe_score = LOE(original_img, contrast_enhanced_img) % does not require a 'ground-truth', smaller is better
uciqe_score = UCIQE(img) %higher is better (or, as in the paper, the camera is closer to the observed scene)
```

# Dependencies

```
wget https://www.csie.ntu.edu.tw/~cjlin/libsvm/index.html#download
unzip libsvm
cd libsvm/matlab
octave-cli make
```

# Dataset

Need a dataset to put these metrics to prove?

Have a look at https://github.com/steffensbola/a6300_multi_exposure_dataset
