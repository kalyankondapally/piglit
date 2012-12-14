// [config]
// expect_result: pass
// glsles_expect_result: false
// glsl_version: 1.10
// glsles_version: 1.00
//
// [end config]

/* PASS */

uniform ivec2 a;
uniform ivec2 b;

void main()
{
  mat2 c;

  c = mat2(a, b);

  gl_Position = gl_Vertex;
}
