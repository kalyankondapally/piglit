/* [config]
 * expect_result: pass
 * glsles_expect_result: fail
 * glsl_version: 1.20
 * glsles_version: 1.00
 * [end config]
 *
 * From page 19 (page 25 of the PDF) of the GLSL 1.20 spec:
 *
 *     "When an array size is specified in a declaration, it must be an
 *     integral constant expression (see Section 4.3.3 "Constant Expressions")
 *     greater than zero."
 *
 * length() function is not supported by GLSL-ES 1.0 and this test is expected
 * to fail. However, with GLSL-ES 3.0, this test should pass as length()
 * function is supported in this case.
 *
 * From Section 4.19 Arrays in GLSL-ES 1.0 Spec (Page 24 of the PDF):
 *
 *     "The array size must be an integral constant expression"
 *
 * From Section 4.19 Arrays in GLSL-ES 3.0 Spec (Page 28 of the PDF):
 *
 *     "The array size must be a constant integral expression"
 */


uniform vec4 [3] a;
uniform vec4 [a.length()] b;

void main() { gl_Position = vec4(0.0); }
