function shape = shape_create(shapeID, scaleFactor)
% shape_create builds the shared base shape struct.
% The base shape only stores the common identifier and scale factor.
%#codegen
    shapeID = uint8(shapeID);

    if nargin < 2
        scaleFactor = 1;
    else
        scaleFactor = double(scaleFactor);
        validateattributes(scaleFactor, {'double'}, {'scalar', 'finite', 'nonnegative'});
    end


    if ~shape_is_valid_id(shapeID)
        error('Shape:InvalidShapeID', ...
            'shapeID must be a valid non-reserved ShapeIDEnum value.');
    end

    shape = struct( ...
        'shape_id', shapeID, ...
        'scale_factor', scaleFactor);
end
