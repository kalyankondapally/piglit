// [config]
// expect_result: fail
// glsl_version: 1.10
// glsles_version: 1.00
//
// [end config]

void main()
{
    float f[-2]; // cannot declare arrays with negative size
}
