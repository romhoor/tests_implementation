/*
 * File: circle_create.c
 *
 * MATLAB Coder version            : 25.2
 * C/C++ source code generated on  : 23-Mar-2026 16:00:58
 */

/* Include Files */
#include "circle_create.h"
#include "shape_create.h"

/* Function Definitions */
/*
 * function circle = circle_create(radius, scaleFactor)
 *
 * circle_create builds the explicit circle struct.
 *
 * Arguments    : double radius
 *                double scaleFactor
 *                double *circle_shape_scale_factor
 *                double *circle_radius
 * Return Type  : unsigned char
 */
unsigned char circle_create(double radius, double scaleFactor,
                            double *circle_shape_scale_factor,
                            double *circle_radius)
{
  unsigned char circle_shape_shape_id;
  /* 'circle_create:4' if nargin < 1 */
  /* 'circle_create:6' else */
  /* 'circle_create:7' radius = double(radius); */
  /* 'circle_create:8' validateattributes(radius, {'double'}, {'scalar',
   * 'finite', 'nonnegative'}); */
  /* 'circle_create:11' if nargin < 2 */
  /* 'circle_create:15' circle = struct( ... */
  /* 'circle_create:16'         'shape',
   * shape_create(uint8(ShapeIDEnum.SHAPE_ID_CIRCLE), scaleFactor), ... */
  /* 'circle_create:17'         'radius', radius); */
  circle_shape_shape_id =
      c_shape_create(scaleFactor, circle_shape_scale_factor);
  *circle_radius = radius;
  return circle_shape_shape_id;
}

/*
 * File trailer for circle_create.c
 *
 * [EOF]
 */
