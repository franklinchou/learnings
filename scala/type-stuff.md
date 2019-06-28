# Type stuff

## Notes from un-meetup Jul 23 2018

Exploring scala's type system; predef.

1. Create a function that checks type `to => from`.

```
// Will compile if A & B are compatible subtypes
def f[A, B](implicit ev: A => B) { println("works") }
```

For example:

```
trait A
trait B
f[A, B] // fails: no implicit view available from A => B
```

However, defining A to inherit from B, we get:

```
trait B
trait A extends B
f[A, B] // this works
```

2. Using predef functions

Other class relationship behavior can be modeled using the predef functions: `=:=`, `>:>`, `<:<`.

For example:

```
trait A
trait B
def f[A, B](implicit ev: A =:= B){ println("works") }

f[A, B] // obviously fails

trait A extends B
f[A, B] // this will also fail 

type A = B
f[A, B] // this will compile
```


More examples using `<:<`

```
trait A
trait B
trait C extends A

def f[A, B](implicit ev: A <:< B){ println("works") }

f[A, B] // fails (cannot prove that A is a sub-type of B)

f[C, A] // this works
```

## Type classes

See [here](http://marco-lopes.com/articles/Abstracting-Over-Effect-Types/). 

Consider: `Option[A]`. Here, `Option` takes a type parameter `A`.
Providing a type parameter is known as late binding ad hoc polymorphism. Consider inheritence (early binding polymorphism or
polymorphism at delcaration-time). `class Cat extends Mammal` means that `Cat` **is** a `Mammal`. 
This is "early binding" because the relationship is defined at declaration time. 
The same construct might be defined as `Mammal[Cat]`, in which case `Mammal` **has** a type `Cat`. 
Here `Cat` has an instance of `Mammal`.

Going back to our example of `Option[A]`, the type parameter, `A`, is completely polymorphic, i.e., 
it can be replaced by any type, but that also means that there’s very little you can do with it. We can constrain the
type of `A` to a specific type class, i.e., `Option[A : SomeTypeClass]`. Now we know that `A` will support the 
functionality of `SomeTypeClass`.

Formally, a type class, `C`, defines some behaviour in the form of operations that must be supported by a type `T`
for it to be a member of type class `C`. Whether `T` is a member of `C` (`T <: C`, this is known as an upper type
bound, i.e., `T` is a subtype of `C`) is not inherent in the type. Rather any type can be a member of a type class
simply by providing implementations of the operations the type must support (much like interfaces). Now, 
once `T` is made a member of `C`, functions that have constrained one or more of their parameters to be members
of `C` can be called with arguments of type `T`.

See defining a type class, [here](https://danielwestheide.com/blog/2013/02/06/the-neophytes-guide-to-scala-part-12-type-classes.html).
