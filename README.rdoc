# readme

## why I made this

This website allows you to browse streams in a visual format, where streams are sorted by viewer, irregardless of game.

On the website, Twitch allows you to browse streams by game, where games are sorted by viewer count. But there is not a way to view all streams by viewer count irregradless of games. So this is aimed toward users who want to see what are the most popular current live streams on Twitch. 

Registration allows for users to filter out games, that they always want to not see.

## api

I use the Twitch 'Kappa' rails api in order to access Twitch stream/channel information. 

## authentication (devise)

Devise is used to handle authentication. I customized the model and added a ':games' attribute to store all the games that the user would like to filter out.

The games are presented in a multiselect element in the user registration/edit views. I initially tried using checkbox elements, but that would use too much screen space trying to present 100 games with associated checkboxes. Then I decided to use a simple text field, where each game would be entered by the user and seperated by a comma. This worked, but was not user friendly. Then I figured out how to use multiple select boxes.

## Paging (will_paginate)

Pagination was rather straight forward to add to the page. Calling these GETS by virtual box took a little while, so that is why the page size is so small.

## user interface (bootstrap)

I've had some familiarity with bootstrap used for a past class project. I applied as many simple bootstrap 'tricks' as I could throughout the pages, but because the pages are so minimal, not much I could add I feel.

Also, my use of bootstrap and interesting html design is lacking, so I need to learn more about that.

## unit tests (rspec)

I have two simple set of tests (spec/controllers/streams_controller_spec.rb & spec/models/user_spec.rb) that test the basic functionality of the pages and interactions. 