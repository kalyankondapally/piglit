// [config]
// expect_result: fail
// glsl_version: 1.10
// glsles_version: 1.00
//
// [end config]

struct s {
    uniform int i;  // structure members cannot be declared with const qualifier
} s1;

void main()
{
}
