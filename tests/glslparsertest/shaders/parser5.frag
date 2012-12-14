// [config]
// expect_result: fail
// glsl_version: 1.10
// glsles_version: 1.00
//
// [end config]

void main()
{
    vec2 v;
    v.z = 1.2;   // vec2 does not have a z component
}
