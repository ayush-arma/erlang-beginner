-module(hhfuns).
-compile(export_all).

one() -> 1.
two() -> 2.

add(X,Y) -> X() + Y().


%hhfuns:add(fun hhfuns:one/0, fun hhfuns:two/0).

% higherorder function, we pass function as param in add.
