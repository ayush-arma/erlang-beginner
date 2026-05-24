🔹 1. Functions are values
You can store them in variables
You can pass them to other functions
🔹 2. Closures "remember" variables
Secret = "pony" is NOT lost
The function carries it with itself
🔹 3. Functions can return functions
a/0 returns a function
make_adder/1 returns a customized function
🔹 4. This enables reusable behavior

Instead of writing many functions like:

add2
add5
add10


a closure is essentially an anonymous function (often called a fun) that "carries" its environment with it.