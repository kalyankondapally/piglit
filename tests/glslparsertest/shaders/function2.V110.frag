// [config]
// expect_result: fail
// glsl_version: 1.10
// glsles_version: 1.00
//
// [end config]

void function(int i[])  // size of array must be specified
{
}

void main()
{
    int i[2];
    function(i);
}


