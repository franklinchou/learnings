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
3. `join` or `flatMap` which has a signature, `flatMap[M[_], A, B](a: M[A])(f: A => M[B]): M[B]` which 
turns a container of containers into a single container.

NOTE: Using monads to enforce control flow. There is an ordering of operations on `map`
and repeated operations of `map` create a control structure. One use of monads is to "glue" together
pure functions with special purpose control flow.

## Free Monads

A monad is something that "computes" when monadic context is collapsed. For example, `flatMap` on a list of lists
"computes" a single list. This is how Monads carry context through a sequential chain of computations: at each point 
in the series, the context from the previous call is collapsed with the next.

A free monad satisfies all the Monad laws, but does not do any collapsing (i.e., computation). It just builds 
up a nested series of contexts. The user who creates such a free monadic value is responsible for doing something 
with those nested contexts, so that the meaning of such a composition can be deferred until after the monadic 
value has been created.
