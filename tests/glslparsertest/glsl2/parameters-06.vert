// [config]
// expect_result: fail
// glsl_version: 1.10
// glsles_version: 1.00
//
// [end config]

/* FAIL - cannot mix void and non-void parameters
 */
float a(float, void);

void main()
{
  gl_Position = gl_Vertex;
}
