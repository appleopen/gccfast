/* Contributed by Nicola Pero - Tue Mar  6 23:05:53 CET 2001 */
#include <objc/objc.h>
#include <objc/objc-api.h>

/* APPLE LOCAL objc test suite */      
#include "next_mapping.h"

/* Tests creating a root class and a subclass with a class methods */

@interface RootClass
{
  Class isa;
}
@end

@implementation RootClass
/* APPLE LOCAL begin objc test suite */
#ifdef __NEXT_RUNTIME__                                   
+ initialize { return self; }
#endif
/* APPLE LOCAL end objc test suite */
@end

static int class_variable = 0;

@interface SubClass : RootClass
+ (void) setState: (int)number;
+ (int) state;
@end

@implementation SubClass
+ (void) setState: (int)number
{
  class_variable = number;
}
+ (int) state
{
  return class_variable;
}
@end

#include "class-tests-1.h"
#define TYPE_OF_OBJECT_WITH_ACCESSOR_METHOD Class
#include "class-tests-2.h"

int main (void)
{
  Class class;

  test_class_with_superclass ("SubClass", "RootClass");
  test_that_class_has_class_method ("SubClass", @selector (setState:));
  test_that_class_has_class_method ("SubClass", @selector (state));

  class = objc_lookup_class ("SubClass");
  test_accessor_method (class, 0, -1, -1, 1, 1);

  return 0;
}
