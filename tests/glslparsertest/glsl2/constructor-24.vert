// [config]
// expect_result: pass
// glsl_version: 1.20
// glsles_version: 1.00
//
// [end config]

#ifndef GL_ES
#version 120
#else
#version 100
#endif

uniform mat3 m3;
varying mat2 m2;
void main()
{
   m2 = mat2(m3);
}
