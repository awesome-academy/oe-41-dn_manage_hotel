# encoding: utf-8

require 'mail/parsers/content_transfer_encoding_parser'

module Mail
  class ContentTransferEncodingElement
    attr_reader :encoding

    def initialize(string)
      @encoding = Mail::Parsers::ContentTransferEncodingParser.parse(string).encoding
    end
  end
end
