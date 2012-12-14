// [config]
// expect_result: pass
// glsl_version: 1.10
// glsles_version: 1.00
//
// [end config]

/* PASS
 *
 * In a function prototype it is valid to have some parameters named
 * and some parameters not named.
 */

void bar(int x, float);

void main()
{
  gl_Position = vec4(0.0);
}
