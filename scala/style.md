# Scala style guide

Style is flexible but in any case, source code should be styled in a way that maximizes readability to the user.
Consistency in style ensures that the reader when traveling from one part of the codebase to another, 
is not forced to contend with disparate formatting. 

## Line Breaks

1. Where possible, line length of 120 characters should be enforced to prevent unnecessary scrolling.

2. A comma (`,`) stays attached to the token that precedes it.

3. Multi-line blocks of code for readability. In the following cases:
    * Collections
    * Case class/object creation
  
    For any set of arguments `n > 2`, split the line such that the constructor is on a different line from each argument,
    each argument is on its own line and each argument is indented from the constructor by 2-spaces. For example:
    ```scala
    val a = Seq("item-1", "item-2") // Here, n == 2, no need to use multiple lines.
    val b = 
      Seq(
        "item-1",
        "item-2",
        "item-3"
      )
    ```
    
4. Continuations for method definitions:

    ```scala
    // Preferred for easy scanning and extra column space
    case class Example(param1: String, param2: String) 
    
    // Also acceptable. Should follow from application of line break rules (1) and (2)
    case class Example(param1: String,
                       param2: String) 
    
    // Sub-optimal. Wastes space on both first and last line of method definition
    case class Example(
                       param1: String,
                       param2: String
                      ) 
    ```

5. Line breaks on `if` statements:

    ```scala
    // Preferred style where the body of execution is one line
    if (condition) execution
    else execution2
    
    // Preferred style where any body is over one line:
    if (condition) {
      execution, line1
      execution, line2
    } else {
      execution2, line1 // Notice that although the logic in the else block is only 1 line
                        // it is still surrounded by curly-braces for readability and to maintain
                        // in-line style with the beginning if statement
    }
    ```


## Naming conventions

1. Variable naming. Variable naming follows the Scala standard library style guide. In any event, use of `_` 
delimited names is frowned upon. However, _prefacing_ a variable with `_` to indicate its permission level is 
acceptable. For example, `private val _clientName` is permissible, while `val client_name` is frowned upon.
2. Anonymous variables. Single use variables inside functions like `map` or `fold` can be abbreviated or 
    collapsed into a single letter if their usage is unambiguous. For example,
      ```scala
      val acc = as.map(a => SomeConstructor(a)) // fine
      val acc = as.map(SomeConstructor.apply) // preferable
      val acc = as.map((a, b) => SomeConstructor.apply(a, b))
      ```
