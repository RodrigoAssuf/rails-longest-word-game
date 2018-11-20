require "open-uri"
require "json"

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ("A".."Z").to_a.sample }
  end

  def score
    @letters = params[:letters].split
    @word = params[:try_given]
    if @word.upcase.chars.all? { |letter| @word.upcase.count(letter) <= @letters.count(letter) }
      user = api_call(@word)
      @message = "Its not a word!" if user[:found] == false
      @message = "Well done!"
    else
      @message = "Your word is not in the grid!"
    end
  end

  def api_call(word)
  url = "https://wagon-dictionary.herokuapp.com/#{word}"
  user_serialized = open(url).read
  JSON.parse(user_serialized)
  end
end
