/* [config]
 * expect_result: pass
 * glsles_expect_result: pass
 * glsles_version: 1.00
 * [end config]
 *
 * From Section 4.19 Arrays in GLSL-ES 1.0 Spec (Page 24 of the PDF):
 *
 *     "All basic types and structures can be formed into arrays."
 *
 * Note that length() function is not supported with GLSL-ES 1.00
 */

#define ARRAY_SIZE 2
struct s {
  float x;
  int y;
};

void main()
{
  s a[ARRAY_SIZE];
  gl_Position = vec4(ARRAY_SIZE);
}
