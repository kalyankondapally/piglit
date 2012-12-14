// [config]
// expect_result: fail
// glsl_version: 1.10
// glsles_version: 1.00
//
// [end config]

void main()
{
    ivec4 v4;
    v4 = v4 + 2.0;
}
