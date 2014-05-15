class StreamsController < ApplicationController
	require 'will_paginate/array' #required in order for will_paginate to paginate an array instead of an active record
  def index
    number_of_streams = 36
    @stream_list ||= []
    @user_game_filter ||= []
    #if the user is not signed in, show all games
    unless user_signed_in?
      #make a list of unique stream names that are sorted by viewer count, ignoring game
      Twitch.streams.all(limit:number_of_streams) do |stream|
        @stream_list.push(stream.channel.name)
      end
    #if the user is signed in, only show the games that they have a preference for
    else
      @stream_list = logged_in_stream_list(number_of_streams)
    end

    #now that we have the stream names, get the stream preview and url
    #this is used in the view
    @stream_preview_and_url_list ||= []
    @stream_list.each do |stream_name|
      s = Twitch.streams.get(stream_name)
      @stream_preview_and_url_list.push([s.preview_url, s.channel.url])
    end

	@stream_preview_and_url_list = @stream_preview_and_url_list.paginate(page: params[:page], per_page:12)
  end

private 
  def logged_in_stream_list number_of_streams
    #when filtering streams, find how many are ignored
    filter_counter = get_correct_number_of_streams(number_of_streams)

    temp_filter_stream_list = []
    #get current user stream list
    user = User.find(current_user)
    @user_game_filter = user.games
    @user_game_filter = @user_game_filter.collect{|x| x.strip.chomp}
    
    Twitch.streams.all(limit:(number_of_streams+filter_counter)) do |stream|
      unless @user_game_filter.include?(stream.game_name)
        temp_filter_stream_list.push(stream.channel.name)
      end 
    end
    return temp_filter_stream_list
  end

  def get_correct_number_of_streams number_of_streams
    count = 0
    Twitch.streams.all(limit:number_of_streams) do |stream|
      if @user_game_filter.include?(stream.game_name)
        count = filter_counter + 1
      end 
    end
    return count
  end
end