/*
 * main.c
 *
 * Code generation for function 'main'
 *
 */

/* Include files */
#include "main.h"
#include "rt_nonfinite.h"
#include "mwmathutil.h"

/* Variable Definitions */
static emlrtRSInfo emlrtRSI = {
    24,     /* lineNo */
    "main", /* fcnName */
    "/home/roman.horshkov/projects/tests_implementation/main/main.m" /* pathName
                                                                      */
};

static emlrtRSInfo b_emlrtRSI = {
    25,     /* lineNo */
    "main", /* fcnName */
    "/home/roman.horshkov/projects/tests_implementation/main/main.m" /* pathName
                                                                      */
};

static emlrtRSInfo c_emlrtRSI = {
    26,     /* lineNo */
    "main", /* fcnName */
    "/home/roman.horshkov/projects/tests_implementation/main/main.m" /* pathName
                                                                      */
};

static emlrtRSInfo d_emlrtRSI = {
    29,     /* lineNo */
    "main", /* fcnName */
    "/home/roman.horshkov/projects/tests_implementation/main/main.m" /* pathName
                                                                      */
};

static emlrtRSInfo e_emlrtRSI = {
    30,     /* lineNo */
    "main", /* fcnName */
    "/home/roman.horshkov/projects/tests_implementation/main/main.m" /* pathName
                                                                      */
};

static emlrtRSInfo f_emlrtRSI = {
    31,     /* lineNo */
    "main", /* fcnName */
    "/home/roman.horshkov/projects/tests_implementation/main/main.m" /* pathName
                                                                      */
};

static emlrtRSInfo g_emlrtRSI = {
    34,     /* lineNo */
    "main", /* fcnName */
    "/home/roman.horshkov/projects/tests_implementation/main/main.m" /* pathName
                                                                      */
};

static emlrtRSInfo h_emlrtRSI = {
    35,     /* lineNo */
    "main", /* fcnName */
    "/home/roman.horshkov/projects/tests_implementation/main/main.m" /* pathName
                                                                      */
};

static emlrtRSInfo i_emlrtRSI = {
    36,     /* lineNo */
    "main", /* fcnName */
    "/home/roman.horshkov/projects/tests_implementation/main/main.m" /* pathName
                                                                      */
};

static emlrtRSInfo j_emlrtRSI = {
    39,     /* lineNo */
    "main", /* fcnName */
    "/home/roman.horshkov/projects/tests_implementation/main/main.m" /* pathName
                                                                      */
};

static emlrtRSInfo k_emlrtRSI = {
    41,              /* lineNo */
    "Square/Square", /* fcnName */
    "/home/roman.horshkov/projects/tests_implementation/classes_derived/"
    "Square.m" /* pathName */
};

static emlrtRSInfo l_emlrtRSI = {
    43,              /* lineNo */
    "Square/Square", /* fcnName */
    "/home/roman.horshkov/projects/tests_implementation/classes_derived/"
    "Square.m" /* pathName */
};

static emlrtRSInfo o_emlrtRSI =
    {
        68,           /* lineNo */
        "Shape/area", /* fcnName */
        "/home/roman.horshkov/projects/tests_implementation/classes_base/"
        "Shape.m" /* pathName */
};

static emlrtRSInfo p_emlrtRSI =
    {
        69,           /* lineNo */
        "Shape/area", /* fcnName */
        "/home/roman.horshkov/projects/tests_implementation/classes_base/"
        "Shape.m" /* pathName */
};

static emlrtRSInfo t_emlrtRSI =
    {
        93,                   /* lineNo */
        "validateattributes", /* fcnName */
        "/usr/local/MATLAB/R2025b/toolbox/eml/lib/matlab/lang/"
        "validateattributes.m" /* pathName */
};

static emlrtRSInfo u_emlrtRSI =
    {
        76,                /* lineNo */
        "Shape/perimeter", /* fcnName */
        "/home/roman.horshkov/projects/tests_implementation/classes_base/"
        "Shape.m" /* pathName */
};

static emlrtRSInfo v_emlrtRSI =
    {
        77,                /* lineNo */
        "Shape/perimeter", /* fcnName */
        "/home/roman.horshkov/projects/tests_implementation/classes_base/"
        "Shape.m" /* pathName */
};

static emlrtRSInfo w_emlrtRSI = {
    50,                    /* lineNo */
    "Rectangle/Rectangle", /* fcnName */
    "/home/roman.horshkov/projects/tests_implementation/classes_derived/"
    "Rectangle.m" /* pathName */
};

static emlrtRSInfo x_emlrtRSI = {
    52,                    /* lineNo */
    "Rectangle/Rectangle", /* fcnName */
    "/home/roman.horshkov/projects/tests_implementation/classes_derived/"
    "Rectangle.m" /* pathName */
};

static emlrtRSInfo y_emlrtRSI = {
    53,                    /* lineNo */
    "Rectangle/Rectangle", /* fcnName */
    "/home/roman.horshkov/projects/tests_implementation/classes_derived/"
    "Rectangle.m" /* pathName */
};

static emlrtRSInfo ab_emlrtRSI = {
    39,              /* lineNo */
    "Circle/Circle", /* fcnName */
    "/home/roman.horshkov/projects/tests_implementation/classes_derived/"
    "Circle.m" /* pathName */
};

static emlrtRSInfo bb_emlrtRSI = {
    41,              /* lineNo */
    "Circle/Circle", /* fcnName */
    "/home/roman.horshkov/projects/tests_implementation/classes_derived/"
    "Circle.m" /* pathName */
};

static emlrtMCInfo emlrtMCI = {
    27,                                                            /* lineNo */
    5,                                                             /* colNo */
    "error",                                                       /* fName */
    "/usr/local/MATLAB/R2025b/toolbox/eml/lib/matlab/lang/error.m" /* pName */
};

static emlrtRTEInfo emlrtRTEI = {
    14,               /* lineNo */
    37,               /* colNo */
    "validatefinite", /* fName */
    "/usr/local/MATLAB/R2025b/toolbox/eml/eml/+coder/+internal/+valattr/"
    "validatefinite.m" /* pName */
};

static emlrtRTEInfo b_emlrtRTEI = {
    14,                    /* lineNo */
    37,                    /* colNo */
    "validatenonnegative", /* fName */
    "/usr/local/MATLAB/R2025b/toolbox/eml/eml/+coder/+internal/+valattr/"
    "validatenonnegative.m" /* pName */
};

static emlrtRSInfo db_emlrtRSI = {
    27,                                                            /* lineNo */
    "error",                                                       /* fcnName */
    "/usr/local/MATLAB/R2025b/toolbox/eml/lib/matlab/lang/error.m" /* pathName
                                                                    */
};

/* Function Declarations */
static void b_error(const emlrtStack *sp, const mxArray *m, const mxArray *m1,
                    emlrtMCInfo *location);

/* Function Definitions */
static void b_error(const emlrtStack *sp, const mxArray *m, const mxArray *m1,
                    emlrtMCInfo *location)
{
  const mxArray *pArrays[2];
  pArrays[0] = m;
  pArrays[1] = m1;
  emlrtCallMATLABR2012b((emlrtConstCTX)sp, 0, NULL, 2, &pArrays[0], "error",
                        true, location);
}

void main(const emlrtStack *sp, uint8_T shapeID, real_T dim1, real_T dim2,
          real_T scaleFactor, real_T *areaValue, real_T *perimeterValue)
{
  static const int32_T iv[2] = {1, 19};
  static const int32_T iv1[2] = {1, 49};
  static const char_T varargin_2[49] = {
      's', 'h', 'a', 'p', 'e', 'I', 'D', ' ', 'm', 'u', 's', 't', ' ',
      's', 'e', 'l', 'e', 'c', 't', ' ', 'S', 'q', 'u', 'a', 'r', 'e',
      ',', ' ', 'R', 'e', 'c', 't', 'a', 'n', 'g', 'l', 'e', ',', ' ',
      'o', 'r', ' ', 'C', 'i', 'r', 'c', 'l', 'e', '.'};
  static const char_T varargin_1[19] = {'m', 'a', 'i', 'n', ':', 'I', 'n',
                                        'v', 'a', 'l', 'i', 'd', 'S', 'h',
                                        'a', 'p', 'e', 'I', 'D'};
  emlrtStack b_st;
  emlrtStack c_st;
  emlrtStack st;
  const mxArray *b_y;
  const mxArray *m;
  const mxArray *y;
  st.prev = sp;
  st.tls = sp->tls;
  b_st.prev = &st;
  b_st.tls = st.tls;
  c_st.prev = &b_st;
  c_st.tls = b_st.tls;
  /*  main is a minimal object-oriented entry point for probing MATLAB Coder. */
  /*  It selects one concrete Shape subclass, instantiates it, and returns its
   */
  /*  area and perimeter as numeric outputs. */
  /*  */
  /*  Inputs: */
  /*    shapeID     - uint8 identifier matching one non-reserved ShapeIDEnum */
  /*    dim1        - primary geometric dimension */
  /*    dim2        - secondary geometric dimension, used by Rectangle only */
  /*    scaleFactor - scaling factor forwarded to Shape */
  /*  */
  /*  Outputs: */
  /*    areaValue      - validated area result from the selected shape */
  /*    perimeterValue - validated perimeter result from the selected shape */
  switch (shapeID) {
  case 1U: {
    real_T a;
    st.site = &emlrtRSI;
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
    b_st.site = &k_emlrtRSI;
    /*  Constructor. */
    /*  Builds a Shape object and initializes its scale factor. */
    /*  If no input argument is given, the scale factor defaults to 1. */
    /*  Default the scale factor to 1 when no value is provided. */
    /*  Each concrete subclass must define a valid non-reserved */
    /*  shape ID from ShapeIDEnum. */
    b_st.site = &l_emlrtRSI;
    st.site = &b_emlrtRSI;
    /*  Public area method. */
    /*  Shape owns this public contract and validates that every */
    /*  concrete subclass returns a finite nonnegative scalar area. */
    b_st.site = &o_emlrtRSI;
    /*  Compute the square area before the Shape-level validation step. */
    a = dim1 * scaleFactor;
    *areaValue = a * a;
    b_st.site = &p_emlrtRSI;
    c_st.site = &t_emlrtRSI;
    if (muDoubleScalarIsInf(*areaValue) || muDoubleScalarIsNaN(*areaValue)) {
      emlrtErrorWithMessageIdR2018a(
          &c_st, &emlrtRTEI, "Coder:toolbox:ValidateattributesexpectedFinite",
          "MATLAB:expectedFinite", 3, 4, 5, "input");
    }
    st.site = &c_emlrtRSI;
    /*  Public perimeter method. */
    /*  Shape owns this public contract and validates that every */
    /*  concrete subclass returns a finite nonnegative scalar perimeter. */
    b_st.site = &u_emlrtRSI;
    /*  Compute the square perimeter before the Shape-level validation step. */
    *perimeterValue = 4.0 * a;
    b_st.site = &v_emlrtRSI;
    c_st.site = &t_emlrtRSI;
    if (muDoubleScalarIsInf(*perimeterValue) ||
        muDoubleScalarIsNaN(*perimeterValue)) {
      emlrtErrorWithMessageIdR2018a(
          &c_st, &emlrtRTEI, "Coder:toolbox:ValidateattributesexpectedFinite",
          "MATLAB:expectedFinite", 3, 4, 5, "input");
    }
    c_st.site = &t_emlrtRSI;
    if (*perimeterValue < 0.0) {
      emlrtErrorWithMessageIdR2018a(
          &c_st, &b_emlrtRTEI,
          "Coder:toolbox:ValidateattributesexpectedNonnegative",
          "MATLAB:expectedNonnegative", 3, 4, 5, "input");
    }
  } break;
  case 2U: {
    real_T a;
    real_T areaValue_tmp;
    st.site = &d_emlrtRSI;
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
    b_st.site = &w_emlrtRSI;
    /*  Constructor. */
    /*  Builds a Shape object and initializes its scale factor. */
    /*  If no input argument is given, the scale factor defaults to 1. */
    /*  Default the scale factor to 1 when no value is provided. */
    /*  Each concrete subclass must define a valid non-reserved */
    /*  shape ID from ShapeIDEnum. */
    b_st.site = &x_emlrtRSI;
    b_st.site = &y_emlrtRSI;
    st.site = &e_emlrtRSI;
    /*  Public area method. */
    /*  Shape owns this public contract and validates that every */
    /*  concrete subclass returns a finite nonnegative scalar area. */
    b_st.site = &o_emlrtRSI;
    /*  Compute the rectangle area before the Shape-level validation step. */
    a = dim1 * scaleFactor;
    areaValue_tmp = dim2 * scaleFactor;
    *areaValue = a * areaValue_tmp;
    b_st.site = &p_emlrtRSI;
    c_st.site = &t_emlrtRSI;
    if (muDoubleScalarIsInf(*areaValue) || muDoubleScalarIsNaN(*areaValue)) {
      emlrtErrorWithMessageIdR2018a(
          &c_st, &emlrtRTEI, "Coder:toolbox:ValidateattributesexpectedFinite",
          "MATLAB:expectedFinite", 3, 4, 5, "input");
    }
    c_st.site = &t_emlrtRSI;
    if (*areaValue < 0.0) {
      emlrtErrorWithMessageIdR2018a(
          &c_st, &b_emlrtRTEI,
          "Coder:toolbox:ValidateattributesexpectedNonnegative",
          "MATLAB:expectedNonnegative", 3, 4, 5, "input");
    }
    st.site = &f_emlrtRSI;
    /*  Public perimeter method. */
    /*  Shape owns this public contract and validates that every */
    /*  concrete subclass returns a finite nonnegative scalar perimeter. */
    b_st.site = &u_emlrtRSI;
    /*  Compute the rectangle perimeter before the Shape-level validation step.
     */
    *perimeterValue = 2.0 * (a + areaValue_tmp);
    b_st.site = &v_emlrtRSI;
    c_st.site = &t_emlrtRSI;
    if (muDoubleScalarIsInf(*perimeterValue) ||
        muDoubleScalarIsNaN(*perimeterValue)) {
      emlrtErrorWithMessageIdR2018a(
          &c_st, &emlrtRTEI, "Coder:toolbox:ValidateattributesexpectedFinite",
          "MATLAB:expectedFinite", 3, 4, 5, "input");
    }
    c_st.site = &t_emlrtRSI;
    if (*perimeterValue < 0.0) {
      emlrtErrorWithMessageIdR2018a(
          &c_st, &b_emlrtRTEI,
          "Coder:toolbox:ValidateattributesexpectedNonnegative",
          "MATLAB:expectedNonnegative", 3, 4, 5, "input");
    }
  } break;
  case 3U: {
    real_T a;
    st.site = &g_emlrtRSI;
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
    b_st.site = &ab_emlrtRSI;
    /*  Constructor. */
    /*  Builds a Shape object and initializes its scale factor. */
    /*  If no input argument is given, the scale factor defaults to 1. */
    /*  Default the scale factor to 1 when no value is provided. */
    /*  Each concrete subclass must define a valid non-reserved */
    /*  shape ID from ShapeIDEnum. */
    b_st.site = &bb_emlrtRSI;
    st.site = &h_emlrtRSI;
    /*  Public area method. */
    /*  Shape owns this public contract and validates that every */
    /*  concrete subclass returns a finite nonnegative scalar area. */
    b_st.site = &o_emlrtRSI;
    /*  Compute the circle area before the Shape-level validation step. */
    a = dim1 * scaleFactor;
    *areaValue = 3.1415926535897931 * (a * a);
    b_st.site = &p_emlrtRSI;
    c_st.site = &t_emlrtRSI;
    if (muDoubleScalarIsInf(*areaValue) || muDoubleScalarIsNaN(*areaValue)) {
      emlrtErrorWithMessageIdR2018a(
          &c_st, &emlrtRTEI, "Coder:toolbox:ValidateattributesexpectedFinite",
          "MATLAB:expectedFinite", 3, 4, 5, "input");
    }
    st.site = &i_emlrtRSI;
    /*  Public perimeter method. */
    /*  Shape owns this public contract and validates that every */
    /*  concrete subclass returns a finite nonnegative scalar perimeter. */
    b_st.site = &u_emlrtRSI;
    /*  Compute the circle perimeter before the Shape-level validation step. */
    *perimeterValue = 6.2831853071795862 * a;
    b_st.site = &v_emlrtRSI;
    c_st.site = &t_emlrtRSI;
    if (muDoubleScalarIsInf(*perimeterValue) ||
        muDoubleScalarIsNaN(*perimeterValue)) {
      emlrtErrorWithMessageIdR2018a(
          &c_st, &emlrtRTEI, "Coder:toolbox:ValidateattributesexpectedFinite",
          "MATLAB:expectedFinite", 3, 4, 5, "input");
    }
    c_st.site = &t_emlrtRSI;
    if (*perimeterValue < 0.0) {
      emlrtErrorWithMessageIdR2018a(
          &c_st, &b_emlrtRTEI,
          "Coder:toolbox:ValidateattributesexpectedNonnegative",
          "MATLAB:expectedNonnegative", 3, 4, 5, "input");
    }
  } break;
  default:
    st.site = &j_emlrtRSI;
    y = NULL;
    m = emlrtCreateCharArray(2, &iv[0]);
    emlrtInitCharArrayR2013a(&st, 19, m, &varargin_1[0]);
    emlrtAssign(&y, m);
    b_y = NULL;
    m = emlrtCreateCharArray(2, &iv1[0]);
    emlrtInitCharArrayR2013a(&st, 49, m, &varargin_2[0]);
    emlrtAssign(&b_y, m);
    b_st.site = &db_emlrtRSI;
    b_error(&b_st, y, b_y, &emlrtMCI);
    break;
  }
}

/* End of code generation (main.c) */
