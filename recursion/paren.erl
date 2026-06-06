-module(paren).
-export([valid/1]).

valid(S) ->
    valid(S, []).

valid([], []) ->
    true;

valid([], _) ->
    false;

valid([$( | Rest], Stack) ->
    valid(Rest, [$( | Stack]);

valid([$) | Rest], [$( | Stack]) ->
    valid(Rest, Stack);

valid([$) | _], []) ->
    false.