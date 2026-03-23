/*
 * File: square_area.c
 *
 * MATLAB Coder version            : 25.2
 * C/C++ source code generated on  : 23-Mar-2026 16:00:58
 */

/* Include Files */
#include "square_area.h"

/* Function Definitions */
/*
 * function areaValue = square_area(square)
 *
 * square_area computes the area of the explicit square struct.
 *
 * Arguments    : double square_shape_scale_factor
 *                double square_side
 * Return Type  : double
 */
double square_area(double square_shape_scale_factor, double square_side)
{
  double areaValue;
  /* 'square_area:4' effectiveSide = square.side * square.shape.scale_factor; */
  areaValue = square_side * square_shape_scale_factor;
  /* 'square_area:5' areaValue = effectiveSide * effectiveSide; */
  areaValue *= areaValue;
  /* 'square_area:6' validateattributes(areaValue, {'double'}, {'scalar',
   * 'finite', 'nonnegative'}); */
  return areaValue;
}

/*
 * File trailer for square_area.c
 *
 * [EOF]
 */
