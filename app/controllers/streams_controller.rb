class StreamsController < ApplicationController
	require 'will_paginate/array' #required in order for will_paginate to paginate an array instead of an active record
  def index
    number_of_streams = 48
    @stream_list ||= []
    @user_game_filter ||= []
    #store a bunch of streams, to speed up the page and lower the number of total calls
    @streams = Twitch.streams
    #if the user is not signed in, show all games
    unless user_signed_in?
      #make a list of unique stream names that are sorted by viewer count, ignoring game
      @streams.all(limit:number_of_streams).each do |stream|
        @stream_list.push(stream.channel.name)
      end
    #if the user is signed in, only show the games that they have a preference for
    else
      user = User.find(current_user)
      @user_game_filter = user.games
      #get the user's game preferences
      @user_game_filter = @user_game_filter.collect{|x| x.strip.chomp}

      #add streams that are not filtered by the user's preference until the size of the stream_list equals number_of_streams
      @streams.all(limit:number_of_streams*5).each do |stream|
        unless @user_game_filter.include?(stream.game_name)
          @stream_list.push(stream.channel.name)
        end
        break if @stream_list.length >= number_of_streams #this ensures that the same number of streams will be shown when logged in and logged out
      end
    end

    #now that we have the stream names, get the stream preview and url
    #this is used in the view
    @stream_preview_and_url_list ||= []
    @stream_list.each do |stream_name|
      s = @streams.get(stream_name)
      @stream_preview_and_url_list.push([s.preview_url, s.channel.url])
    end

  #paginate the list for the view
	@stream_preview_and_url_list = @stream_preview_and_url_list.paginate(page: params[:page], per_page:16)
  end
end