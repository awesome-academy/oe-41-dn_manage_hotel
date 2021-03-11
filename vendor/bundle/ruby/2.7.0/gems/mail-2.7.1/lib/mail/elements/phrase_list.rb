# encoding: utf-8

require 'mail/parsers/phrase_lists_parser'
require 'mail/utilities'

module Mail
  class PhraseList
    attr_reader :phrases

    def initialize(string)
      @phrases = Mail::Parsers::PhraseListsParser.parse(string).phrases.map { |p| Mail::Utilities.unquote(p) }
    end
  end
end
