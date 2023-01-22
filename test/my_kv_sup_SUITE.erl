-module(my_kv_sup_SUITE).
-export([test/1, all/0]).

-behaviour(ct_suite).


all() -> [test].

test(_) ->
	{ok, _} = my_kv_sup:start(),
	Kv = my_kv_sup:kv(),
	ok = my_kv:set(a, 1, Kv),
	1 = my_kv:get(a, Kv),
	exit(Kv, kill),
	timer:sleep(100),
	Kv2 = my_kv_sup:kv(),
	false = Kv == Kv2,
	not_found = my_kv:get(a, Kv2),
	ok = my_kv_sup:stop(),
	ok.