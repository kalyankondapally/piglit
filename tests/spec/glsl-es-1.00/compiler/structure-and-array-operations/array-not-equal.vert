/* [config]
 * expect_result: pass
 * glsl_version: 1.20
 * glsles_expect_result: fail
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
 * From page 48 (page 54 of the PDF) of GLSL ES 1.00 Revision 17 (12 May, 2009):
 *
 *     "The equality operators equal (==), and not equal (!=) operate on all
 *     types except arrays, structures containing arrays, sampler types and
 *     structures containing sampler types They [sic] result in a scalar Boolean.
 *     For vectors, matrices, and structures, all components of the operands
 *     must be equal for the operands to be considered equal. To get
 *     component-wise equality results for vectors, use the built-in functions
 *     equal and notEqual. *
\ */


uniform vec4 a[2];
uniform vec4 b[2];

void main()
{
  gl_Position = vec4(a != b);
}
