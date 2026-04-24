clear; clear all;

% Load the image from a given filepath
img = im2double(imread('data2/moon1.jpg'));

% Load the PSF from a given path
psf_raw = im2double(imread('data2/PSF/PSF2.jpg'));

% Set the Noise to Signal Ratio
NSR = .00005;

% Set crop size if being cropped
crop_size = [800, 800];

% Normalize the PSF
PSF = psf_raw / sum(psf_raw(:)); 

% Apply Wiener deconvolution to the cample images
I = wiener_deconvolution(img,PSF, NSR);


% Crop the result
J = crop_moon(I,crop_size);

% Display the results

tiledlayout(2,2);

nexttile;
imshow(psf_raw);
title('Point Spread Function');

nexttile;
imshow(img);
title('Raw Camera Image');

nexttile;
imshow(I,[]);
title('Processed Image');

nexttile;
imshow(J,[]);
title('Processed and Cropped Image');
