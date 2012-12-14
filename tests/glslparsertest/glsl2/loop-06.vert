// [config]
// expect_result: pass
// glsl_version: 1.10
// glsles_version: 1.00
//
// [end config]

/* PASS - the while loop has a single statement: the if block. */
uniform bool condition;
void main()
{
    while (condition)
        if (condition)
            continue;
}
