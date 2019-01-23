require_relative '../phrase_tokenizer/phrase_tokenizer_analyzer'

module EntitiesAnalyzer
  include Phrase::Tokenizer::Analyzer

  analyzer priority: 1000

  def entity_types
    @entity_types ||= parent_tokenizer.class.entity_types
  end

  def token_entities
    entity_types.map do |entity_type|
      if entity_type.entities_for_validation.include?(phrase)
        entity = Struct.new(:type, :phrase)
        entity.new(entity_type.type, phrase)
      end
    end.compact
  end

  def fragments_entities
    fragments.map(&:entities_and_parts_of_speech).flatten
  end

  def token_and_fragment_entities
    token_entities | fragments_entities
  end
end
