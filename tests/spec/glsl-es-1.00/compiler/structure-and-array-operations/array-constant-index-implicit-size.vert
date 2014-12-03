/* [config]
 * expect_result: pass
 * glsles_expect_result: fail
 * glsl_version: 1.20
 * glsles_version: 1.00
 * [end config]
 *
 * From page 19 (page 25 of the PDF) of the GLSL 1.20 spec:
 *
 *     "If an array is indexed with an expression that is not an integral
 *     constant expression, or if an array is passed as an argument to a
 *     function, then its size must be declared before any such use."
 *
 * From Section 4.19 Arrays in GLSL-ES 1.0 Spec (Page 24 of the PDF):
 *
 *     "Arrays declared as formal parameters in a function declaration must
 *      specify a size."
 *
 * From GLSL-ES 3.0 Spec (Page 29 of the PDF):
 *
 *     "An array declaration which leaves the size unspecified is an error"
 */


/* Assume the array is sized in a different compilation unit.
 */
vec4 [] an_array;

void main()
{
  gl_Position = an_array[2];
}
