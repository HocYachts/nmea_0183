%%%---- BEGIN COPYRIGHT -------------------------------------------------------
%%%
%%% Copyright (C) 2016, Rogvall Invest AB, <tony@rogvall.se>
%%%
%%% This software is licensed as described in the file COPYRIGHT, which
%%% you should have received as part of this distribution. The terms
%%% are also available at http://www.rogvall.se/docs/copyright.txt.
%%%
%%% You may opt to use, copy, modify, merge, publish, distribute and/or sell
%%% copies of the Software, and permit persons to whom the Software is
%%% furnished to do so, under the terms of the COPYRIGHT file.
%%%
%%% This software is distributed on an "AS IS" basis, WITHOUT WARRANTY OF ANY
%%% KIND, either express or implied.
%%%
%%%---- END COPYRIGHT ---------------------------------------------------------
%%% @author Tony Rogvall <tony@rogvall.se>
%%% @author Malotte W Lönne <malotte@malotte.net>
%%% @copyright (C) 2016, Tony Rogvall
%%% @doc
%%% NMEA 0183 application api.
%%%
%%% File: nmea_183.erl <br/>
%%% Created:  9 Sep 2015 by Tony Rogvall
%%% @end
%%%-------------------------------------------------------------------
-module(nmea_0183).

-include("../include/nmea_0183.hrl").

-export([start/0]).
-export([send/1, send_from/2]).

%% Test api
-export([pause/0, resume/0, ifstatus/0]).
-export([pause/1, resume/1, ifstatus/1]).

-define(ROUTER, nmea_0183_router).

start() ->
    application:start(uart),
    application:start(elarm),
    application:start(nmea_0183).

%%--------------------------------------------------------------------
%% @doc
%% sends data to nmea_0183.
%%
%% @end
%%--------------------------------------------------------------------
-spec send(Message::#nmea_message{}) -> ok | {error, Error::atom()}.

send(Message) ->
    ?ROUTER:send(Message).

%%--------------------------------------------------------------------
%% @doc
%% sends data to nmea_0183.
%%
%% @end
%%--------------------------------------------------------------------
-spec send_from(Pid::pid(), Message::#nmea_message{}) -> 
		  ok | {error, Error::atom()}.

send_from(Pid, Message) ->
    ?ROUTER:send_from(Pid, Message).

%%--------------------------------------------------------------------
%% @doc
%% Pause an interface.
%% @end
%%--------------------------------------------------------------------
-spec pause(If::integer() | string()) -> ok | {error, Reason::term()}.
pause(If) when is_integer(If); is_list(If) ->
    ?ROUTER:pause(If).

-spec pause() -> {error, Reason::term()}.
pause() ->
    {error, interface_required}.

%%--------------------------------------------------------------------
%% @doc
%% Resume an interface.
%% @end
%%--------------------------------------------------------------------
-spec resume(If::integer() | string()) -> ok | {error, Reason::term()}.
resume(If) when is_integer(If); is_list(If) ->
    ?ROUTER:resume(If).
    
-spec resume() -> {error, Reason::term()}.
resume() ->
    {error, interface_required}.

%%--------------------------------------------------------------------
%% @doc
%% Get active status of interface.
%% @end
%%--------------------------------------------------------------------
-spec ifstatus(If::integer() | string()) ->
		      {ok, Status::atom()} | {error, Reason::term()}.
ifstatus(If) when is_integer(If); is_list(If) ->
    ?ROUTER:ifstatus(If).
    
-spec ifstatus() -> {error, Reason::term()}.
ifstatus() ->
    {error, interface_required}.


    
