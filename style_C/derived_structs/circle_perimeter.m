function perimeterValue = circle_perimeter(circle)
% circle_perimeter computes the perimeter of the explicit circle struct.
%#codegen
    effectiveRadius = circle.radius * circle.shape.scale_factor;
    perimeterValue = 2.0 * pi * effectiveRadius;
    validateattributes(perimeterValue, {'double'}, {'scalar', 'finite', 'nonnegative'});
end
