class StreamsController < ApplicationController
  require 'will_paginate/array'
  def index
    @stream_list = []

    #get unfiltered streams for non logged in user
    unless user_signed_in?
      number_of_streams = 48
      Twitch.streams.all(limit:number_of_streams) do |stream|
        @stream_list.push([stream.preview_url, stream.channel.name, stream.game_name])
      end
      @stream_list = @stream_list.paginate(page:params[:page], per_page:16)
    #use User preferences and get a filtered list of streams
    else
      #get the user's preferences
      user_filter = User.find(current_user).games
      user_filter = user_filter.map{|x| x.name}
      user_streams_per_page = User.find(current_user).number_of_streams_per_page
      user_stream_pages = User.find(current_user).number_of_stream_pages
      #go through top streams, adding streams to the list only if they aren't filtered by the user
      Twitch.streams.all(limit:user_streams_per_page*user_stream_pages*5) do |stream|
        unless user_filter.include?(stream.game_name)
          @stream_list.push([stream.preview_url, stream.channel.name, stream.game_name])
        end
        break if @stream_list.length >= user_streams_per_page*user_stream_pages #limit the total number of streams to the list
      end
      @stream_list = @stream_list.paginate(page:params[:page], per_page:user_streams_per_page)
    end
  end

  def embed
    @stream_name = params[:stream_name]
  end
end