# Scala style guide

0. Style is flexible but in any case, source code should be styled in a way that maximizes readability to the user.
Consistency in style ensures that the reader when traveling from one part of the codebase to another, 
is not forced to contend with disparate formatting. 

1. Where possible, line length of 120 characters should be enforced to prevent unnecessary scrolling.

2. Naming conventions. 
    * Variable naming. Variable naming follows the Scala standard library style guide. In any event, use of `_` 
    delimited names is frowned upon. However, _prefacing_ a variable with `_` to indicate its permission level is 
    acceptable. For example, `private val _clientName` is permissible, while `val client_name` is frowned upon.
    * Anonymous variables. Single use variables inside functions like `map` or `fold` can be abbreviated or 
    collapsed into a single letter if their usage is unambiguous. For example,
      ```
      val acc = as.map(a => SomeConstructor(a)) // fine
      val acc = as.map(SomeConstructor.apply) // preferable
      val acc = as.map((a, b) => SomeConstructor.apply(a, b))
      ```

3. Multi-line blocks of code for readability. In the following cases:
    * Collections
    * Case class/object creation
  
  For any set of arguments `n > 2`, split the line such that the constructor is on a different line from each argument,
  each argument is on its own line and each argument is indented from the constructor by 2-spaces. For example:
  
  ```
  val a = Seq("item-1", "item-2") // Here, n == 2, no need to use multiple lines.
  val b = 
    Seq(
      "item-1",
      "item-2",
      "item-3"
    )
  ```
