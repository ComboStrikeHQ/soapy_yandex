# frozen_string_literal: true
module SoapyYandex
  class Response
    attr_reader :xml

    def initialize(xml)
      @xml = xml
    end

    def success?
      attributes[:status].to_i.zero?
    end

    def error?
      attributes[:status].to_i == 3
    end

    def error_code
      attributes[:error].to_i
    end

    def attributes
      doc.nodes.first.attributes
    end

    private

    def doc
      @doc ||= Ox.parse(xml)
    end
  end
end
