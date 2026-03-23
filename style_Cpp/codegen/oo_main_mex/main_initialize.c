/*
 * main_initialize.c
 *
 * Code generation for function 'main_initialize'
 *
 */

/* Include files */
#include "main_initialize.h"
#include "_coder_main_mex.h"
#include "main_data.h"
#include "rt_nonfinite.h"

/* Function Declarations */
static void main_once(void);

/* Function Definitions */
static void main_once(void)
{
  mex_InitInfAndNan();
}

void main_initialize(void)
{
  static const volatile char_T *emlrtBreakCheckR2012bFlagVar = NULL;
  emlrtStack st = {
      NULL, /* site */
      NULL, /* tls */
      NULL  /* prev */
  };
  mexFunctionCreateRootTLS();
  st.tls = emlrtRootTLSGlobal;
  emlrtBreakCheckR2012bFlagVar = emlrtGetBreakCheckFlagAddressR2022b(&st);
  emlrtClearAllocCountR2012b(&st, false, 0U, NULL);
  emlrtEnterRtStackR2012b(&st);
  if (emlrtFirstTimeR2012b(emlrtRootTLSGlobal)) {
    main_once();
  }
}

/* End of code generation (main_initialize.c) */
