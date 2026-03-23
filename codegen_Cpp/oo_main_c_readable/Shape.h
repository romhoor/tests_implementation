/*
 * File: Shape.h
 *
 * MATLAB Coder version            : 25.2
 * C/C++ source code generated on  : 23-Mar-2026 13:20:27
 */

#pragma once

/* Include Files */
#include "main_internal_types.h"
#include "rtwtypes.h"
#include <stddef.h>
#include <stdlib.h>

#ifdef __cplusplus
extern "C" {
#endif

/* Function Declarations */
Square *Shape_Shape(Square *obj, double scaleFactor);

double Shape_area(const Square *obj);

double Shape_perimeter(const Square *obj);

Rectangle *b_Shape_Shape(Rectangle *obj, double scaleFactor);

double b_Shape_area(const Rectangle *obj);

double b_Shape_perimeter(const Rectangle *obj);

Circle *c_Shape_Shape(Circle *obj, double scaleFactor);

double c_Shape_area(const Circle *obj);

double c_Shape_perimeter(const Circle *obj);

#ifdef __cplusplus
}
#endif

/*
 * File trailer for Shape.h
 *
 * [EOF]
 */
