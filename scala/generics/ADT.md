# ADTs (Algebraic Data Types)

## What are ADTs? 

ADTs are a functional programming concept of representing data using "and" (products) and "or" (co-products a/k/a categorical
sums, e.g., disjoint unions). For example, a `tuple` is a "product" ADT.

```
(int, string)
```

A tuple must contain both types `int` and `string`. Similarly, `case class` is also a "product" ADT. 

```
case class Person(name: String,
                  age: Int)
```

In order to be created, a `Person` must have `name` and `age` attributes.

On the other hand, a "co-product" AST defines an "or" data type. For example, `Option` is a "co-product" AST, the value can either
be `Some()` value or `None`.

Another common use case is "encoding" sum types (ADTs) using inheritence, for example:

```
trait A

case class B(attr1: String) extends A

case class C(attr2: String) extends A

val newB: A = B("anything")
```

Here, the trait `A` is a "co-product" of both `B` and `C.

## Exhausitiveness in co-products

> A category is exhaustive if it has colimits of (transfinite) sequences of monomorphisms which 
interact well with pullbacks.

What does that mean? 

What it means is that if you decompose a sum type (co-product type), an "exhaustive" category will map each
component that comprises the sum type. For example, using the above trait `A`, 

```
newB match {
  case B => "found object of type B"
}
```

This will produce a non-exhaustive map because type `C` is unmatched.


