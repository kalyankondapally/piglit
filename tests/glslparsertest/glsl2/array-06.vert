// [config]
// expect_result: pass
// glsles_expect_result: fail
// glsl_version: 1.10
// glsles_version: 1.00
//
// [end config]

/* PASS */
uniform vec4 a[3];

void main()
{
  gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;
}
