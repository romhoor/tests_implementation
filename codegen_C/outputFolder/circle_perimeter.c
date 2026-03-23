/*
 * File: circle_perimeter.c
 *
 * MATLAB Coder version            : 25.2
 * C/C++ source code generated on  : 23-Mar-2026 16:00:58
 */

/* Include Files */
#include "circle_perimeter.h"

/* Function Definitions */
/*
 * function perimeterValue = circle_perimeter(circle)
 *
 * circle_perimeter computes the perimeter of the explicit circle struct.
 *
 * Arguments    : double circle_shape_scale_factor
 *                double circle_radius
 * Return Type  : double
 */
double circle_perimeter(double circle_shape_scale_factor, double circle_radius)
{
  /* 'circle_perimeter:4' effectiveRadius = circle.radius *
   * circle.shape.scale_factor; */
  /* 'circle_perimeter:5' perimeterValue = 2.0 * pi * effectiveRadius; */
  return 6.2831853071795862 * (circle_radius * circle_shape_scale_factor);
  /* 'circle_perimeter:6' validateattributes(perimeterValue, {'double'},
   * {'scalar', 'finite', 'nonnegative'}); */
}

/*
 * File trailer for circle_perimeter.c
 *
 * [EOF]
 */
