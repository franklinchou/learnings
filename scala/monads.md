# Monads

What is a monad?

Simply put: **A monad is simply a data type that can apply a function to a wrapped value and return a wrapped value.** Think `List`, `map` applies a function, `f` that also returns a `List`! That's it!

Monads are data-types that have two functions:

1. `bind` or `map`, which has a signature, `map[M[_], A, B](a: M[A])(f: A => M[B]): M[B]`, 
which takes the value inside a monad, applies some function and re-packs the result inside the monad; and
2. `return` or `lift`, which has a signature, `lift[M[_], A](a: A): M[A]`, 
which takes any value and puts the value inside a monad.

NOTE: Using monads to enforce control flow. There is an ordering of operations on `map`
and repeated operations of `map` create a control structure. One use of monads is to "glue" together
pure functions with special purpose control flow.

## Covariance, invariance and contravariance

Consider a monad, `Q[_]` and generic parameters `A <: B` (`A` is a child of
`B`).

1. Covariance. A monad would be "covariant in the parameter T" (`Q[+T]`) if
`B => Q[B]` and `A => Q[A]` with `Q[A] <: Q[B]`. In other words, if `A` is a
subtype of `B`, then `Q[A]` will be a subtype of `Q[B]`. In this case, the "arrows"
(the direction of applicability) flows from the parent "downward" to
the child (as expected with traditional inheritence).

2. Invariance. A monad is invariant (`Q[T]`) if `Q[A]` has no relationship
to `Q[B]`.

3. Contravariance. A monad is "contravariant in the parameter T") (`Q[-T]`)
if `Q[B] <: Q[A]`. In other words, `A` is a child of `B` but `Q[A]` is a
**parent** of `Q[B]`.

For example:

```
class GrandParent

class Parent extends GrandParent

class Child extends Parent

class CovariantBox[+A]

class ContravariantBox[-A]

class InvariantBox[A]

def f1(x: CovariantBox[Parent]): CovariantBox[Parent] = identity(x)

f1(new CovariantBox[Child])) // this works; covariant parameter accepts subtypes

f1(new CovariantBox[Grandparent])) // type error

def f2(x: ContravariantBox[Parent]): ContravariantBox[Parent] = identity(x)

f2(new ContravariantBox[Child]) // type error

f2(new ContravariantBox[GrandParent]) // this works, contravariant accepts supertypes

def f3(x: InvariantBox[Parent])

f3(new InvariantBox[Parent]) // only this will work

```

## Free monads

Interpreters are about separating the representation of a computation from 
the way it is run. Any interpreter has two parts: (1) an abstract syntax tree (AST)
that represents the computation (the language); and (2) a process that gives meaning
to the abstract syntax tree (the engine).

Consider the expression `1 + 2 + 3`. We can execute this directly, evaluating to `6`,
or we could represent it as an AST such as `Add(1, Add(2, 3))`.
Expressed this way, `Add` simply represents the definition of the operation, it is 
completely agnostic as to its parameters (and to some extent to the result's type).
This is the power of free monads. Concretely, this means a free monad provides:

1. an AST to express monadic operations;
2. an API to write interpreters that give meaning to this AST.

That’s the basics of the free monad: it’s something we can wrap around an arbitrary type constructor 
(an `F[_]`) to construct a monad. It allows us to separate the structure of the computation 
from its interpreter, thereby allowing different interpretation depending on context.
