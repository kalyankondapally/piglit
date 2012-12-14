// [config]
// expect_result: fail
// glsl_version: 1.10
// glsles_version: 1.00
//
// [end config]

void function(const inout int i)  
{  // inout parameters cannot be const
   i = 3;
}

void main()
{
    int i;
    function(i);  
}


