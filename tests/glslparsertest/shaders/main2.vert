// [config]
// expect_result: fail
// glsl_version: 1.10
// glsles_version: 1.00
//
// [end config]

void main(int i)  // main function cannot take any parameters
{
    gl_Position = vec4(1);
}
