-module(closure_prac).
-export([make_subtractor/1]).


make_subtractor(X)->
    fun(N)->N-X end.
