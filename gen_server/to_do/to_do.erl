-module(to_do).
-behaviour(gen_server).

%% 1. Client API (Functions you call from the shell)
-export([start_link/0, add_reminder/2, view_reminders/0]).

%% 2. gen_server Callbacks (Functions gen_server calls automatically)
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2]).

%%% ====================================================================
%%% Client API
%%% ====================================================================

start_link() ->
    %% This spawns the background process safely
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

add_reminder(Task, Time) ->
    %% Asynchronous: "Cast" a message to the server
    gen_server:cast(?MODULE, {add, Task, Time}).

view_reminders() ->
    %% Synchronous: "Call" the server and wait for a reply
    gen_server:call(?MODULE, view_all).

%%% ====================================================================
%%% gen_server Callbacks
%%% ====================================================================

init([]) ->
    {ok, #{}}. 

handle_cast({add, Task, Time}, State) ->
    NewState = maps:put(Task, Time, State),
    {noreply, NewState}; 

handle_call(view_all, _From, State) ->
    %% Step 2 & 3: Reply to the client with the current State
    {reply, State, State}; %% {reply, WhatToSendBack, KeepCurrentState}

%% Boilerplate handlers we can ignore for now
handle_info(_Info, State) -> {noreply, State}.
terminate(_Reason, _State) -> ok.