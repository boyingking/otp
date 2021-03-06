%%
%% %CopyrightBegin%
%%
%% Copyright Ericsson AB 2008-2016. All Rights Reserved.
%%
%% Licensed under the Apache License, Version 2.0 (the "License");
%% you may not use this file except in compliance with the License.
%% You may obtain a copy of the License at
%%
%%     http://www.apache.org/licenses/LICENSE-2.0
%%
%% Unless required by applicable law or agreed to in writing, software
%% distributed under the License is distributed on an "AS IS" BASIS,
%% WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
%% See the License for the specific language governing permissions and
%% limitations under the License.
%%
%% %CopyrightEnd%
%%

%%
%%----------------------------------------------------------------------
%% Purpose: The top supervisor for the ssh application.
%%----------------------------------------------------------------------
-module(ssh_sup).

-behaviour(supervisor).

-export([init/1]).

%%%=========================================================================
%%%  Supervisor callback
%%%=========================================================================
init(_) ->
    SupFlags = #{strategy  => one_for_one, 
                 intensity =>   10,
                 period    => 3600
                },
    ChildSpecs = [#{id       => Module,
                    start    => {Module, start_link, []},
                    restart  => permanent,
                    shutdown => 4000, %brutal_kill,
                    type     => supervisor,
                    modules  => [Module]
                   }
                  || Module <- [sshd_sup,
                                sshc_sup]
                 ],
    {ok, {SupFlags,ChildSpecs}}.

