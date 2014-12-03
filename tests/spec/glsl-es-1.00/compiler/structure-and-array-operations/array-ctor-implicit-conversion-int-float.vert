/* [config]
 * expect_result: pass
 * glsles_expect_result: fail
 * glsl_version: 1.20
 * glsles_version: 1.00
 * [end config]
 *
 * From page 20 (page 26 of the PDF) of the GLSL 1.20 spec:
 *
 *     "In some situations, an expression and its type will be implicitly
 *     converted to a different type. The following table shows all allowed
 *     implicit conversions:
 *
 *     Type of expression   Can be implicitly converted to
 *     int                  float
 *     ivec2                vec2
 *     ivec3                vec3
 *     ivec4                vec4
 *
 *     There are no implicit array or structure conversions. For example, an
 *     array of int cannot be implicitly converted to an array of float.  When
 *     an implicit conversion is done, it is not just a re-interpretation of
 *     the expression's value, but a conversion of that value to an equivalent
 *     value in the new type. For example, the integer value 5 will be
 *     converted to the floating-point value 5.0.  The conversions in the
 *     table above are done only as indicated by other sections of this
 *     specification."
 *
 * According to GLSL-ES 1.0 spec paragraph 4.1.9 Arrays(page 24 of the PDF):
 *
 *     "There is no mechanism for initializing arrays at declaration time
 *      from within a shader."
 *
 * According to GLSL-ES 3.0 spec paragraph 4.1.9 Arrays(page 28 of the PDF):
 *
 *     "An array type can also be formed without specifying a size if the
 *      definition includes an initializer"
 */


uniform int a[2];

void main()
{
  float b[2] = float[](a[0], a[1]);

  gl_Position = vec4(b[0]);
}
