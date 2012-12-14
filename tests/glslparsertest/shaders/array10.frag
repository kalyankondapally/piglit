// [config]
// expect_result: fail
// glsl_version: 1.10
// glsles_version: 1.00
//
// [end config]


void main()
{
    float f[];
    float flt = f[5];
    float f[3];  // higher array index has already been used
}
