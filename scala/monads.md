# Monads

What is a monad?

Simply put: **A monad is a data type that can apply a function to a wrapped value and return a wrapped value.** Think `List`, `map` applies a function, `f` that also returns a `List`! That's it!

Monads are data-types that have two functions:

1. `bind` or `map`, which has a signature, `map[M[_], A, B](a: M[A])(f: A => M[B]): M[B]`, 
which takes the value inside a monad, applies some function and re-packs the result inside the monad; and
2. `return` or `lift`, which has a signature, `lift[M[_], A](a: A): M[A]`, 
which takes any value and puts the value inside a monad.

NOTE: Using monads to enforce control flow. There is an ordering of operations on `map`
and repeated operations of `map` create a control structure. One use of monads is to "glue" together
pure functions with special purpose control flow.
