// [config]
// expect_result: fail
// glsl_version: 1.10
// glsles_version: 1.00
//
// [end config]

/* FAIL - cannot construct samplers */
void main()
{
  int i;

  i = sampler2D(0);
}
