// [config]
// expect_result: fail
// glsl_version: 1.10
// glsles_version: 1.00
//
// [end config]

varying struct s {
    int i;
} s1;  // structures cannot be declared with varying qualifier

void main()
{
}
