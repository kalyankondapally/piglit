// [config]
// expect_result: fail
// glsl_version: 1.10
// glsles_version: 1.00
//
// [end config]

uniform struct s {
    int i;
} s1;

void main()
{
   s1.i = 1;  // uniforms are read only
}
