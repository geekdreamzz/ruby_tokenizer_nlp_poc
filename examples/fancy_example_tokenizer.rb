#!/usr/bin/env ruby

require 'pry'
# ^all the above is not required - above is just for debugging

require_relative '../phrase_tokenizer'

class FancyExampleTokenizer < ::Phrase::Tokenizer; end #base inheritance
tokenizer = FancyExampleTokenizer.new("add 10 reps of 225 to bench press")

binding.pry
