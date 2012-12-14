// [config]
// expect_result: fail
// glsl_version: 1.10
// glsles_version: 1.00
//
// [end config]

uniform sampler1D s;
void main()
{
    int i = int(s); // conversion not allowed
}
