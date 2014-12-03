/* [config]
 * expect_result: pass
 * glsles_expect_result: fail
 * glsl_version: 1.20
 * glsles_version: 1.00
 * [end config]
 *
 * From page 35 (page 41 of the PDF) of the GLSL 1.20 spec:
 *
 *     "The equality operators and assignment operator are only allowed if the
 *     two operands are same size and type....Both array operands must be
 *     explicitly sized. When using the equality operators ... two arrays are
 *     equal if and only if all the elements are element-wise equal.
 *
 * According to GLSL-ES 1.0 spec paragraph 5.2 Array Subscripting(page 41 of the PDF):
 *
 *     "Array elements are accessed using the array subscript operator ( [ ] ).
 *      This is the only operator that operates on arrays."
 *
 * According to GLSL-ES 3.0 spec paragraph 5.7 Structure and Array Operations
 * (page 41 of the PDF):
 *
 *     "The fields of a structure and the length method of an array are selected
 *      using the period ( . ). In total, only the following operators are
 *      allowed to operate on arrays and structures as whole entities:

 *      field or method selector .
 *      equality                 == !=
 *      assignment               =
 *      indexing (arrays only)   [ ]"
 */


uniform vec4 a[2];
uniform vec4 b[2];

void main()
{
  gl_Position = vec4(a == b);
}
