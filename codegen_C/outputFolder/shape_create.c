/*
 * File: shape_create.c
 *
 * MATLAB Coder version            : 25.2
 * C/C++ source code generated on  : 23-Mar-2026 16:00:58
 */

/* Include Files */
#include "shape_create.h"

/* Function Definitions */
/*
 * function shape = shape_create(shapeID, scaleFactor)
 *
 * shape_create builds the shared base shape struct.
 *  The base shape only stores the common identifier and scale factor.
 *
 * Arguments    : double scaleFactor
 *                double *shape_scale_factor
 * Return Type  : unsigned char
 */
unsigned char b_shape_create(double scaleFactor, double *shape_scale_factor)
{
  unsigned char shape_shape_id;
  /* 'shape_create:5' shapeID = uint8(shapeID); */
  /* 'shape_create:7' if nargin < 2 */
  /* 'shape_create:9' else */
  /* 'shape_create:10' scaleFactor = double(scaleFactor); */
  /* 'shape_create:11' validateattributes(scaleFactor, {'double'}, {'scalar',
   * 'finite', 'nonnegative'}); */
  /* 'shape_create:15' if ~shape_is_valid_id(shapeID) */
  /* 'shape_create:20' shape = struct( ... */
  /* 'shape_create:21'         'shape_id', shapeID, ... */
  /* 'shape_create:22'         'scale_factor', scaleFactor); */
  shape_shape_id = 2U;
  *shape_scale_factor = scaleFactor;
  return shape_shape_id;
}

/*
 * function shape = shape_create(shapeID, scaleFactor)
 *
 * shape_create builds the shared base shape struct.
 *  The base shape only stores the common identifier and scale factor.
 *
 * Arguments    : double scaleFactor
 *                double *shape_scale_factor
 * Return Type  : unsigned char
 */
unsigned char c_shape_create(double scaleFactor, double *shape_scale_factor)
{
  unsigned char shape_shape_id;
  /* 'shape_create:5' shapeID = uint8(shapeID); */
  /* 'shape_create:7' if nargin < 2 */
  /* 'shape_create:9' else */
  /* 'shape_create:10' scaleFactor = double(scaleFactor); */
  /* 'shape_create:11' validateattributes(scaleFactor, {'double'}, {'scalar',
   * 'finite', 'nonnegative'}); */
  /* 'shape_create:15' if ~shape_is_valid_id(shapeID) */
  /* 'shape_create:20' shape = struct( ... */
  /* 'shape_create:21'         'shape_id', shapeID, ... */
  /* 'shape_create:22'         'scale_factor', scaleFactor); */
  shape_shape_id = 3U;
  *shape_scale_factor = scaleFactor;
  return shape_shape_id;
}

/*
 * function shape = shape_create(shapeID, scaleFactor)
 *
 * shape_create builds the shared base shape struct.
 *  The base shape only stores the common identifier and scale factor.
 *
 * Arguments    : double scaleFactor
 *                double *shape_scale_factor
 * Return Type  : unsigned char
 */
unsigned char shape_create(double scaleFactor, double *shape_scale_factor)
{
  unsigned char shape_shape_id;
  /* 'shape_create:5' shapeID = uint8(shapeID); */
  /* 'shape_create:7' if nargin < 2 */
  /* 'shape_create:9' else */
  /* 'shape_create:10' scaleFactor = double(scaleFactor); */
  /* 'shape_create:11' validateattributes(scaleFactor, {'double'}, {'scalar',
   * 'finite', 'nonnegative'}); */
  /* 'shape_create:15' if ~shape_is_valid_id(shapeID) */
  /* 'shape_create:20' shape = struct( ... */
  /* 'shape_create:21'         'shape_id', shapeID, ... */
  /* 'shape_create:22'         'scale_factor', scaleFactor); */
  shape_shape_id = 1U;
  *shape_scale_factor = scaleFactor;
  return shape_shape_id;
}

/*
 * File trailer for shape_create.c
 *
 * [EOF]
 */
