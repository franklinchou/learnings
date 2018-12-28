# Monads

Monads are data-types that have two functions:

1. `bind` or `map` which takes the value inside a monad, applies some
function and re-packs the result inside the monad; and
2. `return` or `lift` which takes any value and puts the value inside
a monad.

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

