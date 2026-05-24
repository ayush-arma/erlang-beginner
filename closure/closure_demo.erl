-module(closure_demo).
-export([a/0, b/1, make_adder/1]).

%% a/0 returns a closure (function that remembers Secret)
a() ->
    Secret = "pony",
    fun() -> Secret end.

%% b/1 takes a function and calls it
b(F) ->
    "a/0's password is " ++ F().

%% extra example: function that returns a function (closure)
make_adder(N) ->
    fun(X) -> X + N end.