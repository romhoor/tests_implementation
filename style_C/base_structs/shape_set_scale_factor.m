function shape = shape_set_scale_factor(shape, scaleFactor)
% shape_set_scale_factor returns an updated base shape struct.
%#codegen
    scaleFactor = double(scaleFactor);
    validateattributes(scaleFactor, {'double'}, {'scalar', 'finite', 'nonnegative'});
    shape.scale_factor = scaleFactor;
end
