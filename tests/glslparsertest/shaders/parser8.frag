// [config]
// expect_result: fail
// glsl_version: 1.10
// glsles_version: 1.00
//
// [end config]

void main()
{
    vec2 v2;
    vec3 v3;
    bool b = v2 == v3; // equal operator cannot operator on vectors of different sizes
}
