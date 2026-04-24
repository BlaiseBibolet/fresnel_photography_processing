
% Code to batch apply weiner deconvolution to a set of photos and crop it
% around the moon if desired

clear; clear all;

%% Setup Folders and PSF
input_folder = 'data2/'; % Point to folder where raw images are stored

% Points to folder where processed images will be stored. If the folder
% does not exist, one will be created. 
output_folder = 'processed/'; 

% Creates export folder if the selected one above does not exist
if ~exist(output_folder, 'dir'), mkdir(output_folder); end

% Load and normalize your Star PSF
psf_raw = im2double(imread('data2/PSF/PSF2.jpg'));
PSF = psf_raw / sum(psf_raw(:));

% Get list of all images with the specified extension in the folder
file_list = dir(fullfile(input_folder, '*.jpg')); % Change extension if needed

% Define Constants
NSR = .00005; % noise-to-signal ratio
crop_size = [700, 700]; % Crop size - comment out if no crop wanted


% Processing Loop over every image
fprintf('Starting batch deconvolution for %d images...\n', length(file_list));

for i = 1:length(file_list)
    % Load current image
    file = file_list(i).name;
    [~, file_name, file_ext] = fileparts(file);
    img = im2double(imread(fullfile(input_folder, file)));

    % Wiener Deconvolution
    img_w = wiener_deconvolution(img, PSF, NSR);

    if exist("crop_size", 'var')
        imgCropped = crop_moon(img_w, crop_size);
        file_suffix = '_cropped_processed';
    else
        imgCropped = img_w;
        file_suffix = '_processed';
    end
    
    % Apply scaling to the image to display / save properly - this can be
    % ommitted and done in a different program if wanted
    img_min = min(imgCropped(:));
    img_max = max(imgCropped(:));
    result_final = (imgCropped - img_min) / (img_max - img_min);

    % Save the final centered, scaled image
    new_filename = [file_name, file_suffix, file_ext];
    save_path = fullfile(output_folder, new_filename);
    imwrite(result_final, save_path);
    fprintf('Processed: %s\n', file); % Print when each image is completed
end

% print when all processing is done
fprintf('Batch processing complete!');

