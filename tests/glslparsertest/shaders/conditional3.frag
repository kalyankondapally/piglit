// [config]
// expect_result: fail
// glsl_version: 1.10
// glsles_version: 1.00
//
// [end config]

void main()
{
    float f1,f2;
    bool b;
    int i = b ? f1 : f2; // second and third expression type does not match the lvalue type
}
