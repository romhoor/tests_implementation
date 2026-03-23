function circle = circle_create(radius, scaleFactor)
% circle_create builds the explicit circle struct.
%#codegen
    if nargin < 1
        radius = 1;
    else
        radius = double(radius);
        validateattributes(radius, {'double'}, {'scalar', 'finite', 'nonnegative'});
    end
    
    if nargin < 2
        scaleFactor = 1;
    end

    circle = struct( ...
        'shape', shape_create(uint8(ShapeIDEnum.SHAPE_ID_CIRCLE), scaleFactor), ...
        'radius', radius);
end
