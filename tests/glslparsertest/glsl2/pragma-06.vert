// [config]
// expect_result: fail
// glsl_version: 1.10
// glsles_version: 1.00
//
// [end config]

/* FAIL
 *
 * From page 11 (page 17 of the PDF) of the GLSL 1.10 spec:
 *
 *     "[#pragma optimize] can only be used outside function definitions."
 */
void main()
{
#pragma optimize(on)
  gl_Position = gl_Vertex;
}
