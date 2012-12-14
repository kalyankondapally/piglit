// [config]
// expect_result: pass
// glsl_version: 1.10
// glsles_version: 1.00
//
// [end config]

/* PASS */
uniform mat2 m;

void main()
{
  ivec4 v4 = ivec4(m);
}
