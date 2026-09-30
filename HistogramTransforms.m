classdef HistogramTransforms
    methods (Static)
        function counts = count(source)
            pixels = im2uint8(source);
            [height, width, channels] = size(pixels);
            counts = zeros(channels, 256);
            for channel = 1:channels
                for row = 1:height
                    for col = 1:width
                        % MATLAB index at 1
                        bin = double(pixels(row,col,channel)) + 1;
                        counts(channel, bin) = counts(channel, bin) + 1;
                    end
                end
            end
        end

        function result = equalize(source)
            map = HistogramTransforms.cumulativeMap(source);
            result = HistogramTransforms.mapImage(source, map);
        end

        function result = match(source, reference)
            gray = size(source, 3) == 1 || ...
                isequal(source(:,:,1), source(:,:,2), source(:,:,3));
            if gray && size(reference, 3) == 3
                reference = rgb2gray(reference);
            end
            map = HistogramTransforms.cumulativeMap(source);
            referenceMap = HistogramTransforms.cumulativeMap(reference);
            for channel = 1:size(source, 3)
                target = referenceMap(min(channel, size(referenceMap, 1)), :);
                for level = 1:256
                    [~, index] = min(abs(map(channel, level) - target));
                    map(channel, level) = index - 1;
                end
            end
            result = HistogramTransforms.mapImage(source, map);
        end
    end

    methods (Static, Access = private)
        function map = cumulativeMap(source)
            counts = HistogramTransforms.count(source);
            map = floor(255 * cumsum(counts, 2) / (size(source, 1) * size(source, 2)));
        end

        function result = mapImage(source, map)
            % Transform image, replacing intensity
            pixels = im2uint8(source);
            output = zeros(size(source));
            for channel = 1:size(source, 3)
                plane = pixels(:,:,channel);
                levels = map(channel, :);
                output(:,:,channel) = reshape(levels(double(plane(:)) + 1), size(plane)) / 255;
            end
            result = restoreImageClass(output, source);
        end
    end
end
