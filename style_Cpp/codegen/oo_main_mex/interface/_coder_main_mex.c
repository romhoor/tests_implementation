/*
 * _coder_main_mex.c
 *
 * Code generation for function '_coder_main_mex'
 *
 */

/* Include files */
#include "_coder_main_mex.h"
#include "_coder_main_api.h"
#include "main_data.h"
#include "main_initialize.h"
#include "main_terminate.h"
#include "rt_nonfinite.h"

/* Function Definitions */
void main_mexFunction(int32_T nlhs, mxArray *plhs[2], int32_T nrhs,
                      const mxArray *prhs[4])
{
  emlrtStack st = {
      NULL, /* site */
      NULL, /* tls */
      NULL  /* prev */
  };
  const mxArray *outputs[2];
  int32_T i;
  st.tls = emlrtRootTLSGlobal;
  /* Check for proper number of arguments. */
  if (nrhs != 4) {
    emlrtErrMsgIdAndTxt(&st, "EMLRT:runTime:WrongNumberOfInputs", 5, 12, 4, 4,
                        4, "main");
  }
  if (nlhs > 2) {
    emlrtErrMsgIdAndTxt(&st, "EMLRT:runTime:TooManyOutputArguments", 3, 4, 4,
                        "main");
  }
  /* Call the function. */
  main_api(prhs, nlhs, outputs);
  /* Copy over outputs to the caller. */
  if (nlhs < 1) {
    i = 1;
  } else {
    i = nlhs;
  }
  emlrtReturnArrays(i, &plhs[0], &outputs[0]);
}

void mexFunction(int32_T nlhs, mxArray *plhs[], int32_T nrhs,
                 const mxArray *prhs[])
{
  mexAtExit(&main_atexit);
  main_initialize();
  main_mexFunction(nlhs, plhs, nrhs, prhs);
  main_terminate();
}

emlrtCTX mexFunctionCreateRootTLS(void)
{
  emlrtCreateRootTLSR2022a(&emlrtRootTLSGlobal, &emlrtContextGlobal, NULL, 1,
                           NULL, "UTF-8", true);
  return emlrtRootTLSGlobal;
}

/* End of code generation (_coder_main_mex.c) */
