// [config]
// expect_result: fail
// glsl_version: 1.10
// glsles_version: 1.00
//
// [end config]

/* FAIL - cannot construct a matrix from a matrix in GLSL 1.10 */

uniform mat2 a;

void main()
{
  mat2 b;

  b = mat2(a);

  gl_Position = gl_Vertex;
}
