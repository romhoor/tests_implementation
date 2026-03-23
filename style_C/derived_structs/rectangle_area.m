function areaValue = rectangle_area(rectangle)
% rectangle_area computes the area of the explicit rectangle struct.
%#codegen
    effectiveWidth = rectangle.width * rectangle.shape.scale_factor;
    effectiveHeight = rectangle.height * rectangle.shape.scale_factor;
    areaValue = effectiveWidth * effectiveHeight;
    validateattributes(areaValue, {'double'}, {'scalar', 'finite', 'nonnegative'});
end
