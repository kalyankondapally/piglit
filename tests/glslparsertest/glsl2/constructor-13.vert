// [config]
// expect_result: pass
// glsl_version: 1.10
// glsles_version: 1.00
//
// [end config]

#ifndef GL_ES
#version 120
#endif

void main()
{
   const mat3x2 m = mat3x2(ivec3(1,2,3),ivec3(4,5,6));
}
