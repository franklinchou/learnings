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


