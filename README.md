# fresnel_photography_processing

This includes 3 matlab scripts to assist batch deblurring of images taken with a fresnel lens camera system. It can be applied to other camera sensors as long as there is a PSF and image taken with the same focal length and focus. 

It uses the following formulas for Wiener deconvolution:

1. $$y = h*x+v
$$

2. $$W = \frac{H^*}{\left|{H}\right|^2+NSR}$$

3. $$\hat{x} = w*y => \hat{X} = W\cdot Y$$

Where,

- y - Observed image (Raw camera output in our case)​

- h - Impulse response of a linear, time-invariant filter (PSF)​

- x - Unknown signal (True Image)

- v - System noise independent of x

- $\hat{x}$ - Approximation of the unknown signal with minimum mean square error (Program output)​

- w - Deconvolution filter ​

Y,H, $\hat{X}$ ,G – Fourier Transforms of y,h, $\hat{x}$ ,g


wiener_deconvolution(img, psf, nsr) is my implementation of wiener deconvolution given an initial image (img), the systems Point Spread function (psf) and an estimated Noise to Signal Ration (nsr).

    function x_prime = wiener_deconvolution(img, psf, nsr)

    % Inputs:
    %   blurred_img  - The noisy, blurry input image (2D matrix)
    %   psf          - The Point Spread Function (impulse response)
    %   nsr          - Noise-to-Signal power Ratio (scalar or 2D matrix)
    
    % Output:
    %   x_prime -  result

    
crop_moon(img, sz) crops an image to the largest 'blob' in an image given an initial image(img) as a 2D matrix and the final cropped size(sz) as a row vector sz = [rows, columns] in pixels.

    function moon_cropped = crop_moon(img, sz)

    % Inputs:
    %   img        - Image to be cropped (2D matrix)
    %   size       - The size of the final image row vector [rows,columns]

    % Output:
    %   img_crop   - Cropped image (2D matrix)

BatchDeconvolution deconvolves and crops any amount of images with a certain extension in a given folder and exports all processed images to a different folder. Note that the crop function can be turned on and off by simply commenting and uncommenting the crop_size variable inthe constants section
