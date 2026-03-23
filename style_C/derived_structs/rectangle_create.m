function rectangle = rectangle_create(width, height, scaleFactor)
% rectangle_create builds the explicit rectangle struct.
%#codegen
    if nargin < 1
        width = 1;
    end
    if nargin < 2
        height = 1;
    end
    if nargin < 3
        scaleFactor = 1;
    end

    width = double(width);
    height = double(height);
    validateattributes(width, {'double'}, {'scalar', 'finite', 'nonnegative'});
    validateattributes(height, {'double'}, {'scalar', 'finite', 'nonnegative'});

    rectangle = struct( ...
        'shape', shape_create(uint8(ShapeIDEnum.SHAPE_ID_RECTANGLE), scaleFactor), ...
        'width', width, ...
        'height', height);
end
