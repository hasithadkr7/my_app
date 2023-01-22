-module(my_kv_sup).

-export([start/0, kv/0, stop/0]).
-export([init/1]).
-behaviour(supervisor).

start() ->
	supervisor:start_link({local, my_kv_sup}, my_kv_sup, noarg).

kv() ->
	[{kv, Kv, worker, [my_kv]}] = 
		supervisor:which_children(my_kv_sup),
	Kv.

stop() ->
	gen_server:stop(my_kv_sup).

init(noarg) ->
	{ok, {#{}, [#{id => kv, start => {my_kv, start, []}}]}}.

