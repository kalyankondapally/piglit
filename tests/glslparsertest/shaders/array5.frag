// [config]
// expect_result: fail
// glsl_version: 1.10
// glsles_version: 1.00
//
// [end config]

void main()
{
    int i = 3;
    float f[i]; // arrays should be declared with a constant size
}
