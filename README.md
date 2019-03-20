# Blind Image Quality Assessment for Low Contrast Images
This repo compiles various blind image quality assessment methods focused on contrast evaluation. Only code that works in Python or Octave.

# NSS 

Source code from https://sites.google.com/site/leofangyuming/Home/nrqacdi

Yuming Fang, Kede Ma, Zhou Wang, Weisi Lin, Zhijun Fang, and Guangtao Zhai, 'No-Reference Quality Assessment of Contrast-Distorted Images Based on Natural Scene Statistics', IEEE Signal Processing Letter, 22(7): 838-842, 2015

# MDM

Source code from http://www.synchromedia.ca/system/files/MDM.zip

Hossein Ziaei Nafchi and Mohamed Cheriet, 'Efficient No-Reference Quality Assessment and Classification Model for Contrast Distorted Images', IEEE Transactions on Broadcasting, 2018.

# CEIQ

Source code from https://github.com/mtobeiyf/CEIQ

Jia Yan, Jie Li, Xin Fu, 'No-Reference Quality Assessment of Contrast-Distorted Images using Contrast Enhancement'. Journal of Visual Communication and Image Representation, 2018 (Under review)

# Usage

```
img = imread('sample1.jpg')
mdm_score = MDM(img)
nss_score = NSS(img)
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
