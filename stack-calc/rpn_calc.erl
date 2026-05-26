-module(rpn_calc).
-export([calc/1]).

calc(Str) ->
    Tokens = string:tokens(Str, " "),
    Stack = eval_tokens(Tokens, []),
    case Stack of
        [Result] -> Result;
        _ -> {error, invalid_expression}
    end.

eval_tokens([], Stack) ->
    Stack;

eval_tokens(["+" | Rest], [B, A | Stack]) ->
    eval_tokens(Rest, [A + B | Stack]);

eval_tokens(["-" | Rest], [B, A | Stack]) ->
    eval_tokens(Rest, [A - B | Stack]);

eval_tokens(["*" | Rest], [B, A | Stack]) ->
    eval_tokens(Rest, [A * B | Stack]);

eval_tokens(["/" | Rest], [B, A | Stack]) ->
    eval_tokens(Rest, [A div B | Stack]);

eval_tokens([Token | Rest], Stack) ->
    case string:to_integer(Token) of
        {Int, ""} ->
            eval_tokens(Rest, [Int | Stack]);
        _ ->
            {error, {invalid_token, Token}}
    end.