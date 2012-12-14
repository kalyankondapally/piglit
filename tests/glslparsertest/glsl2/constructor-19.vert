// [config]
// expect_result: pass
// glsl_version: 1.20
// glsles_version: 1.00
//
// [end config]

/* PASS */
#ifndef GL_ES
#version 120
#endif

void main()
{
  struct s { int i; };

  s temp[2] = s[](s(1), s(2));
}
