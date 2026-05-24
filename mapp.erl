-module(mapp).
-export([freqCount/1]).




% checkPresent(E|T)->
%     case 

freqCount(LISTT)->freqCount(LISTT,#{}).

freqCount([],Map)->Map;
freqCount([E|LIST],Map)->
    Value=maps:get(E,Map,0),
    NewMap=maps:put(E,Value+1,Map),
    freqCount(LIST, NewMap).
        

        %mapp:freqCount([a,a,a,a,a,a,b,b,b,c,c,c,c,d,e,f,r,w,w,w,wwww]).
