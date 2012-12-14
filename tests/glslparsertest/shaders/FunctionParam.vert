// [config]
// expect_result: fail
// glsl_version: 1.10
// glsles_version: 1.00
//
// [end config]

int y = 1;

int foo(int, int b[y])  // array size should be constant
{
    return 1;
}

void main()
{
    int a[1];

    gl_Position = vec4(1.0);
}
