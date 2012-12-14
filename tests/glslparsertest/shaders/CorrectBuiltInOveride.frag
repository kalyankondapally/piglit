// [config]
// expect_result: pass
// glsl_version: 1.10
// glsles_version: 1.00
//
// [end config]

float radians(float f)
{
    return f; 
}

void main()
{
    float f = 45.0;
    f = radians(f);
}
