# Shapeless

## What can Shapeless do? 

Given a model:

```
BaseModel(id: String,
          attr1: Option[String] = None,
          attr2: Option[Int] = None,
          attr3: Seq[String] = Seq.empty[String])
```

And a Child Model that inherits from that base model:


```
ChildModel(id: String,
           attr1: Option[String]
           attr2: Option[Int])
```

I can coerce a `ChildModel` into a `BaseModel`.
