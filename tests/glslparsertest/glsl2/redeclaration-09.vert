// [config]
// expect_result: pass
// glsles_expect_result: fail
// glsl_version: 1.10
// glsles_version: 1.00
//
// [end config]

/* PASS - variables and functions have separate namespaces in 1.10.
 *
 * See also redeclaration-02.vert (other order) and redeclaration-10.vert
 * (this fails in 1.20 due to shared namespaces).
 */
float foo()
{
    return 0.5;
}

const float foo = 1.0;

void main()
{
    gl_Position = vec4(foo - foo());
}
