/*
 * File: _coder_main_mex.h
 *
 * MATLAB Coder version            : 25.2
 * C/C++ source code generated on  : 23-Mar-2026 13:20:27
 */

#pragma once

/* Include Files */
#include "emlrt.h"
#include "mex.h"
#include "tmwtypes.h"

#ifdef __cplusplus
extern "C" {
#endif

/* Function Declarations */
MEXFUNCTION_LINKAGE void mexFunction(int32_T nlhs, mxArray *plhs[],
                                     int32_T nrhs, const mxArray *prhs[]);

emlrtCTX mexFunctionCreateRootTLS(void);

void unsafe_main_mexFunction(int32_T nlhs, mxArray *plhs[2], int32_T nrhs,
                             const mxArray *prhs[4]);

#ifdef __cplusplus
}
#endif

/*
 * File trailer for _coder_main_mex.h
 *
 * [EOF]
 */
