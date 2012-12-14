// [config]
// expect_result: pass
// glsl_version: 1.10
// glsles_version: 1.00
//
// [end config]

void main()
{
   const mat2 c1 = mat2(-0.5, 0.5, 0.5, -0.5);
   const mat2 c2 = 1.0 - c1;
   const mat2 c3 = c2 - 0.5;
}
