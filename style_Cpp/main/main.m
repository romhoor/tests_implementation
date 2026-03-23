function [areaValue, perimeterValue] = main(shapeID, dim1, dim2, scaleFactor)
% main is a minimal object-oriented entry point for probing MATLAB Coder.
% It selects one concrete Shape subclass, instantiates it, and returns its
% area and perimeter as numeric outputs.
%
% Inputs:
%   shapeID     - uint8 identifier matching one non-reserved ShapeIDEnum
%   dim1        - primary geometric dimension
%   dim2        - secondary geometric dimension, used by Rectangle only
%   scaleFactor - scaling factor forwarded to Shape
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
            square = Square(dim1, scaleFactor);
            areaValue = square.area();
            perimeterValue = square.perimeter();

        case uint8(ShapeIDEnum.SHAPE_ID_RECTANGLE)
            rectangle = Rectangle(dim1, dim2, scaleFactor);
            areaValue = rectangle.area();
            perimeterValue = rectangle.perimeter();

        case uint8(ShapeIDEnum.SHAPE_ID_CIRCLE)
            circle = Circle(dim1, scaleFactor);
            areaValue = circle.area();
            perimeterValue = circle.perimeter();

        otherwise
            error('main:InvalidShapeID', ...
                'shapeID must select Square, Rectangle, or Circle.');
    end
end
