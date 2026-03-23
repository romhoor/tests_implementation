/*
 * File: circle_area.c
 *
 * MATLAB Coder version            : 25.2
 * C/C++ source code generated on  : 23-Mar-2026 16:00:58
 */

/* Include Files */
#include "circle_area.h"

/* Function Definitions */
/*
 * function areaValue = circle_area(circle)
 *
 * circle_area computes the area of the explicit circle struct.
 *
 * Arguments    : double circle_shape_scale_factor
 *                double circle_radius
 * Return Type  : double
 */
double circle_area(double circle_shape_scale_factor, double circle_radius)
{
  double areaValue;
  /* 'circle_area:4' effectiveRadius = circle.radius *
   * circle.shape.scale_factor; */
  areaValue = circle_radius * circle_shape_scale_factor;
  /* 'circle_area:5' areaValue = pi * effectiveRadius * effectiveRadius; */
  areaValue *= 3.1415926535897931 * areaValue;
  /* 'circle_area:6' validateattributes(areaValue, {'double'}, {'scalar',
   * 'finite', 'nonnegative'}); */
  return areaValue;
}

/*
 * File trailer for circle_area.c
 *
 * [EOF]
 */
