class StreamsController < ApplicationController
	require 'will_paginate/array' #required in order for will_paginate to paginate an array instead of an active record
  def index
  	@stream_list = sorted_list_of_streams
	@stream_list = @stream_list.paginate(page: params[:page], per_page:4)
  end
  
  private
  #returns an array of [twitch_names] that are ordered by their viewer count
  def sorted_list_of_streams
  	sorted_stream_list = []
	game_map = sorted_tuple_of_streams_by_viewer
	game_map.each do |stream_name, viewer_count|
		sorted_stream_list.push(stream_name)
	end
	return sorted_stream_list
  end

  #returns an array tuple [twitch_name, viewer_count] sorted by the viewer count
  def sorted_tuple_of_streams_by_viewer
  	game_map = Hash.new
  	games = Twitch.games.top(limit:2)
  	games.each do |game|
		game.streams(limit:4).each do |stream|
			game_map[stream.channel.display_name] = stream.viewer_count
		end
	end
	stream_tuple = game_map.sort_by {|k,v| v}.reverse #map turns into an array here
	return stream_tuple
  end
end
