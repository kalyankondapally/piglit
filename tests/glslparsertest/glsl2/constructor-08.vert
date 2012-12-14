// [config]
// expect_result: pass
// glsles_expect_result: fail
// glsl_version: 1.10
// glsles_version: 1.00
//
// [end config]

/* PASS */

uniform float a;
uniform float b;

void main()
{
  ivec2 c;

  c = ivec2(a, b);

  gl_Position = gl_Vertex;
}
