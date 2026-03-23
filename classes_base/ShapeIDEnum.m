% ShapeIDEnum defines the allowed constant identifiers for Shape subclasses.
% SHAPE_ID_INVALID is reserved as the forbidden default value.
% SHAPE_ID_MAX is kept as the final enum entry for loops and switch ranges.
classdef ShapeIDEnum < uint8
    enumeration
        SHAPE_ID_INVALID   (0)
        SHAPE_ID_SQUARE    (1)
        SHAPE_ID_RECTANGLE (2)
        SHAPE_ID_CIRCLE    (3)
        SHAPE_ID_MAX       (4)
    end
end
