-module(listt).
-export([rev/1]).
-export([len/1]).
-export([findMax/1]).
-export([sumOfEle/1]).
-export([count_even_odd/1]).
-export([duplicateEach/1]).
-export([checkExist/2]).
-export([removeAllOccurences/2]).



rev(K)->
    rev(K,[]).

rev([],ACC)->
    ACC;
rev([FST|REM],ACC)->
    rev(REM,[FST|ACC]).


len([])->
    0;
len(X)->
    [_|Y]=X,
    1+len(Y).

sumOfEle([])->
    0;
sumOfEle([X|Y])->
    X+sumOfEle(Y).

checkExist(_,[])->false;
checkExist(X, [X|_])->true;
checkExist(X, [_|Z])->checkExist(X, Z).

duplicateEach([])->[];
duplicateEach([X|Y])->
    [X,X|duplicateEach(Y)].

removeAllOccurences(_,[])->[];
removeAllOccurences(X,[X|Y])->removeAllOccurences(X,Y);
removeAllOccurences(X,[H|Y])->[H|removeAllOccurences(X,Y)].

count_even_odd(X) ->
    count_even_odd(X, {0,0}).
count_even_odd([], Count) ->
    Count;
count_even_odd([Y|X], {E,O}) ->
    R = Y rem 2,
    case R of
        1 -> count_even_odd(X, {E, O+1});
        0 -> count_even_odd(X, {E+1, O})
    end.

compare_numbers(A,B)->
    if
        A>B->greater;
        A<B->smaller;
        true->equal
    end.

findMax([])->empty;
findMax([E|X])->findMax(X,E).
findMax([],M)->M;
findMax([E|X],M)->
    RES=compare_numbers(E,M),
    case RES of greater->findMax(X,E);
    _->findMax(X,M)
end.
