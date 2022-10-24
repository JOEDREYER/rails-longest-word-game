require 'open-uri'
require 'nokogiri'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
    @guess = params[:word]
    if @guess.chars.sort.all? { |letter| @letters.include?(letter) }
      @result = "You have used letters from the given letters"
    else
      @result = "You did not use all the letters from the given letters"
    end
    
    if english_word?(@guess)
      @valid = 'Your result is an english word!'
    else
      @valid = 'Your result is not an english word'
    end
  end

  def english_word?(guess)
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{guess}")
    json = JSON.parse(response.read)
    json['found']
  end
end

# The word can’t be built out of the original grid
# The word is valid according to the grid, but is not a valid English word
# The word is valid according to the grid and is an English word