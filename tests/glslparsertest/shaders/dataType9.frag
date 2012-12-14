// [config]
// expect_result: fail
// glsl_version: 1.10
// glsles_version: 1.00
//
// [end config]

varying float f;
void main()
{
    float flt = 1.0;
    flt++;
    f++;  // varyings in a fragment shader are read only
}
