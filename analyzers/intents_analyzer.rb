require_relative '../phrase_tokenizer/phrase_tokenizer_analyzer'

module IntentsAnalyzer
  include Phrase::Tokenizer::Analyzer

  analyzer priority: 1,
           callback_method_names: [:scored_intents]

  def intent_types
    @intent_types ||= parent_tokenizer.class.intent_types
  end

  def scored_intents
    @scored_intents ||= intent_types.map do |intent_type|
      results = intent_type.required_entities.map do |required_entity|
        {
            entity: required_entity,
            match: token_and_fragment_entities.select do |entity|
              entity.type == required_entity
            end
        }
      end
      matches = results.select{|r| r[:match].length > 0 }
      score = (matches.length.to_f / results.length.to_f ) * 100
      {
          score: score,
          results: results,
          intent_type: intent_type.type,
          token: self
      }
    end
  end
end
