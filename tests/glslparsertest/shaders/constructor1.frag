// [config]
// expect_result: fail
// glsl_version: 1.10
// glsles_version: 1.00
//
// [end config]

void main()
{
    vec4 v = vec4(1,2,3); // insufficient data provided for constructor, 4 values are required
}
