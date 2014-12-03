/* [config]
 * expect_result: pass
 * glsles_expect_result: fail
 * glsl_version: 1.20
 * glsles_version: 1.00
 * [end config]
 *
 * From page 20 (page 26 of the PDF) of the GLSL 1.20 spec:
 *
 *     "Arrays know the number of elements they contain. This can be obtained
 *     by using the length method:
 *
 *         a.length(); // returns 5 for the above declarations
 *
 *     The length method cannot be called on an array that has not been
 *     explicitly sized."
 *
 * length() function is not supported by GLSL-ES 1.0 and this test is expected
 * to fail. However, with GLSL-ES 3.0, this test should pass as length()
 * function is supported in this case.
 */


uniform vec4 a[2];

void main()
{
  gl_Position = vec4(a.length());
}
