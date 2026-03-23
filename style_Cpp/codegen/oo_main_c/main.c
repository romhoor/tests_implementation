/*
 * File: main.c
 *
 * MATLAB Coder version            : 25.2
 * C/C++ source code generated on  : 23-Mar-2026 13:06:47
 */

/* Include Files */
#include "main.h"

/* Function Definitions */
/*
 * main is a minimal object-oriented entry point for probing MATLAB Coder.
 *  It selects one concrete Shape subclass, instantiates it, and returns its
 *  area and perimeter as numeric outputs.
 *
 *  Inputs:
 *    shapeID     - uint8 identifier matching one non-reserved ShapeIDEnum
 *    dim1        - primary geometric dimension
 *    dim2        - secondary geometric dimension, used by Rectangle only
 *    scaleFactor - scaling factor forwarded to Shape
 *
 *  Outputs:
 *    areaValue      - validated area result from the selected shape
 *    perimeterValue - validated perimeter result from the selected shape
 *
 * Arguments    : unsigned char shapeID
 *                double dim1
 *                double dim2
 *                double scaleFactor
 *                double *areaValue
 *                double *perimeterValue
 * Return Type  : void
 */
void main(unsigned char shapeID, double dim1, double dim2, double scaleFactor,
          double *areaValue, double *perimeterValue)
{
  switch (shapeID) {
  case 1U: {
    double a;
    /*  Constructor. */
    /*  Supported constructor calls are: */
    /*  Square()                    -> Side = 1, ScaleFactor = 1 */
    /*  Square(side)               -> Side = side, ScaleFactor = 1 */
    /*  Square(side, scaleFactor)  -> Side = side, ScaleFactor = scaleFactor */
    /*  */
    /*  The first input always refers to the Square-specific property */
    /*  Side. The optional second input is forwarded to Shape as the */
    /*  scale factor. */
    /*  When no side is provided, use the Square default side length. */
    /*  Forward only the optional second input to Shape. */
    /*  This keeps the default scale-factor behavior owned by Shape. */
    /*  Default the scale factor to 1 when no value is provided. */
    /*  Constructor. */
    /*  Builds a Shape object and initializes its scale factor. */
    /*  If no input argument is given, the scale factor defaults to 1. */
    /*  Each concrete subclass must define a valid non-reserved */
    /*  shape ID from ShapeIDEnum. */
    /*  Public area method. */
    /*  Shape owns this public contract and validates that every */
    /*  concrete subclass returns a finite nonnegative scalar area. */
    /*  Compute the square area before the Shape-level validation step. */
    a = dim1 * scaleFactor;
    *areaValue = a * a;
    /*  Public perimeter method. */
    /*  Shape owns this public contract and validates that every */
    /*  concrete subclass returns a finite nonnegative scalar perimeter. */
    /*  Compute the square perimeter before the Shape-level validation step. */
    *perimeterValue = 4.0 * a;
  } break;
  case 2U: {
    double a;
    double areaValue_tmp;
    /*  Constructor. */
    /*  Supported constructor calls are: */
    /*  Rectangle()                        -> Width = 1, Height = 1, ScaleFactor
     * = 1 */
    /*  Rectangle(width, height)          -> Width = width, Height = height,
     * ScaleFactor = 1 */
    /*  Rectangle(width, height, scaleFactor) */
    /*                                   -> Width = width, Height = height,
     * ScaleFactor = scaleFactor */
    /*  */
    /*  The first two inputs always refer to Rectangle-specific */
    /*  properties. The optional third input is forwarded to Shape as */
    /*  the scale factor. */
    /*  Forward only the optional third input to Shape. */
    /*  Default the scale factor to 1 when no value is provided. */
    /*  Constructor. */
    /*  Builds a Shape object and initializes its scale factor. */
    /*  If no input argument is given, the scale factor defaults to 1. */
    /*  Each concrete subclass must define a valid non-reserved */
    /*  shape ID from ShapeIDEnum. */
    /*  Public area method. */
    /*  Shape owns this public contract and validates that every */
    /*  concrete subclass returns a finite nonnegative scalar area. */
    /*  Compute the rectangle area before the Shape-level validation step. */
    a = dim1 * scaleFactor;
    areaValue_tmp = dim2 * scaleFactor;
    *areaValue = a * areaValue_tmp;
    /*  Public perimeter method. */
    /*  Shape owns this public contract and validates that every */
    /*  concrete subclass returns a finite nonnegative scalar perimeter. */
    /*  Compute the rectangle perimeter before the Shape-level validation step.
     */
    *perimeterValue = 2.0 * (a + areaValue_tmp);
  } break;
  case 3U: {
    double a;
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
    /*  Forward only the optional second input to Shape. */
    /*  Default the scale factor to 1 when no value is provided. */
    /*  Constructor. */
    /*  Builds a Shape object and initializes its scale factor. */
    /*  If no input argument is given, the scale factor defaults to 1. */
    /*  Each concrete subclass must define a valid non-reserved */
    /*  shape ID from ShapeIDEnum. */
    /*  Public area method. */
    /*  Shape owns this public contract and validates that every */
    /*  concrete subclass returns a finite nonnegative scalar area. */
    /*  Compute the circle area before the Shape-level validation step. */
    a = dim1 * scaleFactor;
    *areaValue = 3.1415926535897931 * (a * a);
    /*  Public perimeter method. */
    /*  Shape owns this public contract and validates that every */
    /*  concrete subclass returns a finite nonnegative scalar perimeter. */
    /*  Compute the circle perimeter before the Shape-level validation step. */
    *perimeterValue = 6.2831853071795862 * a;
  } break;
  }
}

/*
 * File trailer for main.c
 *
 * [EOF]
 */
