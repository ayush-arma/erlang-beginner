-module(counter_server).
-behaviour(gen_server). 

-export([start_link/0, increment/0, reset/0,get_value/0, get_history/0,increment/1]).

-export([init/1, handle_call/3, handle_cast/2]).

start_link()->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

init([])->
    {ok,[0]}.

reset()->
    gen_server:cast(?MODULE, reset).

increment()->
    increment(1).
increment(Step)->
    gen_server:cast(?MODULE, {inc,Step}).

get_value()->
    gen_server:call(?MODULE, first).

get_history()->
    gen_server:call(?MODULE,history).

handle_cast({inc,Step},State=[First|_Rest])->
    NewState=[First+Step|State],
    {noreply,NewState};
handle_cast(reset,_State)->
    {noreply,[0]}.

handle_call(first,_From,State=[First|_Rest])->
    {reply,First,State};
handle_call(history,_From,State)->
    {reply,State,State}.

