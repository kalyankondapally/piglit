// [config]
// expect_result: fail
// glsl_version: 1.10
// glsles_version: 1.00
//
// [end config]

/* FAIL - attribute cannot have type ivec3 */
attribute ivec3 i;

void main()
{
  gl_Position = vec4(1.0);
}
