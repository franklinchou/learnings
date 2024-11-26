# Closures

def outer(msg):

    # Message is said to be "free"; it is neither a parameter
    # nor a local variable.
    message = msg

    def inner():
        print(message)

    # Return a reference to the function without actually
    # evaluating it.
    return inner


if __name__ == '__main__':

    # Here, f is simply storing a reference to the `inner` function.
    f = outer("test")

    # However, despite, completing the execution of outer,
    # if `f` is called, `inner` is executed and the message is still
    # printed. `inner` is said to "remember" the state of a variable
    # in the local scope in which `inner` was created.
    f()
