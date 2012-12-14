// [config]
// expect_result: fail
// glsl_version: 1.10
// glsles_version: 1.00
//
// [end config]

struct s {
    const int i = 1;  // structure members cannot be declared with const qualifier
} s1;

void main()
{
}
