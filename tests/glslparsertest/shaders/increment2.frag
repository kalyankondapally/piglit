// [config]
// expect_result: fail
// glsl_version: 1.10
// glsles_version: 1.00
//
// [end config]

void main()
{
    int i;
    (i+i)++;  // i+i is not an l-value
}
