// [config]
// expect_result: pass
// glsl_version: 1.20
// glsles_version: 1.00
//
// [end config]

/* PASS */
#ifndef GL_ES
#version 120
#else
#version 100
#endif

struct s { float f; };

void main()
{
    s t = s(1); // an implicit conversion should happen here
}
