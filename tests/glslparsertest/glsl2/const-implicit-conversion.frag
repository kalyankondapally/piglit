// [config]
// expect_result: pass
// glsles_expect_result: fail
// glsl_version: 1.20
// glsles_version: 1.00
//
// [end config]

#version 120
void main()
{
   const float length = 5;
   const bool no = length == 2;
}
