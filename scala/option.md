# Option

Option is a container for zero or one element of a given type. 
An `Option[T]` can be either `Some[T]` or `None` (`None` extends `Option[Nothing]`). 

## Tiered lazy evaluation with `Option`

Would like to set value to `b` but only if `a` is defined.

```scala
for {
  a <- None
  b <- Some(9)
} yield y // returns None
```

```scala
for {
  a <- Some("defined")
  b <- Some(9)
} yield y // returns Some(9)
```

You can also `flatten` to obtain only the values that are defined (`Some` values only).

```scala
val a = Some(5)
val b = None
Set(a, b).flatten  // returns Set(5)
```


## Removing pattern matching on `Option`

Pattern matching on `Option` is almost never necessary. See the signature of `map` on the `Option` monad.

This:

```scala
opt match {
  case Some(a) => foo(a)
  case None => bar
}
``` 

can be decomposed to:

```scala
opt.map(foo).getOrElse(bar)

// or

opt.fold(bar)(foo)
```


For more, see [Your Options Don't Match](http://blog.originate.com/blog/2014/06/15/idiomatic-scala-your-options-do-not-match/).
