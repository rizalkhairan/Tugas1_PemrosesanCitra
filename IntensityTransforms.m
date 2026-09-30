classdef IntensityTransforms
    % === Point transforms
    methods (Static)
        function result = brightness(source, offset, gain)
            pixels = gain .* im2double(source) + offset / 255;
            result = restoreImageClass(pixels, source);
        end

        function result = negative(source)
            result = restoreImageClass(1 - im2double(source), source);
        end

        function result = log(source, scale)
            pixels = scale .* log1p(im2double(source)) / log(2);
            result = restoreImageClass(pixels, source);
        end

        function result = inverseLog(source, scale)
            pixels = scale .* expm1(log(2) .* im2double(source));
            result = restoreImageClass(pixels, source);
        end

        function result = gamma(source, exponent, scale)
            pixels = scale .* im2double(source) .^ exponent;
            result = restoreImageClass(pixels, source);
        end

        function result = contrastStretch(source, r1, r2, s1, s2)
            pixels = interp1([0 r1/255 r2/255 1], [0 s1/255 s2/255 1], ...
                im2double(source), 'linear');
            result = restoreImageClass(pixels, source);
        end

        function result = threshold(source, level)
            pixels = double(im2double(source) >= level / 255);
            result = restoreImageClass(pixels, source);
        end

        function result = grayLevelSlice(source, lower, upper, preserveBackground)
            pixels = im2double(source);
            selected = pixels >= lower / 255 & pixels <= upper / 255;
            if ~preserveBackground
                pixels(:) = 0;
            end
            pixels(selected) = 1;
            result = restoreImageClass(pixels, source);
        end

        function result = bitPlane(source, bit)
            % UI bits are zero-based; bitget uses one-based indexing.
            pixels = double(bitget(im2uint8(im2double(source)), bit + 1));
            result = restoreImageClass(pixels, source);
        end
    end
end
