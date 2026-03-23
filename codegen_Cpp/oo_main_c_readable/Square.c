/*
 * File: Square.c
 *
 * MATLAB Coder version            : 25.2
 * C/C++ source code generated on  : 23-Mar-2026 13:20:27
 */

/* Include Files */
#include "Square.h"
#include "Shape.h"
#include "main_internal_types.h"
#include "validator_check_type.h"

/* Function Declarations */
static void Square_set_Side(Square *obj, double val);

/* Function Definitions */
/*
 * Arguments    : Square *obj
 *                double val
 * Return Type  : void
 */
static void Square_set_Side(Square *obj, double val)
{
  /* 'Square:13' double */
  /* 'Square:13' (1,1) */
  obj->Side = validator_check_type(validator_check_type(val));
  /* 'Square:13' Side */
}

/*
 * function obj = Square(varargin)
 *
 * Arguments    : Square *obj
 *                double varargin_1
 *                double varargin_2
 * Return Type  : Square *
 */
Square *Square_Square(Square *obj, double varargin_1, double varargin_2)
{
  Square *b_obj;
  b_obj = obj;
  /*  Constructor. */
  /*  Supported constructor calls are: */
  /*  Square()                    -> Side = 1, ScaleFactor = 1 */
  /*  Square(side)               -> Side = side, ScaleFactor = 1 */
  /*  Square(side, scaleFactor)  -> Side = side, ScaleFactor = scaleFactor */
  /*  */
  /*  The first input always refers to the Square-specific property */
  /*  Side. The optional second input is forwarded to Shape as the */
  /*  scale factor. */
  /* 'Square:27' if nargin > 2 */
  /*  When no side is provided, use the Square default side length. */
  /* 'Square:33' if nargin < 1 */
  /* 'Square:35' else */
  /* 'Square:36' side = varargin{1}; */
  /*  Forward only the optional second input to Shape. */
  /*  This keeps the default scale-factor behavior owned by Shape. */
  /* 'Square:41' obj@Shape(varargin{2:end}); */
  b_obj = Shape_Shape(b_obj, varargin_2);
  /* 'Square:43' obj.Side = side; */
  Square_set_Side(b_obj, varargin_1);
  return b_obj;
}

/*
 * function a = computeArea(obj)
 *
 * Arguments    : const Square *obj
 * Return Type  : double
 */
double Square_computeArea(const Square *obj)
{
  double b_a;
  /*  Compute the square area before the Shape-level validation step. */
  /* 'Square:64' effectiveSide = obj.Side * obj.ScaleFactor; */
  b_a = obj->Side * obj->ScaleFactor;
  /* 'Square:65' a = effectiveSide^2; */
  return b_a * b_a;
}

/*
 * function p = computePerimeter(obj)
 *
 * Arguments    : const Square *obj
 * Return Type  : double
 */
double Square_computePerimeter(const Square *obj)
{
  /*  Compute the square perimeter before the Shape-level validation step. */
  /* 'Square:70' effectiveSide = obj.Side * obj.ScaleFactor; */
  /* 'Square:71' p = 4 * effectiveSide; */
  return 4.0 * (obj->Side * obj->ScaleFactor);
}

/*
 * File trailer for Square.c
 *
 * [EOF]
 */
