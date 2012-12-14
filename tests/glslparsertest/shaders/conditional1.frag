// [config]
// expect_result: fail
// glsl_version: 1.10
// glsles_version: 1.00
//
// [end config]

void main()
{
    float f1,f2;
    int i;
    float f3 = i ? f1 : f2;  // expression must be boolean and not int
}
