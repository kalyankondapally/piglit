/* [config]
 * expect_result: pass
 * glsles_expect_result: fail
 * glsl_version: 1.20
 * glsles_version: 1.00
 * [end config]
 *
 * From page 35 (page 41 of the PDF) of the GLSL 1.20 spec:
 *
 *     "In total, only the following operators are allowed to operate on
 *     arrays and structures as whole entities:
 *
 *     field or method selector .
 *     equality                 == !=
 *     assignment               =
 *     indexing (arrays only)   []"
 *
 * Section 5.2 Array Subscripting (page 41 of the PDF) of the GLSL-ES 1.00 spec:
 *
 *     "Array elements are accessed using the array subscript operator ( [ ] ).
 *      This is the only operator that operates on arrays."
 */


void main()
{
  vec4 a[2];
  vec4 b[2];
  vec4 c[2];

  a = vec4[2](vec4(0.0), vec4(2.0));
  b = vec4[ ](vec4(0.5), vec4(2.0));
  c = a;

  gl_Position = a[0] + b[0] + c[1];
}
