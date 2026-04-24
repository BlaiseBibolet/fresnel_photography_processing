# fresnel_photography_processing

This includes 3 matlab scripts to assist batch deblurring of images taken with a fresnel lens camera system. It can be applied to other camera sensors as long as there is a PSF and image taken with the same focal length and focus. 

wiener_deconvolution(img, psf, nsr) is my implementation of wiener deconvolution given an initial image (img), the systems Point Spread function (psf) and an estimated Noise to Signal Ration (nsr).

    % Inputs:
    %   blurred_img  - The noisy, blurry input image (2D matrix)
    %   psf          - The Point Spread Function (impulse response)
    %   nsr          - Noise-to-Signal power Ratio (scalar or 2D matrix)
    
    % Output:
    %   restored_img -  result

    
crop_moon(img, sz) crops an image to the largest 'blob' in an image given an initial image(img) as a 2D matrix and the final cropped size(sz) as a row vector sz = [rows, columns] in pixels.

    % Inputs:
    %   img        - Image to be cropped (2D matrix)
    %   size       - The size of the final image row vector [rows,columns]
    
    % Output:
    %   img_crop   - Cropped image (2D matrix)

BatchDeconvolution deconvolves and crops any amount of images with a certain extension in a given folder and exports all processed images to a different folder. Note that the crop function can be turned on and off by simply commenting and uncommenting the crop_size variable inthe constants section
