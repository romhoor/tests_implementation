/*
 * File: square_perimeter.c
 *
 * MATLAB Coder version            : 25.2
 * C/C++ source code generated on  : 23-Mar-2026 16:00:58
 */

/* Include Files */
#include "square_perimeter.h"

/* Function Definitions */
/*
 * function perimeterValue = square_perimeter(square)
 *
 * square_perimeter computes the perimeter of the explicit square struct.
 *
 * Arguments    : double square_shape_scale_factor
 *                double square_side
 * Return Type  : double
 */
double square_perimeter(double square_shape_scale_factor, double square_side)
{
  /* 'square_perimeter:4' effectiveSide = square.side *
   * square.shape.scale_factor; */
  /* 'square_perimeter:5' perimeterValue = 4.0 * effectiveSide; */
  return 4.0 * (square_side * square_shape_scale_factor);
  /* 'square_perimeter:6' validateattributes(perimeterValue, {'double'},
   * {'scalar', 'finite', 'nonnegative'}); */
}

/*
 * File trailer for square_perimeter.c
 *
 * [EOF]
 */
