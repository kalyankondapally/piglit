// [config]
// expect_result: fail
// glsl_version: 1.10
// glsles_version: 1.00
//
// [end config]

void main()
{
    float f1,f2;
    bool b = f1 && f2;  // &&, || and ^^ operate on a boolean expression only
}
