// [config]
// expect_result: fail
// glsl_version: 1.10
// glsles_version: 1.00
//
// [end config]

#extension foo : //  behavior not specified

void main()
{
}
