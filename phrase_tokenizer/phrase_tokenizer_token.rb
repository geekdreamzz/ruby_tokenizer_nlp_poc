module Phrase
  class Tokenizer
    class Token
      def initialize(parent_tokenizer, phrase, fragments, **args)
        @parent_tokenizer = parent_tokenizer
        @phrase = phrase
        @fragments = fragments
        validate_args
        load_analyzers!
      end

      def parent_tokenizer
        @parent_tokenizer
      end

      def phrase
        @phrase
      end

      def fragments
        @fragments
      end

      def analyzers
        @analyzers.sort_by!{|a| a.priority }.reverse!
      end

      def load_analyzers!
        @analyzers = ::Phrase::Tokenizer::Config.phrase_token_analyzers.map do |analyzer|
          self.class.include analyzer
          analyzer
        end
      end

      def execute_analysis
        analyzers.each do |analysis|
          analysis.callback_method_names.each do |method_name|
            public_send(method_name)
          end
        end
      end

      def validate_args
        raise ArgumentError.new("Parent Tokenizer must be of class - Phrase::Tokenizer") unless parent_tokenizer.is_a? Phrase::Tokenizer
        raise ArgumentError.new("Phrase must be of class - String") unless phrase.is_a? String
      end
    end
  end
end
