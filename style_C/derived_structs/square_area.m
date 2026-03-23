function areaValue = square_area(square)
% square_area computes the area of the explicit square struct.
%#codegen
    effectiveSide = square.side * square.shape.scale_factor;
    areaValue = effectiveSide * effectiveSide;
    validateattributes(areaValue, {'double'}, {'scalar', 'finite', 'nonnegative'});
end
