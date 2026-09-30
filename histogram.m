function counts = histogram(img)
    % Compatibility entry point; the counting algorithm lives in one place.
    counts = HistogramTransforms.count(img);
end
