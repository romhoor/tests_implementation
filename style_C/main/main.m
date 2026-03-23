function [areaValue, perimeterValue] = main(shapeID, dim1, dim2, scaleFactor)
% main is a minimal C-style entry point for probing MATLAB Coder.
% It selects one concrete shape struct, instantiates it, and returns its
% area and perimeter as numeric outputs.
%
% Inputs:
%   shapeID     - uint8 identifier matching one non-reserved ShapeIDEnum
%   dim1        - primary geometric dimension
%   dim2        - secondary geometric dimension, used by Rectangle only
%   scaleFactor - scaling factor forwarded to the base shape struct
%
% Outputs:
%   areaValue      - validated area result from the selected shape
%   perimeterValue - validated perimeter result from the selected shape
%#codegen

    shapeID = uint8(shapeID);
    dim1 = double(dim1);
    dim2 = double(dim2);
    scaleFactor = double(scaleFactor);

    switch shapeID
        case uint8(ShapeIDEnum.SHAPE_ID_SQUARE)
            square = square_create(dim1, scaleFactor);
            areaValue = square_area(square);
            perimeterValue = square_perimeter(square);

        case uint8(ShapeIDEnum.SHAPE_ID_RECTANGLE)
            rectangle = rectangle_create(dim1, dim2, scaleFactor);
            areaValue = rectangle_area(rectangle);
            perimeterValue = rectangle_perimeter(rectangle);

        case uint8(ShapeIDEnum.SHAPE_ID_CIRCLE)
            circle = circle_create(dim1, scaleFactor);
            areaValue = circle_area(circle);
            perimeterValue = circle_perimeter(circle);

        otherwise
            error('main:InvalidShapeID', ...
                'shapeID must select Square, Rectangle, or Circle.');
    end
end
