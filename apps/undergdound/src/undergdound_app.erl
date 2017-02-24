-module(undergdound_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

-include("undergdound.hrl").

%% ===================================================================
%% Application callbacks
%% ===================================================================

start(_StartType, _StartArgs) ->
    undergdound_sup:start_link().

stop(_State) ->
    ok.
