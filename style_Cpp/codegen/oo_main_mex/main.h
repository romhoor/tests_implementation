/*
 * main.h
 *
 * Code generation for function 'main'
 *
 */

#pragma once

/* Include files */
#include "rtwtypes.h"
#include "emlrt.h"
#include "mex.h"
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* Function Declarations */
void main(const emlrtStack *sp, uint8_T shapeID, real_T dim1, real_T dim2,
          real_T scaleFactor, real_T *areaValue, real_T *perimeterValue);

/* End of code generation (main.h) */
