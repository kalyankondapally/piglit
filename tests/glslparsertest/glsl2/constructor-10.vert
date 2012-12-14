// [config]
// expect_result: fail
// glsl_version: 1.10
// glsles_version: 1.00
//
// [end config]

/* FAIL - not enough data provided for construction */

vec4 foo()
{
  return vec4();
}

void main()
{
  gl_Position = foo();
}
