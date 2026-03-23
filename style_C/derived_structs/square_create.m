function square = square_create(side, scaleFactor)
% square_create builds the explicit square struct.
%#codegen
    if nargin < 1
        side = 1;
    end
    if nargin < 2
        scaleFactor = 1;
    end

    side = double(side);
    validateattributes(side, {'double'}, {'scalar', 'finite', 'nonnegative'});

    square = struct( ...
        'shape', shape_create(uint8(ShapeIDEnum.SHAPE_ID_SQUARE), scaleFactor), ...
        'side', side);
end
