/*
 * File: main.c
 *
 * MATLAB Coder version            : 25.2
 * C/C++ source code generated on  : 23-Mar-2026 13:20:27
 */

/* Include Files */
#include "main.h"
#include "Circle.h"
#include "Rectangle.h"
#include "Shape.h"
#include "Square.h"
#include "main_internal_types.h"

/* Function Definitions */
/*
 * function [areaValue, perimeterValue] = main(shapeID, dim1, dim2, scaleFactor)
 *
 * main is a minimal object-oriented entry point for probing MATLAB Coder.
 *  It selects one concrete Shape subclass, instantiates it, and returns its
 *  area and perimeter as numeric outputs.
 *
 *  Inputs:
 *    shapeID     - uint8 identifier matching one non-reserved ShapeIDEnum
 *    dim1        - primary geometric dimension
 *    dim2        - secondary geometric dimension, used by Rectangle only
 *    scaleFactor - scaling factor forwarded to Shape
 *
 *  Outputs:
 *    areaValue      - validated area result from the selected shape
 *    perimeterValue - validated perimeter result from the selected shape
 *
 * Arguments    : unsigned char shapeID
 *                double dim1
 *                double dim2
 *                double scaleFactor
 *                double *areaValue
 *                double *perimeterValue
 * Return Type  : void
 */
void main(unsigned char shapeID, double dim1, double dim2, double scaleFactor,
          double *areaValue, double *perimeterValue)
{
  Circle circle;
  Rectangle rectangle;
  Square square;
  /* 'main:17' shapeID = uint8(shapeID); */
  /* 'main:18' dim1 = double(dim1); */
  /* 'main:19' dim2 = double(dim2); */
  /* 'main:20' scaleFactor = double(scaleFactor); */
  /* 'main:22' switch shapeID */
  switch (shapeID) {
  case 1U:
    /* 'main:23' case uint8(ShapeIDEnum.SHAPE_ID_SQUARE) */
    /* 'main:24' square = Square(dim1, scaleFactor); */
    Square_Square(&square, dim1, scaleFactor);
    /* 'main:25' areaValue = square.area(); */
    *areaValue = Shape_area(&square);
    /* 'main:26' perimeterValue = square.perimeter(); */
    *perimeterValue = Shape_perimeter(&square);
    break;
  case 2U:
    /* 'main:28' case uint8(ShapeIDEnum.SHAPE_ID_RECTANGLE) */
    /* 'main:29' rectangle = Rectangle(dim1, dim2, scaleFactor); */
    Rectangle_Rectangle(&rectangle, dim1, dim2, scaleFactor);
    /* 'main:30' areaValue = rectangle.area(); */
    *areaValue = b_Shape_area(&rectangle);
    /* 'main:31' perimeterValue = rectangle.perimeter(); */
    *perimeterValue = b_Shape_perimeter(&rectangle);
    break;
  case 3U:
    /* 'main:33' case uint8(ShapeIDEnum.SHAPE_ID_CIRCLE) */
    /* 'main:34' circle = Circle(dim1, scaleFactor); */
    Circle_Circle(&circle, dim1, scaleFactor);
    /* 'main:35' areaValue = circle.area(); */
    *areaValue = c_Shape_area(&circle);
    /* 'main:36' perimeterValue = circle.perimeter(); */
    *perimeterValue = c_Shape_perimeter(&circle);
    break;
  default:
    /* 'main:38' otherwise */
    /* 'main:39' error('main:InvalidShapeID', ... */
    /* 'main:40'                 'shapeID must select Square, Rectangle, or
     * Circle.'); */
    break;
  }
}

/*
 * File trailer for main.c
 *
 * [EOF]
 */
