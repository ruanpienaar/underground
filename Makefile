.PHONY: rel compile get-deps update-deps test clean deep-clean

rel: compile
	@rebar generate -f

compile: get-deps
	@rebar compile

get-deps:
	@rebar get-deps

update-deps:
	@rebar update-deps

test:
	@rebar skip_deps=true apps="undergdound" eunit

clean:
	rm apps/undergdound/ebin/*

deep-clean: clean
	@rebar delete-deps

setup_dialyzer:
	dialyzer --build_plt --apps erts kernel stdlib mnesia compiler syntax_tools runtime_tools crypto tools inets ssl webtool public_key observer
	dialyzer --add_to_plt deps/*/ebin

doc:
	rebar skip_deps=true doc
	for app in $(APPS); do \
		cp -R apps/$${app}/doc doc/$${app}; \
	done;

analyze: checkplt
	@rebar skip_deps=true dialyze

buildplt:
	@rebar skip_deps=true build-plt

checkplt: buildplt
	@rebar skip_deps=true check-plt