function isValid = shape_is_valid_id(shapeID)
% shape_is_valid_id checks whether a shape ID is one allowed non-reserved
% ShapeIDEnum value.
%#codegen
    shapeID = uint8(shapeID);

    invalidShapeID = uint8(ShapeIDEnum.SHAPE_ID_INVALID);
    maxShapeID = uint8(ShapeIDEnum.SHAPE_ID_MAX);
    enumShapeIDs = uint8(enumeration('ShapeIDEnum'));

    isValid = ismember(shapeID, enumShapeIDs) && ...
              shapeID > invalidShapeID && ...
              shapeID < maxShapeID;
end
