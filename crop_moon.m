
% Function that crops an image or an aray around the center to a given x,y
% dimension
% Note this function requires the image processing toolbox.
function moon_cropped = crop_moon(img, sz)


    % Inputs:
    %   img        - Image to be cropped (2D matrix)
    %   size       - The size of the final image (2D matrix)
    
    % Output:
    %   img_crop   - Cropped image (2D matrix)

    [h, w, ~] = size(img);
    cropH = sz(1);
    cropW = sz(2);
    
    % Create a binary mask to find the moon
    % We use a simple threshold (e.g., 10% of max brightness)
    mask = img > (0.1 * max(img(:)));

    % Find the center of the moon using regionprops
    stats = regionprops(mask, 'Centroid');

        if ~isempty(stats)
        % Get the (x, y) coordinates of the center
        % If multiple blobs exist (like lens flares), take the largest one
        [~, largest_idx] = max([regionprops(mask, 'Area').Area]);
        center = stats(largest_idx).Centroid;

    % Calculate the starting pixel coordinates using floor to ensure
    % integers
                % Calculate crop boundaries
        startX = round(center(1) - cropW/2);
        startY = round(center(2) - cropH/2);

    % Define end coordinates
        endX = startX + cropW - 1;
        endY = startY + cropH - 1;


        % Check the bounds
        if endX > w || endY > h || startX < 1 || startY < 1
            error('BatchError:InvalidSize',...
                'Crop dimensions exceed the original image size.');
        end
    
    moon_cropped = img(startY:endY, startX:endX, :);


    else
        % Fallback if no moon is detected
        % result_cropped = result;
        fprintf('Failed to crop process: %s\n', file_name);

        end 
end