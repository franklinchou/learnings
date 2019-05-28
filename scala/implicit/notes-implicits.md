# Notes on implicits

## "Demystifying Implicits and Typeclasses in Scala" by Sohum Banerjea

Notes and excerpts from the article ["Demystifying Implicits and Typeclasses in Scala"](http://web.archive.org/web/20171001150154/http://www.cakesolutions.net:80/teamblogs/demystifying-implicits-and-typeclasses-in-scala) by Sohum Banerjea which is
referenced by nearly every resource about implicits and typeclass pattern but has since moved from its original
location on the CakeSolutions page.

**What are implicits?**

When Scala sees a call to a method with implicit parameters, and the implicit arguments 
aren't specified, it checks if there are implicit arguments of the right type within scope.

**Typeclasses**

The idea of typeclasses is that you provide evidence that a class satisfies an interface.
For example:

```scala
trait CanFoo[A] { 
  def foos(x: A): String
}

case class Wrapper(wrapped: String)

object WrapperCanFoo extends CanFoo[Wrapper] { 
  def foos(x: Wrapper) = x.wrapped
}
```

Here, we have provided _evidence_ (`WrapperCanFoo`) that a class (`Wrapper`) satifies an interface (`CanFoo`).
Instead of having the class (here, `Wrapper`) implement the interface directly, typeclasses allow us to split
up the definition of the class and the implementation of the interface. Allows third parties to implement
interface for the class without ugly sub-typing.

To add the implicits layer, we can add an implicit object as _evidence_.

```scala
trait CanFoo[A] { 
  def foos(x: A): String
}

case class Wrapper(wrapped: String)

// Added "implicit"
// The evidence object is the only thing in scope of type CanFoo[Wrapper] and
// it gets passed as an implicit evidence argument.
implicit object WrapperCanFoo extends CanFoo[Wrapper] {
  def foos(x: Wrapper) = x.wrapped
}

def foo[A](thing: A)(implicit evidence: CanFoo[A]) = evidence.foos(thing)
// This syntactic sugar also works:
// def foo[A: CanFoo](thing: A) = implicitly[CanFoo[A]].foos(thing)

foo(Wrapper("hi")) // output is "hi" (String)
foo[Wrapper](Wrapper("hi")) // this is more explicit
```

Here's some more syntactic sugar:

```scala
trait CanFoo[A] { 
  def foos(x: A): String
}

object CanFoo {
  def apply[A:CanFoo]: CanFoo[A] = implicitly
}

case class Wrapper(wrapped: String)

implicit object WrapperCanFoo extends CanFoo[Wrapper] {
  def foos(x: Wrapper) = x.wrapped
}

// foo calls CanFoo.apply to retrieve the evidence argument
// the implicit object is in scope and is implicitly passed into the CanFoo.apply function 
def foo[A: CanFoo](thing: A) = CanFoo[A].foos(thing)

foo[Wrapper](Wrapper("hi")) // produces "hi" (String)
foo(Wrapper("hi")) // this also works
```
