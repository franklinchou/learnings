# Option (Scala's answer to `null`)

## Tiered lazy evaluation with option

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

Sometimes the value must be lifted in order to transform to Option.

You can also `flatten` to obtain only the values that are defined (`Some` values only).

```scala
val a = Some(5)
val b = None
Set(a, b).flatten  // returns Set(5)
```


## Options don't match

Pattern matching on `Option` is almost never necessary.
Treat `Option` as a collection and use collection functions, e.g., `map`,
`flatMap`, `filter`, &c. to decompose.

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


For more, see [here](http://blog.originate.com/blog/2014/06/15/idiomatic-scala-your-options-do-not-match/).
