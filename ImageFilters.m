classdef ImageFilters
    % === Kernel transforms
    methods (Static)
        function mask = meanMask(n)
            mask = ones(n) / n^2;
        end

        function mask = lowPassMask()
            mask = [1 1 1; 1 2 1; 1 1 1] / 10;
        end

        function mask = gaussianMask(n, sigma)
            radius = (n - 1) / 2;
            [x, y] = meshgrid(-radius:radius);
            mask = exp(-(x.^2 + y.^2) / (2 * sigma^2));
            mask = mask / sum(mask(:));
        end

        function mask = sharpenMask(neighbors)
            if neighbors == 4
                mask = [0 -1 0; -1 5 -1; 0 -1 0];
            else
                mask = [-1 -1 -1; -1 9 -1; -1 -1 -1];
            end
        end

        function mask = unsharpMask(n)
            % Sharpened image = 2 * original - mean-blurred image.
            mask = -ImageFilters.meanMask(n);
            center = (n + 1) / 2;
            mask(center, center) = mask(center, center) + 2;
        end

        function mask = highBoostMask(n, gain)
            mask = -ones(n) / n^2;
            center = (n + 1) / 2;
            mask(center, center) = mask(center, center) + gain;
        end

        function result = convolve(source, mask)
            radius = (size(mask, 1) - 1) / 2;
            pixels = im2double(source);
            output = zeros(size(pixels));
            for channel = 1:size(pixels, 3)
                padded = padarray(pixels(:,:,channel), [radius radius], 'replicate');
                output(:,:,channel) = conv2(padded, mask, 'valid');
            end
            result = restoreImageClass(output, source);
        end

        function result = median(source, n)
            % Not convolution technically
            radius = (n - 1) / 2;
            middle = (n^2 + 1) / 2;
            result = source;
            for channel = 1:size(source, 3)
                padded = padarray(source(:,:,channel), [radius radius], 'replicate');
                for row = 1:size(source, 1)
                    for col = 1:size(source, 2)
                        neighborhood = padded(row:row+n-1, col:col+n-1);
                        ordered = sort(neighborhood(:));
                        result(row, col, channel) = ordered(middle);
                    end
                end
            end
        end
    end
end
