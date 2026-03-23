function perimeterValue = square_perimeter(square)
% square_perimeter computes the perimeter of the explicit square struct.
%#codegen
    effectiveSide = square.side * square.shape.scale_factor;
    perimeterValue = 4.0 * effectiveSide;
    validateattributes(perimeterValue, {'double'}, {'scalar', 'finite', 'nonnegative'});
end
