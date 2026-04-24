clear; clear all;

% Load the image from a given filepath
img = im2double(imread('data1/ResTarget.PNG'));

% Load the PSF from a given path
psf_raw = im2double(imread('data1/PSF1.PNG')); 

% Set the Noise to Signal Ratio
NSR = .00005;

% Normalize the PSF
PSF = psf_raw / sum(psf_raw(:)); 

% Apply Wiener deconvolution to the cample images
I = wiener_deconvolution(img,PSF, NSR);

% Display results
tiledlayout(1,3);

nexttile;
imshow(psf_raw);
title('Point Spread Function');

nexttile;
imshow(img);
title('Raw Camera Image');

nexttile;
imshow(I);
title('Processed Image');
