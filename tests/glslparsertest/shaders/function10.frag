// [config]
// expect_result: fail
// glsl_version: 1.10
// glsles_version: 1.00
//
// [end config]

void function(in int i);  

void main()
{
    float f;
    // overloaded function not present
    function(f);  
}

void function(in int i)  
{  
   i = 3;
}
