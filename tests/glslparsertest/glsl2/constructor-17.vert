// [config]
// expect_result: pass
// glsl_version: 1.10
// glsles_version: 1.00
//
// [end config]

/* PASS */

void main()
{
  struct s { int i; };

  s temp = s(1);
}
