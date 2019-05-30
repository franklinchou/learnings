# Monads

## The basics

**What is a functor?**

A functor provides:

- the data type (for an `Option` that's `Option[_]`)
- `map` which takes the value inside the functor, applies some function and repacks the result inside the functor, e.g., 
`map[F[_], A, B](fa: F[A])(f: A => B): F[B]`

Note especially: 

- the absence of `lift` or `apply` (strictly speaking, `lift` or `apply` is provided by an applicative)
- the type of the function used in `map`

**What is a monad?**

A monad has all the properties of a functor but also includes the `flatMap` function (more generally it is a functor that has a
`map` function which is "aware of inner contexts"). 

To summarize, monads are data-types that have the following three functions:

1. `return` or `lift`, which has a signature, `lift[M[_], A](a: A): M[A]`, 
which takes any value and puts the value inside a monad; and
2. `bind` or `map`, which has a signature, `map[M[_], A, B](a: M[A])(f: A => B): M[B]`, 
which takes the value inside a monad, applies some function (that maps an unlifted type to another unlifted type)
and re-packs the result inside the monad; and
3. `flatMap`, which has a signature, `flatMap[M[_], A, B](a: M[A])(f: A => M[B]): M[B]`,
which takes the value inside a monad and applies a function that is "context aware", i.e., the "packing" is done
by the function.

NOTE: Using monads to enforce control flow. There is an ordering of operations on `map`
and repeated operations of `map` create a control structure. One use of monads is to "glue" together
pure functions with special purpose control flow.
