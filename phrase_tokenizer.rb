#!/usr/bin/env ruby

require 'redis'
require 'redis-namespace'
require_relative 'phrase_tokenizer_config'
require_relative 'phrase_tokenizer_token'
require_relative 'phrase_tokenizer_fragment'

module Phrase
  class Tokenizer
    REDIS_CONNECTION = Redis.new
    FRAGMENT_CACHE = Redis::Namespace.new(:fragments, :redis => REDIS_CONNECTION)

    def initialize(phrase, **opts)
      @phrase = phrase
      @phrase.freeze
      tokens unless opts[:init_without_tokens]
      analyze_tokens!
    end

    def phrase
      @phrase
    end

    def fragments
      return @fragments if defined? @fragments
      @fragments = []
      phrase.split(' ').each_with_index do |fragment, index|
        @fragments << Fragment.new(fragment, index)
      end
      @fragments.freeze
    end

    def tokens
      @tokens ||= fragments.map do |fragment|
        (fragment.index..fragments.length - 1).map do |enumerating_index|
          grouped_fragment = grouped_fragments(fragment.index, enumerating_index)
          token_phrase = grouped_fragment_phrase(grouped_fragment)
          Token.new(self, token_phrase, grouped_fragment)
        end.flatten.compact
      end.flatten.compact.freeze
    end

    def analyze_tokens!
      tokens.each(&:execute_analysis)
    end

    def grouped_fragments(start_idx, end_idx)
      (start_idx..end_idx).map do |idx|
        fragments[idx]
      end
    end

    def grouped_fragment_phrase(grouped_fragment)
      grouped_fragment.map(&:phrase).join(' ')
    end

    def token_phrases
      @token_phrases ||= tokens.map(&:phrase)
    end
  end
end
