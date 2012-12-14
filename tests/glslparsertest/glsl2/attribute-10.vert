// [config]
// expect_result: fail
// glsl_version: 1.20
// glsles_version: 1.00
//
// [end config]

#version 120
/* FAIL - attribute cannot have array type in GLSL 1.20 */
attribute vec4 i[10];

void main()
{
  gl_Position = vec4(1.0);
}
