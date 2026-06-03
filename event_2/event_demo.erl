-module(event_demo).

-export([
    start_server/0,
    subscribe/1,
    add_event/2,
    cancel_event/1
]).

%%% =========================
%%% Public API
%%% =========================

start_server() ->
    register(event_server,
             spawn(fun() ->
                 server_loop([], #{})
             end)).

subscribe(ClientPid) ->
    event_server ! {subscribe, ClientPid}.

add_event(Name, DelaySeconds) ->
    event_server ! {add_event, Name, DelaySeconds}.

cancel_event(Name) ->
    event_server ! {cancel_event, Name}.

%%% =========================
%%% Event Process
%%% =========================

event_process(Server, Name, Delay) ->
    receive
        cancel ->
            io:format("~p cancelled~n", [Name])
    after Delay * 1000 ->
        Server ! {event_done, Name}
    end.

%%% =========================
%%% Event Server
%%% =========================

server_loop(Subscribers, Events) ->
    receive

        {subscribe, ClientPid} ->
            io:format("Subscriber added: ~p~n", [ClientPid]),
            server_loop([ClientPid | Subscribers], Events);

        {add_event, Name, Delay} ->
            Pid = spawn(fun() ->
                event_process(self(), Name, Delay)
            end),

            io:format(
                "Event ~p scheduled after ~p seconds~n",
                [Name, Delay]
            ),

            server_loop(
                Subscribers,
                maps:put(Name, Pid, Events)
            );

        {cancel_event, Name} ->
            case maps:find(Name, Events) of
                {ok, Pid} ->
                    Pid ! cancel,
                    server_loop(
                        Subscribers,
                        maps:remove(Name, Events)
                    );

                error ->
                    io:format("No such event: ~p~n", [Name]),
                    server_loop(Subscribers, Events)
            end;

        {event_done, Name} ->
            io:format("EVENT FIRED: ~p~n", [Name]),

            lists:foreach(
                fun(Client) ->
                    Client ! {notification, Name}
                end,
                Subscribers
            ),

            server_loop(
                Subscribers,
                maps:remove(Name, Events)
            )
    end.