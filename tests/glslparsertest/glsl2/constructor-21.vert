// [config]
// expect_result: pass
// glsl_version: 1.20
// glsles_version: 1.00
//
// [end config]
#ifndef GL_ES
#version 120
#endif

void main()
{
   const mat2 m2 = mat2(2.00, 2.01, 2.10, 2.11);
   const mat4 m4 = mat4(m2);
   gl_Position = m4[0];
}
