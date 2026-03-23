/*
 * File: Shape.c
 *
 * MATLAB Coder version            : 25.2
 * C/C++ source code generated on  : 23-Mar-2026 13:20:27
 */

/* Include Files */
#include "Shape.h"
#include "Circle.h"
#include "Rectangle.h"
#include "Square.h"
#include "handle.h"
#include "main_internal_types.h"
#include "validator_check_type.h"

/* Function Declarations */
static void Shape_set_ScaleFactor(Square *obj, double val);

static void b_Shape_set_ScaleFactor(Rectangle *obj, double val);

static void c_Shape_set_ScaleFactor(Circle *obj, double val);

/* Function Definitions */
/*
 * Arguments    : Square *obj
 *                double val
 * Return Type  : void
 */
static void Shape_set_ScaleFactor(Square *obj, double val)
{
  /* 'Shape:10' double */
  /* 'Shape:10' (1,1) */
  obj->ScaleFactor = validator_check_type(validator_check_type(val));
  /* 'Shape:10' ScaleFactor */
}

/*
 * Arguments    : Rectangle *obj
 *                double val
 * Return Type  : void
 */
static void b_Shape_set_ScaleFactor(Rectangle *obj, double val)
{
  /* 'Shape:10' double */
  /* 'Shape:10' (1,1) */
  obj->ScaleFactor = validator_check_type(validator_check_type(val));
  /* 'Shape:10' ScaleFactor */
}

/*
 * Arguments    : Circle *obj
 *                double val
 * Return Type  : void
 */
static void c_Shape_set_ScaleFactor(Circle *obj, double val)
{
  /* 'Shape:10' double */
  /* 'Shape:10' (1,1) */
  obj->ScaleFactor = validator_check_type(validator_check_type(val));
  /* 'Shape:10' ScaleFactor */
}

/*
 * function obj = Shape(scaleFactor)
 *
 * Default the scale factor to 1 when no value is provided.
 *
 * Arguments    : Square *obj
 *                double scaleFactor
 * Return Type  : Square *
 */
Square *Shape_Shape(Square *obj, double scaleFactor)
{
  Square *b_obj;
  b_obj = obj;
  /*  Constructor. */
  /*  Builds a Shape object and initializes its scale factor. */
  /*  If no input argument is given, the scale factor defaults to 1. */
  /* 'Shape:35' if nargin < 1 */
  /* 'Shape:5' handle */
  b_obj = handle_handle(b_obj);
  /* 'Shape:39' obj.ScaleFactor = scaleFactor; */
  Shape_set_ScaleFactor(b_obj, scaleFactor);
  /*  Each concrete subclass must define a valid non-reserved */
  /*  shape ID from ShapeIDEnum. */
  /* 'Shape:43' if ~Shape.isConcreteShapeIDValid(obj.shape_id) */
  return b_obj;
}

/*
 * function a = area(obj)
 *
 * Arguments    : const Square *obj
 * Return Type  : double
 */
double Shape_area(const Square *obj)
{
  /*  Public area method. */
  /*  Shape owns this public contract and validates that every */
  /*  concrete subclass returns a finite nonnegative scalar area. */
  /* 'Shape:68' a = obj.computeArea(); */
  return Square_computeArea(obj);
  /* 'Shape:69' validateattributes(a, {'double'}, {'scalar', 'finite',
   * 'nonnegative'}); */
}

/*
 * function p = perimeter(obj)
 *
 * Arguments    : const Square *obj
 * Return Type  : double
 */
double Shape_perimeter(const Square *obj)
{
  /*  Public perimeter method. */
  /*  Shape owns this public contract and validates that every */
  /*  concrete subclass returns a finite nonnegative scalar perimeter. */
  /* 'Shape:76' p = obj.computePerimeter(); */
  return Square_computePerimeter(obj);
  /* 'Shape:77' validateattributes(p, {'double'}, {'scalar', 'finite',
   * 'nonnegative'}); */
}

/*
 * function obj = Shape(scaleFactor)
 *
 * Default the scale factor to 1 when no value is provided.
 *
 * Arguments    : Rectangle *obj
 *                double scaleFactor
 * Return Type  : Rectangle *
 */
Rectangle *b_Shape_Shape(Rectangle *obj, double scaleFactor)
{
  Rectangle *b_obj;
  b_obj = obj;
  /*  Constructor. */
  /*  Builds a Shape object and initializes its scale factor. */
  /*  If no input argument is given, the scale factor defaults to 1. */
  /* 'Shape:35' if nargin < 1 */
  /* 'Shape:5' handle */
  b_obj = b_handle_handle(b_obj);
  /* 'Shape:39' obj.ScaleFactor = scaleFactor; */
  b_Shape_set_ScaleFactor(b_obj, scaleFactor);
  /*  Each concrete subclass must define a valid non-reserved */
  /*  shape ID from ShapeIDEnum. */
  /* 'Shape:43' if ~Shape.isConcreteShapeIDValid(obj.shape_id) */
  return b_obj;
}

/*
 * function a = area(obj)
 *
 * Arguments    : const Rectangle *obj
 * Return Type  : double
 */
double b_Shape_area(const Rectangle *obj)
{
  /*  Public area method. */
  /*  Shape owns this public contract and validates that every */
  /*  concrete subclass returns a finite nonnegative scalar area. */
  /* 'Shape:68' a = obj.computeArea(); */
  return Rectangle_computeArea(obj);
  /* 'Shape:69' validateattributes(a, {'double'}, {'scalar', 'finite',
   * 'nonnegative'}); */
}

/*
 * function p = perimeter(obj)
 *
 * Arguments    : const Rectangle *obj
 * Return Type  : double
 */
double b_Shape_perimeter(const Rectangle *obj)
{
  /*  Public perimeter method. */
  /*  Shape owns this public contract and validates that every */
  /*  concrete subclass returns a finite nonnegative scalar perimeter. */
  /* 'Shape:76' p = obj.computePerimeter(); */
  return Rectangle_computePerimeter(obj);
  /* 'Shape:77' validateattributes(p, {'double'}, {'scalar', 'finite',
   * 'nonnegative'}); */
}

/*
 * function obj = Shape(scaleFactor)
 *
 * Default the scale factor to 1 when no value is provided.
 *
 * Arguments    : Circle *obj
 *                double scaleFactor
 * Return Type  : Circle *
 */
Circle *c_Shape_Shape(Circle *obj, double scaleFactor)
{
  Circle *b_obj;
  b_obj = obj;
  /*  Constructor. */
  /*  Builds a Shape object and initializes its scale factor. */
  /*  If no input argument is given, the scale factor defaults to 1. */
  /* 'Shape:35' if nargin < 1 */
  /* 'Shape:5' handle */
  b_obj = c_handle_handle(b_obj);
  /* 'Shape:39' obj.ScaleFactor = scaleFactor; */
  c_Shape_set_ScaleFactor(b_obj, scaleFactor);
  /*  Each concrete subclass must define a valid non-reserved */
  /*  shape ID from ShapeIDEnum. */
  /* 'Shape:43' if ~Shape.isConcreteShapeIDValid(obj.shape_id) */
  return b_obj;
}

/*
 * function a = area(obj)
 *
 * Arguments    : const Circle *obj
 * Return Type  : double
 */
double c_Shape_area(const Circle *obj)
{
  /*  Public area method. */
  /*  Shape owns this public contract and validates that every */
  /*  concrete subclass returns a finite nonnegative scalar area. */
  /* 'Shape:68' a = obj.computeArea(); */
  return Circle_computeArea(obj);
  /* 'Shape:69' validateattributes(a, {'double'}, {'scalar', 'finite',
   * 'nonnegative'}); */
}

/*
 * function p = perimeter(obj)
 *
 * Arguments    : const Circle *obj
 * Return Type  : double
 */
double c_Shape_perimeter(const Circle *obj)
{
  /*  Public perimeter method. */
  /*  Shape owns this public contract and validates that every */
  /*  concrete subclass returns a finite nonnegative scalar perimeter. */
  /* 'Shape:76' p = obj.computePerimeter(); */
  return Circle_computePerimeter(obj);
  /* 'Shape:77' validateattributes(p, {'double'}, {'scalar', 'finite',
   * 'nonnegative'}); */
}

/*
 * File trailer for Shape.c
 *
 * [EOF]
 */
