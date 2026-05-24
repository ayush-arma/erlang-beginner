-module(mapp).
-export([freqCount/1]).
-export([grpOddEven/1]).
-export([flipMapp/1]).
-export([merge/2]).




% checkPresent(E|T)->
%     case 

freqCount(LISTT)->freqCount(LISTT,#{}).

freqCount([],Map)->Map;
freqCount([E|LIST],Map)->
    Value=maps:get(E,Map,0),
    NewMap=maps:put(E,Value+1,Map),
    freqCount(LIST, NewMap).
        

        %mapp:freqCount([a,a,a,a,a,a,b,b,b,c,c,c,c,d,e,f,r,w,w,w,wwww]).

merge(Map1, Map2)->
    Keys=maps:keys(Map2),
    merge(Map1,Map2,Keys).

merge(Map1,_Map2,[])->
    Map1;
merge(Map1,Map2,[K|LISTT])->
    Value2=maps:get(K,Map2),
    Value1=maps:get(K,Map1,0),
    NewMap1=Map1#{K => Value1+Value2},
    merge(NewMap1,Map2,LISTT).


%mapp:merge(    #{a => 2, b => 3},    #{a => 5, c => 1}).


grpOddEven(List)->
    grpOddEven(List,#{}).
grpOddEven([],Map)->
    Map;
grpOddEven([K|List],Map)->
    if
        K rem 2 == 0 ->
            Arr=maps:get(even, Map, []),
            Arr2=[K|Arr],
            Map2=Map#{even=>Arr2},
            grpOddEven(List,Map2);
        true->
            Arr=maps:get(odd, Map, []),
            Arr2=[K|Arr],
            Map2=Map#{odd=>Arr2},
            grpOddEven(List,Map2)
        end.


flipMapp(Map1)->
    Keys=maps:keys(Map1),
    flipMapp(Map1,#{},Keys).
flipMapp(_Map,Map2,[])->
    Map2;
flipMapp(Map,Map2,[K|Keys])->
    Val=maps:get(K,Map),
    NewMap2=Map2#{Val=>K},
    flipMapp(Map,NewMap2,Keys).

%mapp:flipMapp(#{    alice => 90,    bob => 72,    carol => 85}).





