function counts = histogram(img)
    img = im2uint8(img);
    [height, width, numChannels] = size(img);
    counts = zeros(numChannels, 256);

    for k = 1:numChannels
        for i = 1:height
            for j = 1:width
                % Convert before adding: uint8(255) + 1 saturates at 255.
                bin = double(img(i,j,k)) + 1;
                counts(k, bin) = counts(k, bin) + 1;
            end
        end
    end
end
