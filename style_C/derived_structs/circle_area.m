function areaValue = circle_area(circle)
% circle_area computes the area of the explicit circle struct.
%#codegen
    effectiveRadius = circle.radius * circle.shape.scale_factor;
    areaValue = pi * effectiveRadius * effectiveRadius;
    validateattributes(areaValue, {'double'}, {'scalar', 'finite', 'nonnegative'});
end
