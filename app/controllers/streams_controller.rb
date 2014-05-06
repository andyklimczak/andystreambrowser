class StreamsController < ApplicationController
	require 'will_paginate/array'
  def index
  	@game_map = Hash.new
  	@stream_list = []
  	@games = Twitch.games.top(limit:5)
  	@games.each do |game|
		game.streams(limit:8).each do |stream|
			@game_map[stream.channel.display_name] = stream.viewer_count
		end
	end
	@game_map = @game_map.sort_by {|k,v| v}.reverse
	@game_map.each do |stream_name, viewer_count|
		@stream_list.push(stream_name)
	end
	@stream_list = @stream_list.paginate(page: params[:page], per_page:20)
  end
end
