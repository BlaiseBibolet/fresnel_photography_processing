% Performs Wiener deconvolution given an image, PSF, and esitmated Noise to
% Signal Ratio
function x_prime = wiener_deconvolution(img, psf, nsr)
 
    % Inputs:
    %   blurred_img  - The noisy, blurry input image (2D matrix)
    %   psf          - The Point Spread Function (impulse response)
    %   nsr          - Noise-to-Signal power Ratio (scalar or 2D matrix)
    
    % Output:
    %   restored_img -  result

    img_sz = size(img);
    psf_sz = size(psf);
    
    if any(psf_sz > img_sz)
        error('DeconvolutionError:InvalidSize', ...
            'The PSF dimensions cannot be larger than the image dimensions');
    end

    % Transform the image to the frequency domain (FFT)
    IMG = fft2(img);

    % Transform the PSF to the frequency domain, padding the psf to match
    % the image dimensions to ensure pointwise division, and circularly
    % shifting the psf
    PSF = manual_psf2otf(psf, img_sz);

    % Apply the Wiener Filter Equation
    % Formula: W = conj(H) / (|H|^2 + NSR)
    % This is the frequency domain representation of the filter
    H_conj = conj(PSF);
    H_mag_sq = abs(PSF).^2;
    
    G = H_conj ./ (H_mag_sq + nsr);

    % Perform the filtering (multiplication in frequency domain)
    X_prime = G .* IMG;

    % Transform back to the spatial domain (Inverse FFT)
    x_prime = real(ifft2(X_prime));
end

% Helper function to create an optical transfer function of a point
% spread function, shifted and padded to a given size

function otf = manual_psf2otf(psf, sz)

    % Inputs:
    %   psf    - point spread function
    %   sz     - size of final optical transfer function

    % Output:
    %   otf    - optical Transfer function

    % Pad the PSF with zeros to match the image size 
    psf_padded = zeros(sz);
    [ph, pw] = size(psf);
    psf_padded(1:ph, 1:pw) = psf;
    
    % Circularly shift the PSF so the center is at (1,1)
    % This prevents a spatial shift in the final deblurred image
    shift_amount = -floor([ph, pw] / 2);
    psf_shifted = circshift(psf_padded, shift_amount);
    
    % Compute the FFT
    otf = fft2(psf_shifted);
end