/* [config]
 * expect_result: pass
 * glsles_expect_result: fail
 * glsl_version: 1.20
 * glsles_version: 1.00
 * [end config]
 *
 * From page 20 (page 26 of the PDF) of the GLSL 1.20 spec:
 *
 *     "Arrays can have initializers formed from array constructors:"
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


vec4 a[2] = vec4[2](vec4(0.0), vec4(2.0));
vec4 b[2] = vec4[ ](vec4(0.5), vec4(2.0));
vec4 c[ ] = vec4[ ](vec4(1.0), vec4(2.0));

void main() { gl_Position = a[0] + b[0] + c[0]; }
