#!/usr/bin/env ruby

require 'pry'
# ^all the above is not required - above is just for debugging

require_relative '../phrase_tokenizer/phrase_tokenizer'

class FancyExampleTokenizer < ::Phrase::Tokenizer; end #base inheritance
tokenizer = FancyExampleTokenizer.new("record 55 pushups")

binding.pry
