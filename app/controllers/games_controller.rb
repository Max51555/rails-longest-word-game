require 'json'
require 'open-uri'

class GamesController < ApplicationController

  def score
    #end_time = Time.now

    @word = params[:longword]
    @grid = params[:grid]
    @include = include?(@word, @grid)
    @english_word = english_word?(@word)
  end

  def new
    @letters = ('a'..'z').to_a.sample(8)
    #@start_time = Time.now
  end

  def english_word?(word)
    response = "https://wagon-dictionary.herokuapp.com/#{word}"
    check_word = open(response).read
    user = JSON.parse(check_word)
    user['found']
  end

  def include?(word, letters)

    array = []
    word.split.each do |letter|
     array << (word.count(letter) <= letters.count(letter))
    end
    if array.include?(false)
      return false
    else
      return true
    end
  end
end
