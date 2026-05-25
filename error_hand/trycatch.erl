-module(trycatch).
-export([safe_divide/2]).

safe_divide(X, Y) ->
    try X / Y of
        Result -> {ok, Result}
    catch
        error:badarith -> 
            {error, division_by_zero};
        Class:Reason:Stack ->
            {error, {caught, Class, Reason, Stack}}
    end.