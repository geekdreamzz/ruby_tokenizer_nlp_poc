require_relative '../phrase_tokenizer/phrase_tokenizer_analyzer'

module BaseAnalyzer
  include Phrase::Tokenizer::Analyzer
  analyzer priority: 1000000000

  def intents
    @intents ||= []
  end

  def entities
    @entities ||= []
  end

  def add_intent(intent)
    #TODO validation
    intents << intent
  end

  def add_entity(intent)
    #TODO validation
    entities << intent
  end

  def position
    parent_tokenizer.tokens.index(self)
  end

  def family_count
    parent_tokenizer.tokens.count
  end

  def last_token_index
    family_count - 1
  end

  def splitted_phrase
    @splitted_phrase ||= phrase.split(' ')
  end
end