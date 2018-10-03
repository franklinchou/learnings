# Option (Scala's answer to `null`)

## Tiered lazy evaluation with option

Would like to set value to b but only if a is defined.

```scala
for {
  x <- None
  y <- Some(9)
} yield y // returns None
```

```scala
for {
  x <- Some("defined")
  y <- Some(9)
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

http://blog.originate.com/blog/2014/06/15/idiomatic-scala-your-options-do-not-match/
