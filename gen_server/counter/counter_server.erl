-module(counter_server).
-behaviour(gen_server). %% Tells the compiler this module implements gen_server callbacks

%% Client API
-export([start_link/0, increment/0, get_value/0]).

%% gen_server Callbacks
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).

%% ===================================================================
%% Client API Implementation
%% ===================================================================

%% Starts and links the server process to the active supervision tree
start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

%% Asynchronous cast to increment the internal counter
increment() ->
    gen_server:cast(?MODULE, increment).

%% Synchronous call to safely fetch the current counter value
get_value() ->
    gen_server:call(?MODULE, get_value).

%% ===================================================================
%% gen_server Callback Implementations
%% ===================================================================

%% Sets up the initial structural state of the server
init([]) ->
    InitialState = 0,
    {ok, InitialState}.

%% Handles synchronous call requests (returns a reply to the caller)
handle_call(get_value, _From, State) ->
    {reply, State, State}; %% {reply, ReplyValue, NewState}

handle_call(_Request, _From, State) ->
    {reply, ok, State}.

%% Handles asynchronous cast messages (updates state without replying)
handle_cast(increment, State) ->
    {noreply, State + 1}; %% {noreply, NewState}

handle_cast(_Msg, State) ->
    {noreply, State}.

%% Catches all raw unhandled Erlang process messages 
handle_info(_Info, State) ->
    {noreply, State}.

%% Invoked when the server process shuts down to execute cleanup tasks
terminate(_Reason, _State) ->
    ok.

%% Enables dynamic state upgrades during live production code changes
code_change(_OldVsn, State, _Extra) ->
    {ok, State}.
