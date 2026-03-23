/*
 * File: _coder_main_api.h
 *
 * MATLAB Coder version            : 25.2
 * C/C++ source code generated on  : 23-Mar-2026 13:20:27
 */

#pragma once

/* Include Files */
#include "emlrt.h"
#include "mex.h"
#include "tmwtypes.h"
#include <string.h>

/* Variable Declarations */
extern emlrtCTX emlrtRootTLSGlobal;
extern emlrtContext emlrtContextGlobal;

#ifdef __cplusplus
extern "C" {
#endif

/* Function Declarations */
void main(uint8_T shapeID, real_T dim1, real_T dim2, real_T scaleFactor,
          real_T *areaValue, real_T *perimeterValue);

void main_api(const mxArray *const prhs[4], int32_T nlhs,
              const mxArray *plhs[2]);

void main_atexit(void);

void main_initialize(void);

void main_terminate(void);

void main_xil_shutdown(void);

void main_xil_terminate(void);

#ifdef __cplusplus
}
#endif

/*
 * File trailer for _coder_main_api.h
 *
 * [EOF]
 */
