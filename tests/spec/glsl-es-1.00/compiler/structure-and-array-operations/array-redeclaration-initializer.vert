/* [config]
 * expect_result: pass
 * glsles_expect_result: fail
 * glsl_version: 1.20
 * glsles_version: 1.00
 * [end config]
 *
 * From page 19 (page 25 of the PDF) of the GLSL 1.20 spec:
 *
 *     "It is legal to declare an array without a size and then later
 *     re-declare the same name as an array of the same type and specify a
 *     size."
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


float a_function(float[3]);

void main()
{
  float [] an_array;

  an_array[0] = 0.0;
  an_array[1] = 1.0;
  an_array[2] = 2.0;

  float [] an_array = float[](2.0, 1.0, 0.0);

  gl_Position = vec4(a_function(an_array));
}
