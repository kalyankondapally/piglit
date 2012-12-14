// [config]
// expect_result: fail
// glsl_version: 1.10
// glsles_version: 1.00
//
// [end config]

void main() 
{
    int i, j, k;
    float f;
    i = j, k, f;
    i = (j = k, f = 1.0);   // float cannot be assigned to int
    gl_Position = vec4(1);
}
