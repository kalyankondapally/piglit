// [config]
// expect_result: fail
// glsl_version: 1.10
// glsles_version: 1.00
//
// [end config]

/* FAIL - invalid return type for function 'foo'
 *
 * This test reproduces bugzilla #29608.
 */

foo bar(void);

void main()
{
  gl_Position = vec4(0.0);
}
