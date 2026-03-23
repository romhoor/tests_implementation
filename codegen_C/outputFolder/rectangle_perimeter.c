/*
 * File: rectangle_perimeter.c
 *
 * MATLAB Coder version            : 25.2
 * C/C++ source code generated on  : 23-Mar-2026 16:00:58
 */

/* Include Files */
#include "rectangle_perimeter.h"

/* Function Definitions */
/*
 * function perimeterValue = rectangle_perimeter(rectangle)
 *
 * rectangle_perimeter computes the perimeter of the explicit rectangle struct.
 *
 * Arguments    : double rectangle_shape_scale_factor
 *                double rectangle_width
 *                double rectangle_height
 * Return Type  : double
 */
double rectangle_perimeter(double rectangle_shape_scale_factor,
                           double rectangle_width, double rectangle_height)
{
  /* 'rectangle_perimeter:4' effectiveWidth = rectangle.width *
   * rectangle.shape.scale_factor; */
  /* 'rectangle_perimeter:5' effectiveHeight = rectangle.height *
   * rectangle.shape.scale_factor; */
  /* 'rectangle_perimeter:6' perimeterValue = 2.0 * (effectiveWidth +
   * effectiveHeight); */
  return 2.0 * (rectangle_width * rectangle_shape_scale_factor +
                rectangle_height * rectangle_shape_scale_factor);
  /* 'rectangle_perimeter:7' validateattributes(perimeterValue, {'double'},
   * {'scalar', 'finite', 'nonnegative'}); */
}

/*
 * File trailer for rectangle_perimeter.c
 *
 * [EOF]
 */
