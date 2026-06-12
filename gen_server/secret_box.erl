-module(secret_box).
-behaviour(gen_server). %% Tells Erlang this is a gen_server template

%% Client Interface
-export([start/0, store/1, read/0]).

%% gen_server Callbacks
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2]).

%%% ====================================================================
%%% CLIENT FUNCTIONS (Runs in your shell)
%%% ====================================================================

start() ->
    %% Starts a background process named 'my_box'
    gen_server:start_link({local, my_box}, ?MODULE, [], []).

store(Secret) ->
    %% Fire-and-forget: Tell 'my_box' to change its state to the Secret
    gen_server:cast(my_box, {store_secret, Secret}).

read() ->
    %% Synchronous call: Ask 'my_box' what it is holding and wait for it
    gen_server:call(my_box, get_secret).


%%% ====================================================================
%%% SERVER CALLBACKS (Runs automatically in the background process)
%%% ====================================================================

init([]) ->
    %% Our initial state is the atom 'nothing' because the box is empty
    {ok, nothing}. 

handle_cast({store_secret, NewSecret}, _OldState) ->
    %% We replace the OldState with the NewSecret. 
    %% 'noreply' means don't talk back to the client.
    {noreply, NewSecret};
handle_cast({test,_NewSecret}, __OldState)->
    {noreply,ok}.

handle_call(get_secret, _From, CurrentState) ->
    %% 'reply' means send an answer. 
    %% Syntax: {reply, WhatToSendBack, WhatTheNewStateShouldBe}
    {reply, CurrentState, CurrentState}.


%% Standard boilerplate that gen_server requires to compile
handle_info(_Info, State) -> {noreply, State}.
terminate(_Reason, _State) -> ok.