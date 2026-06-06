-module(counter_server).
-behaviour(gen_server). %% Tells the compiler this module implements gen_server callbacks

-export([start_link/0, increment/0, get_value/0]).

-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).


start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

increment() ->
    gen_server:cast(?MODULE, increment).

get_value() ->
    gen_server:call(?MODULE, get_value).
init([]) ->
    InitialState = 0,
    {ok, InitialState}.

handle_call(get_value, _From, State) ->
    {reply, State, State}; 
handle_call(_Request, _From, State) ->
    {reply, ok, State}.

handle_cast(increment, State) ->
    {noreply, State + 1};  

handle_cast(_Msg, State) ->
    {noreply, State}.

handle_info(_Info, State) ->
    {noreply, State}.

terminate(_Reason, _State) ->
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.
