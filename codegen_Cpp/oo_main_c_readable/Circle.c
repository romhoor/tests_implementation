/*
 * File: Circle.c
 *
 * MATLAB Coder version            : 25.2
 * C/C++ source code generated on  : 23-Mar-2026 13:20:27
 */

/* Include Files */
#include "Circle.h"
#include "Shape.h"
#include "main_internal_types.h"
#include "validator_check_type.h"

/* Function Declarations */
static void Circle_set_Radius(Circle *obj, double val);

/* Function Definitions */
/*
 * Arguments    : Circle *obj
 *                double val
 * Return Type  : void
 */
static void Circle_set_Radius(Circle *obj, double val)
{
  /* 'Circle:13' double */
  /* 'Circle:13' (1,1) */
  obj->Radius = validator_check_type(validator_check_type(val));
  /* 'Circle:13' Radius */
}

/*
 * function obj = Circle(varargin)
 *
 * Arguments    : Circle *obj
 *                double varargin_1
 *                double varargin_2
 * Return Type  : Circle *
 */
Circle *Circle_Circle(Circle *obj, double varargin_1, double varargin_2)
{
  Circle *b_obj;
  b_obj = obj;
  /*  Constructor. */
  /*  Supported constructor calls are: */
  /*  Circle()                    -> Radius = 1, ScaleFactor = 1 */
  /*  Circle(radius)             -> Radius = radius, ScaleFactor = 1 */
  /*  Circle(radius, scaleFactor)-> Radius = radius, ScaleFactor = scaleFactor
   */
  /*  */
  /*  The first input always refers to the Circle-specific property */
  /*  Radius. The optional second input is forwarded to Shape as the */
  /*  scale factor. */
  /* 'Circle:27' if nargin > 2 */
  /* 'Circle:32' if nargin < 1 */
  /* 'Circle:34' else */
  /* 'Circle:35' radius = varargin{1}; */
  /*  Forward only the optional second input to Shape. */
  /* 'Circle:39' obj@Shape(varargin{2:end}); */
  b_obj = c_Shape_Shape(b_obj, varargin_2);
  /* 'Circle:41' obj.Radius = radius; */
  Circle_set_Radius(b_obj, varargin_1);
  return b_obj;
}

/*
 * function a = computeArea(obj)
 *
 * Arguments    : const Circle *obj
 * Return Type  : double
 */
double Circle_computeArea(const Circle *obj)
{
  double b_a;
  /*  Compute the circle area before the Shape-level validation step. */
  /* 'Circle:62' effectiveRadius = obj.Radius * obj.ScaleFactor; */
  b_a = obj->Radius * obj->ScaleFactor;
  /* 'Circle:63' a = pi * effectiveRadius^2; */
  return 3.1415926535897931 * (b_a * b_a);
}

/*
 * function p = computePerimeter(obj)
 *
 * Arguments    : const Circle *obj
 * Return Type  : double
 */
double Circle_computePerimeter(const Circle *obj)
{
  /*  Compute the circle perimeter before the Shape-level validation step. */
  /* 'Circle:68' effectiveRadius = obj.Radius * obj.ScaleFactor; */
  /* 'Circle:69' p = 2 * pi * effectiveRadius; */
  return 6.2831853071795862 * (obj->Radius * obj->ScaleFactor);
}

/*
 * File trailer for Circle.c
 *
 * [EOF]
 */
