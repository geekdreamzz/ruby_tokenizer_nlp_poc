require_relative '../phrase_tokenizer_analyzer'

module PositionsAnalyzer
  include Phrase::Tokenizer::Analyzer

  analyzer priority: 1,
           callback_method_names: [:add_test_intent, :add_test_entity]

  def add_test_intent
    add_intent("Implemented Shared methods #{position}")
  end

  def add_test_entity
    add_entity("Vannak is")
  end
end
