require_relative '../phrase_tokenizer/phrase_tokenizer_analyzer'

module FragmentsAnalyzer
  include Phrase::Tokenizer::Analyzer
  analyzer priority: 10000000

  def can_be?(pos)
    fragments.map {|f| f.can_be?(pos) }.any?
  end

end