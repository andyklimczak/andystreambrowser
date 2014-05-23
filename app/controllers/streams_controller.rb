class StreamsController < ApplicationController
  require 'will_paginate/array'
  def index
    number_of_streams = 64
    @stream_list = []

    #get unfiltered streams for non logged in user
    unless user_signed_in?
      Twitch.streams.all(limit:number_of_streams) do |stream|
        @stream_list.push([stream.preview_url, stream.channel.name])
      end
    #use User preferences and get a filtered list of streams
    else
      #get the user's preferences
      user_filter = User.find(current_user).games.collect{|x| x.strip.chomp}
      #go through top streams, adding streams to the list only if they aren't filtered by the user
      Twitch.streams.all(limit:number_of_streams*5) do |stream|
        unless user_filter.include?(stream.game_name)
          @stream_list.push([stream.preview_url, stream.channel])
        end
        break if @stream_list.length >= number_of_streams #limit the total number of streams to the list
      end
    end
    @stream_list = @stream_list.paginate(page:params[:page], per_page:16)
  end

  def embed
    @stream_name = params[:stream_name]
  end
end