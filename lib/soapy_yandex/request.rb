# frozen_string_literal: true
module SoapyYandex
  class Request
    attr_reader :api_path

    def initialize(api_path, name, attributes)
      @api_path = api_path
      @name = name
      @attributes = attributes
    end

    def to_s
      Ox.dump(xml, with_xml: true)
    end

    private

    attr_reader :name, :attributes

    def xml
      Ox::Document.new(version: '1.0', encoding: 'UTF-8').tap do |doc|
        doc << node_with_attributes(name, attributes.merge(default_attributes))
      end
    end

    def default_attributes
      {
        requestDT: DateTime.now.to_s,
        clientOrderId: SecureRandom.hex(12)
      }
    end

    def node_with_attributes(name, attributes)
      Ox::Element.new(name).tap do |node|
        attributes.each do |key, value|
          node[key] = value
        end
      end
    end
  end
end
