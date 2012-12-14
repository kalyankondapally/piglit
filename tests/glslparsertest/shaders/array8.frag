// [config]
// expect_result: fail
// glsl_version: 1.10
// glsles_version: 1.00
//
// [end config]

void main()
{
    float f[5];
    float f[];  // redeclaration of array already declared with a size
}
