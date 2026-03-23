/*
 * File: main.c
 *
 * MATLAB Coder version            : 25.2
 * C/C++ source code generated on  : 23-Mar-2026 16:00:58
 */

/* Include Files */
#include "main.h"
#include "circle_area.h"
#include "circle_create.h"
#include "circle_perimeter.h"
#include "rectangle_area.h"
#include "rectangle_create.h"
#include "rectangle_perimeter.h"
#include "square_area.h"
#include "square_create.h"
#include "square_perimeter.h"

/* Function Definitions */
/*
 * function [areaValue, perimeterValue] = main(shapeID, dim1, dim2, scaleFactor)
 *
 * main is a minimal C-style entry point for probing MATLAB Coder.
 *  It selects one concrete shape struct, instantiates it, and returns its
 *  area and perimeter as numeric outputs.
 *
 *  Inputs:
 *    shapeID     - uint8 identifier matching one non-reserved ShapeIDEnum
 *    dim1        - primary geometric dimension
 *    dim2        - secondary geometric dimension, used by Rectangle only
 *    scaleFactor - scaling factor forwarded to the base shape struct
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
  double circle_radius;
  double circle_shape_scale_factor;
  double rectangle_height;
  /* 'main:17' shapeID = uint8(shapeID); */
  /* 'main:18' dim1 = double(dim1); */
  /* 'main:19' dim2 = double(dim2); */
  /* 'main:20' scaleFactor = double(scaleFactor); */
  /* 'main:22' switch shapeID */
  switch (shapeID) {
  case 1U:
    /* 'main:23' case uint8(ShapeIDEnum.SHAPE_ID_SQUARE) */
    /* 'main:24' square = square_create(dim1, scaleFactor); */
    square_create(dim1, scaleFactor, &circle_shape_scale_factor,
                  &circle_radius);
    /* 'main:25' areaValue = square_area(square); */
    *areaValue = square_area(circle_shape_scale_factor, circle_radius);
    /* 'main:26' perimeterValue = square_perimeter(square); */
    *perimeterValue =
        square_perimeter(circle_shape_scale_factor, circle_radius);
    break;
  case 2U:
    /* 'main:28' case uint8(ShapeIDEnum.SHAPE_ID_RECTANGLE) */
    /* 'main:29' rectangle = rectangle_create(dim1, dim2, scaleFactor); */
    rectangle_create(dim1, dim2, scaleFactor, &circle_shape_scale_factor,
                     &circle_radius, &rectangle_height);
    /* 'main:30' areaValue = rectangle_area(rectangle); */
    *areaValue = rectangle_area(circle_shape_scale_factor, circle_radius,
                                rectangle_height);
    /* 'main:31' perimeterValue = rectangle_perimeter(rectangle); */
    *perimeterValue = rectangle_perimeter(circle_shape_scale_factor,
                                          circle_radius, rectangle_height);
    break;
  case 3U:
    /* 'main:33' case uint8(ShapeIDEnum.SHAPE_ID_CIRCLE) */
    /* 'main:34' circle = circle_create(dim1, scaleFactor); */
    circle_create(dim1, scaleFactor, &circle_shape_scale_factor,
                  &circle_radius);
    /* 'main:35' areaValue = circle_area(circle); */
    *areaValue = circle_area(circle_shape_scale_factor, circle_radius);
    /* 'main:36' perimeterValue = circle_perimeter(circle); */
    *perimeterValue =
        circle_perimeter(circle_shape_scale_factor, circle_radius);
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
