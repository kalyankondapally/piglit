// [config]
// expect_result: fail
// glsl_version: 1.10
// glsles_version: 1.00
//
// [end config]

void main()
{
    vec2 v;
    v.xx = vec2(1,1);  // x cannot be used twice in l-value
}
