// [config]
// expect_result: fail
// glsl_version: 1.10
// glsles_version: 1.00
//
// [end config]

void main()
{
    gl_FragCoord = vec4(1.0);  // can be used in fragment shader only
}
