// [config]
// expect_result: fail
// glsl_version: 1.20
// glsles_version: 1.00
//
// [end config]

/* FAIL - built-in exp hidden by variable */
#version 120
uniform float exp;

void main()
{
    gl_Position = vec4(exp(0.0));
}
