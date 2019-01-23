require 'active_support/concern'
require 'active_support/inflector'

module Phrase
  class Tokenizer
    module Dictionary
      extend ActiveSupport::Concern

      class_methods do
        def entity_types(*args)
          @_dictionary_entities ||= file_paths_for_type('entity', args).map do |path|
            data = JSON.parse(File.read(path))
            EntityType.new(data)
          end
        end

        def intent_types(*args)
          @_dictionary_intents ||= file_paths_for_type('intent', args).map do |path|
            data = JSON.parse(File.read(path))
            IntentType.new(data)
          end
        end

        def phrase_tokenizer_dictionary
          @phrase_tokenizer_dictionary ||= {}
        end

        def file_paths_for_type(type, names)
          if names.length > 1
            file_path_names_for(type, names)
          else
            Dir[File.join(Dir.pwd, 'dictionaries', "*_#{type}.json")]
          end
        end

        def file_path_names_for(type, names)
          names.flatten.map do |name|
            Dir[File.join(Dir.pwd, 'dictionaries', "#{name}_#{type}.json")]
          end.flatten
        end
      end

      class EntityType
        def initialize(args)
          @type = args.keys.first
          @data = args[@type]
          @required_parts_of_speech = @data['required_parts_of_speech']
          @known_entities = @data['known_entities']
        end

        def type
          @type
        end

        def required_parts_of_speech
          @required_parts_of_speech
        end

        def known_entities
          @known_entities
        end

        def entities_for_validation
          @entities_for_validation ||= known_entities.map do |phrase|
            phrase.downcase!
            [phrase.singularize, phrase, phrase.pluralize]
          end.flatten.compact.uniq
        end
      end

      class IntentType
        def initialize(args)
          @type = args.keys.first
          @data = args[@type]
          @required_entities = @data['required_entities']
        end

        def type
          @type
        end

        def required_entities
          @required_entities
        end
      end
    end
  end
end
