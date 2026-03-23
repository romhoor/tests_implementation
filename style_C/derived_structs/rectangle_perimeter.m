function perimeterValue = rectangle_perimeter(rectangle)
% rectangle_perimeter computes the perimeter of the explicit rectangle struct.
%#codegen
    effectiveWidth = rectangle.width * rectangle.shape.scale_factor;
    effectiveHeight = rectangle.height * rectangle.shape.scale_factor;
    perimeterValue = 2.0 * (effectiveWidth + effectiveHeight);
    validateattributes(perimeterValue, {'double'}, {'scalar', 'finite', 'nonnegative'});
end
