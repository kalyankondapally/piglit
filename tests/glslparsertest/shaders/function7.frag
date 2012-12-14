// [config]
// expect_result: fail
// glsl_version: 1.10
// glsles_version: 1.00
//
// [end config]

void function(uniform int i)  
{  // uniform qualifier cannot be used with function parameters
}

void main()
{
    int i;
    function(i);  
}


