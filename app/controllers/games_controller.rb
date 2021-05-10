require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(10).join
  end

  def score
    guess = params[:word]
    letters = params[:letters]
    @answer = if check?(guess, letters) == false
                "Sorry but #{guess} can't be built out of the original grid"
              elsif english_word?(guess) == false
                "Sorry but #{guess} does not seem to be a valid English word."
              else
                "Congratulations! #{guess} is a valid English word!"
              end
  end

  private

  def check?(word, letters)
    word.all?{ |letter| word.count(letter) <= @letters.count(letter)}
  end

  def english_word?(word)
    result = URI.open("https://wagon-dictionary.herokuapp.com/#{word}").read
    JSON.parse(result)["found"]
  end
end
