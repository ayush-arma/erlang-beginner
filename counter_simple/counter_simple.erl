
-module(counter_simple).

-export([counter/0]).

counter() ->
    loop(0).

loop(State) ->
    receive
        increment ->
            loop(State + 1);

        {get, From} ->
            From ! State,
            loop(State)
    end.