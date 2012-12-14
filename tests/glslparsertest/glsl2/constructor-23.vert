// [config]
// expect_result: pass
// glsl_version: 1.20
// glsles_version: 1.00
//
// [end config]
#ifndef GL_ES
#version 120
#endif

uniform mat2 m2;
varying mat4 m4;
void main()
{
   m4 = mat4(m2);
}
