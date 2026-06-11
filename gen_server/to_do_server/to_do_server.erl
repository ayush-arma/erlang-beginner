-module(to_do_server).
-behaviour(gen_server). 


-export([start_link/0,list_tasks/0,remove_task/1,add_task/1,complete_task/1]).

-export([init/1, handle_call/3, handle_cast/2]).


start_link()->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

init([])->
    {ok,#{}}.

list_tasks()->
    gen_server:call(?MODULE, get_all).

remove_task(Id)->
    gen_server:cast(?MODULE,{remove,Id}).

add_task(Task)->
    gen_server:cast(?MODULE,{add_task,Task}).

complete_task(Id)->
    gen_server:cast(?MODULE,{complete,Id}).

handle_call(get_all,_From,State)->
    {reply,State,State}.

handle_cast({remove,Id},State)->
    NewState=maps:remove(Id, State),
    {noreply,NewState};
handle_cast({add_task,Task},State)->
    NewID = erlang:unique_integer([monotonic]),
    NewState=State#{NewID=>Task},
    {noreply,NewState};
handle_cast({complete,Id},State)->
       NewState=maps:remove(Id, State),
    {noreply,NewState}.


