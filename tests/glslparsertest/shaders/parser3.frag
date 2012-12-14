// [config]
// expect_result: fail
// glsl_version: 1.10
// glsles_version: 1.00
//
// [end config]

void main()
{
    float f[3];
    f[3] = 1.0; // index of array greater than the size of the array
}
