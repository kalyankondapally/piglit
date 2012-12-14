// [config]
// expect_result: fail
// glsl_version: 1.10
// glsles_version: 1.00
//
// [end config]

int function(out int i)  
{  // function should return a value
}

void main()
{
    int i;
    function(i);  
}


