// [config]
// expect_result: fail
// glsl_version: 1.10
// glsles_version: 1.00
//
// [end config]

struct s {
    int i;
} uniform uniformStruct;  // uniform keyword should be used before the keyword struct

void main()
{
}
