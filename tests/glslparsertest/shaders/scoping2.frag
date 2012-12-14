// [config]
// expect_result: fail
// glsl_version: 1.10
// glsles_version: 1.00
//
// [end config]

void main()
{
    {
        int i = 1;
        i++;
    }
    i++;  // i is not declared in this scope
}
