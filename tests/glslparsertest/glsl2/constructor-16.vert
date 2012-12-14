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

uniform vec2 u1;

void main()
{
  mat4x3 m = mat4x3(vec3(1.0,u1),
		    vec3(0.0,1.0,0.0),
		    vec3(0.0,0.0,1.0),
		    vec3(0.0,0.0,0.0));
}
