/*
 * File: rectangle_create.c
 *
 * MATLAB Coder version            : 25.2
 * C/C++ source code generated on  : 23-Mar-2026 16:00:58
 */

/* Include Files */
#include "rectangle_create.h"
#include "shape_create.h"

/* Function Definitions */
/*
 * function rectangle = rectangle_create(width, height, scaleFactor)
 *
 * rectangle_create builds the explicit rectangle struct.
 *
 * Arguments    : double width
 *                double height
 *                double scaleFactor
 *                double *rectangle_shape_scale_factor
 *                double *rectangle_width
 *                double *rectangle_height
 * Return Type  : unsigned char
 */
unsigned char rectangle_create(double width, double height, double scaleFactor,
                               double *rectangle_shape_scale_factor,
                               double *rectangle_width,
                               double *rectangle_height)
{
  unsigned char rectangle_shape_shape_id;
  /* 'rectangle_create:4' if nargin < 1 */
  /* 'rectangle_create:7' if nargin < 2 */
  /* 'rectangle_create:10' if nargin < 3 */
  /* 'rectangle_create:14' width = double(width); */
  /* 'rectangle_create:15' height = double(height); */
  /* 'rectangle_create:16' validateattributes(width, {'double'}, {'scalar',
   * 'finite', 'nonnegative'}); */
  /* 'rectangle_create:17' validateattributes(height, {'double'}, {'scalar',
   * 'finite', 'nonnegative'}); */
  /* 'rectangle_create:19' rectangle = struct( ... */
  /* 'rectangle_create:20'         'shape',
   * shape_create(uint8(ShapeIDEnum.SHAPE_ID_RECTANGLE), scaleFactor), ... */
  /* 'rectangle_create:21'         'width', width, ... */
  /* 'rectangle_create:22'         'height', height); */
  rectangle_shape_shape_id =
      b_shape_create(scaleFactor, rectangle_shape_scale_factor);
  *rectangle_width = width;
  *rectangle_height = height;
  return rectangle_shape_shape_id;
}

/*
 * File trailer for rectangle_create.c
 *
 * [EOF]
 */
