// [config]
// expect_result: fail
// glsl_version: 1.10
// glsles_version: 1.00
//
// [end config]

void function(const int i)  
{
    i = 3;  // const value cant be modified
}

void main()
{
    int i;
    function(i);
}


