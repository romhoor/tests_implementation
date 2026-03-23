/*
 * File: Rectangle.c
 *
 * MATLAB Coder version            : 25.2
 * C/C++ source code generated on  : 23-Mar-2026 13:20:27
 */

/* Include Files */
#include "Rectangle.h"
#include "Shape.h"
#include "main_internal_types.h"
#include "validator_check_type.h"

/* Function Declarations */
static void Rectangle_set_Height(Rectangle *obj, double val);

static void Rectangle_set_Width(Rectangle *obj, double val);

/* Function Definitions */
/*
 * Arguments    : Rectangle *obj
 *                double val
 * Return Type  : void
 */
static void Rectangle_set_Height(Rectangle *obj, double val)
{
  /* 'Rectangle:17' double */
  /* 'Rectangle:17' (1,1) */
  obj->Height = validator_check_type(validator_check_type(val));
  /* 'Rectangle:17' Height */
}

/*
 * Arguments    : Rectangle *obj
 *                double val
 * Return Type  : void
 */
static void Rectangle_set_Width(Rectangle *obj, double val)
{
  /* 'Rectangle:13' double */
  /* 'Rectangle:13' (1,1) */
  obj->Width = validator_check_type(validator_check_type(val));
  /* 'Rectangle:13' Width */
}

/*
 * function obj = Rectangle(varargin)
 *
 * Arguments    : Rectangle *obj
 *                double varargin_1
 *                double varargin_2
 *                double varargin_3
 * Return Type  : Rectangle *
 */
Rectangle *Rectangle_Rectangle(Rectangle *obj, double varargin_1,
                               double varargin_2, double varargin_3)
{
  Rectangle *b_obj;
  b_obj = obj;
  /*  Constructor. */
  /*  Supported constructor calls are: */
  /*  Rectangle()                        -> Width = 1, Height = 1, ScaleFactor =
   * 1 */
  /*  Rectangle(width, height)          -> Width = width, Height = height,
   * ScaleFactor = 1 */
  /*  Rectangle(width, height, scaleFactor) */
  /*                                   -> Width = width, Height = height,
   * ScaleFactor = scaleFactor */
  /*  */
  /*  The first two inputs always refer to Rectangle-specific */
  /*  properties. The optional third input is forwarded to Shape as */
  /*  the scale factor. */
  /* 'Rectangle:32' if nargin > 3 */
  /* 'Rectangle:37' if nargin < 1 */
  /* 'Rectangle:39' else */
  /* 'Rectangle:40' width = varargin{1}; */
  /* 'Rectangle:43' if nargin < 2 */
  /* 'Rectangle:45' else */
  /* 'Rectangle:46' height = varargin{2}; */
  /*  Forward only the optional third input to Shape. */
  /* 'Rectangle:50' obj@Shape(varargin{3:end}); */
  b_obj = b_Shape_Shape(b_obj, varargin_3);
  /* 'Rectangle:52' obj.Width = width; */
  Rectangle_set_Width(b_obj, varargin_1);
  /* 'Rectangle:53' obj.Height = height; */
  Rectangle_set_Height(b_obj, varargin_2);
  return b_obj;
}

/*
 * function a = computeArea(obj)
 *
 * Arguments    : const Rectangle *obj
 * Return Type  : double
 */
double Rectangle_computeArea(const Rectangle *obj)
{
  /*  Compute the rectangle area before the Shape-level validation step. */
  /* 'Rectangle:87' effectiveWidth = obj.Width * obj.ScaleFactor; */
  /* 'Rectangle:88' effectiveHeight = obj.Height * obj.ScaleFactor; */
  /* 'Rectangle:89' a = effectiveWidth * effectiveHeight; */
  return obj->Width * obj->ScaleFactor * (obj->Height * obj->ScaleFactor);
}

/*
 * function p = computePerimeter(obj)
 *
 * Arguments    : const Rectangle *obj
 * Return Type  : double
 */
double Rectangle_computePerimeter(const Rectangle *obj)
{
  /*  Compute the rectangle perimeter before the Shape-level validation step. */
  /* 'Rectangle:94' effectiveWidth = obj.Width * obj.ScaleFactor; */
  /* 'Rectangle:95' effectiveHeight = obj.Height * obj.ScaleFactor; */
  /* 'Rectangle:96' p = 2 * (effectiveWidth + effectiveHeight); */
  return 2.0 * (obj->Width * obj->ScaleFactor + obj->Height * obj->ScaleFactor);
}

/*
 * File trailer for Rectangle.c
 *
 * [EOF]
 */
