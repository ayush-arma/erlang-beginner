-module(greeter).
-export([make_greeter/1]).
-export([pow/1]).


make_greeter(X)->
    fun()-> X end.

pow(X)->
    fun(N)->
        power_helper(X,N)
    end.

power_helper(_,0)->1;
power_helper(X, Arg2)->X*power_helper(X, Arg2-1).