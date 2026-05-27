-module(rpn_calc).
-export([calc/1]).

calc(Str) ->
    Tokens = string:tokens(Str, " "),
    Stack = calc(Tokens, []),
    case Stack of
        [Result] -> Result;
        _ -> {error, invalid_expression}
    end.

calc([], Stack) ->
    Stack;

calc(["+" | Rest], [B, A | Stack]) ->
    calc(Rest, [A + B | Stack]);

calc(["-" | Rest], [B, A | Stack]) ->
    calc(Rest, [A - B | Stack]);

calc(["*" | Rest], [B, A | Stack]) ->
    calc(Rest, [A * B | Stack]);

calc(["/" | Rest], [B, A | Stack]) ->
    calc(Rest, [A div B | Stack]);

calc([Token | Rest], Stack) ->
    case string:to_integer(Token) of
        {Int, ""} ->
            calc(Rest, [Int | Stack]);
        _ ->
            {error, {invalid_token, Token}}
    end.