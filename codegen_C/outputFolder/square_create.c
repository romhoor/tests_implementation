/*
 * File: square_create.c
 *
 * MATLAB Coder version            : 25.2
 * C/C++ source code generated on  : 23-Mar-2026 16:00:58
 */

/* Include Files */
#include "square_create.h"
#include "shape_create.h"

/* Function Definitions */
/*
 * function square = square_create(side, scaleFactor)
 *
 * square_create builds the explicit square struct.
 *
 * Arguments    : double side
 *                double scaleFactor
 *                double *square_shape_scale_factor
 *                double *square_side
 * Return Type  : unsigned char
 */
unsigned char square_create(double side, double scaleFactor,
                            double *square_shape_scale_factor,
                            double *square_side)
{
  unsigned char square_shape_shape_id;
  /* 'square_create:4' if nargin < 1 */
  /* 'square_create:7' if nargin < 2 */
  /* 'square_create:11' side = double(side); */
  /* 'square_create:12' validateattributes(side, {'double'}, {'scalar',
   * 'finite', 'nonnegative'}); */
  /* 'square_create:14' square = struct( ... */
  /* 'square_create:15'         'shape',
   * shape_create(uint8(ShapeIDEnum.SHAPE_ID_SQUARE), scaleFactor), ... */
  /* 'square_create:16'         'side', side); */
  square_shape_shape_id = shape_create(scaleFactor, square_shape_scale_factor);
  *square_side = side;
  return square_shape_shape_id;
}

/*
 * File trailer for square_create.c
 *
 * [EOF]
 */
