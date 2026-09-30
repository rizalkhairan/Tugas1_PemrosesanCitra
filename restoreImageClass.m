function result = restoreImageClass(pixels, source)
% Convert processing results back to source image class. Should only be
% uint8
    pixels = min(max(pixels, 0), 1);
    switch class(source)
        case 'uint8'
            result = im2uint8(pixels);
        case 'uint16'
            result = im2uint16(pixels);
        case 'int16'
            result = im2int16(pixels);
        case 'logical'
            result = pixels >= 0.5;
        otherwise
            result = cast(pixels, 'like', source);
    end
end
