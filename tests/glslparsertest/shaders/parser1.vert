// [config]
// expect_result: fail
// glsl_version: 1.10
// glsles_version: 1.00
//
// [end config]

void main()
{
    int a  // semicolon missing at the end of the statement
    gl_Position = vec4(a);  
}
