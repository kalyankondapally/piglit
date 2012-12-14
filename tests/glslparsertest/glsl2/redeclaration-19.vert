// [config]
// expect_result: fail
// glsl_version: 1.10
// glsles_version: 1.00
//
// [end config]

/* FAIL - variable hides type name */

uniform bool condition;
void main() {
   struct id {
      int n;
   };
   if (condition) {
      float id = 1.0;
      id str;
   }
}
