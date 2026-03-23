/*
 * File: rectangle_area.c
 *
 * MATLAB Coder version            : 25.2
 * C/C++ source code generated on  : 23-Mar-2026 16:00:58
 */

/* Include Files */
#include "rectangle_area.h"

/* Function Definitions */
/*
 * function areaValue = rectangle_area(rectangle)
 *
 * rectangle_area computes the area of the explicit rectangle struct.
 *
 * Arguments    : double rectangle_shape_scale_factor
 *                double rectangle_width
 *                double rectangle_height
 * Return Type  : double
 */
double rectangle_area(double rectangle_shape_scale_factor,
                      double rectangle_width, double rectangle_height)
{
  /* 'rectangle_area:4' effectiveWidth = rectangle.width *
   * rectangle.shape.scale_factor; */
  /* 'rectangle_area:5' effectiveHeight = rectangle.height *
   * rectangle.shape.scale_factor; */
  /* 'rectangle_area:6' areaValue = effectiveWidth * effectiveHeight; */
  return rectangle_width * rectangle_shape_scale_factor *
         (rectangle_height * rectangle_shape_scale_factor);
  /* 'rectangle_area:7' validateattributes(areaValue, {'double'}, {'scalar',
   * 'finite', 'nonnegative'}); */
}

/*
 * File trailer for rectangle_area.c
 *
 * [EOF]
 */
