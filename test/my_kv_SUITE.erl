-module(my_kv_SUITE).
-export([test/1, all/0]).

-behaviour(ct_suite).


all() -> [test].

test(_) ->
	{ok, Kv} = my_kv:start(),
	not_found = my_kv:get(a, Kv),
	ok = my_kv:set(a, 1, Kv),
	1 = my_kv:get(a, Kv),
	ok = my_kv:set(a, 2, Kv),
	2 = my_kv:get(a, Kv),
	not_found = my_kv:get(b, Kv),
	ok = my_kv:stop(Kv),
	ok.
