// [config]
// expect_result: fail
// glsl_version: 1.10
// glsles_version: 1.00
//
// [end config]

uniform float f;
void main()
{
    f = 1.0;  // uniforms are read only
}
