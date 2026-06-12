-module(traffic_light).

-behaviour(gen_statem).

-export([start_link/0]).
-export([red/3, green/3, yellow/3]).
-export([callback_mode/0,init/1,terminate/3,code_change/4]).


start_link()->
    gen_statem:start_link({local, ?MODULE}, ?MODULE, [], []).


callback_mode() -> state_functions.

init(_Anything) ->
    {ok, red, #{}, [{state_timeout, 5000, change}]}.

red(EventType, EventContent, Data) ->
    io:format("params received = ~p ~p ~p~n", [EventType, EventContent, Data]),
    {keep_state,Data}.
green(EventType, EventContent, Data)->
    io:format("~p ~p~n", [EventType, EventContent]),
    {keep_state,Data}.
yellow(EventType, EventContent, Data)->
    io:format("~p ~p~n", [EventType, EventContent]),
    {keep_state,Data}.  

terminate(_,_,_)->
    {ok,terminate}.

code_change(_,_,_,_)->
    {ok,codechange}.



